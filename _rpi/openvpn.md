---
title: OpenVPN
layout: default
icon: openvpn.png
---
# Préambule
* On va utiliser le service OpenVPN pour créer le serveur
* pour gérer les clés et les certificats, on va utiliser **Easy-RSA** (l'utilitaire qui est installé avec OpenVPN)
* On va scripter la génération du fichier de configuration pour les clients. Ainsi, il suffira de générer une clé et un certificat pour chaque client, puis de générer le fichier de configuration unique .ovpn à l'aide du script
* Le fonctionnement du VPN dépend également de la configuration du firewall pour les règles de transfert du trafic.

## Fonctionnement des clés et certificats
* Il faut tout d'abord une autorité de certification - ***CA*** (avec sa clé privée qu'il ne faut surtout pas partager)
* Les serveur et chaque client possèdent une clé privée et un certificat
* Pour créer un certificat, il faut:
  * Créer une requête de certification
  * Envoyer cette requête au CA, qui va la signer avec sa clé privée et ainsi générer le certificat.

# Mise en place du serveur
## Installation
* Installation
  * OpenVPN est installé dans `/etc/openvpn`
  * Easy-RSA est installé dans `/usr/share/easy-rsa`
```sh
sudo apt-get install openvpn
```

* Copier easyrsa dans le home
```sh
mkdir ~/openvpn
cp /usr/share/easyrsa/* ~/openvpn
```


## Initialisation & création de la CA
* Initialisation de l'infrastructure de clés (PKI)
```sh
./easyrsa init-pki
```

* Création de la CA
  * Il est recommandé de définir une passphrase pour la CA
  * donner un nom explicite à la CA (ex: rpi-ca)
  * Cette commande génère 2 fichiers: la clé privée du CA (`pki/private/ca.key`) et le certificat de la CA (`pki/ca.crt`)
    * la clé privée servira à signer les certificats des serveurs et des clients. ⚠️ **Elle ne doit surtout pas être partagée**
    * le certificat sera partagé avec les serveurs et les clients. Il servira à s'assurer qu'on peut faire confiance à l'autre.

```sh
./easyrsa build-ca
```

## Création des fichiers pour le serveur
* Création d'une requête de certificat
  * Choisir un nom explicite pour l'instance
  * l'option `nopass` indique qu'on ne souhaite pas de passphrase pour accéder à la clé privée
  * Cette commande génère 2 fichiers: une clé privée (`pki/private/rpivon.key`) et une demande de certificat (`pki/reqs/rpivpn.req`)
```sh
./easyrsa gen-req rpivpn nopass
```

* Signature du certificat
  * cette commande signe la requête de certificat avec la clé privée de la CA
  * elle génère un certificat pour le serveur (`pki/issued/rpivpn.crt`)
  * Etant donné qu'on utilise la clé privée de la CA pour signer le certificat, il faut saisir la passphrase de la clé ca.key
```sh
./easyrsa sign-req server rpivpn
```

* Création de la clé Diffie-Hellman
  * cette commande créer une clé Diffie-Hellman (`pki/dh.pem`)
```sh
./easy-rsa gen-dh
```

* Création d'une clé pour le secret partagé
```sh
openvpn --genkey --secret ta.key
```

## Mise en place des fichiers sur le serveur
* copier les fichiers suivants dans le dossier openvpn
  * ca.crt
  * rpivpn.key
  * rpivpn.crt
  * ta.key
  * dh.pem

## Configuration du service
* Copier le fichier [server.conf]({{site.url}}/assets/files/server.conf) dans le dossier `/etc/openvpn/` (on peut renommer ce fichier selon le nom du serveur, ex *rpivpn.conf*)
* Editer le fichier pour modifier les lignes suivantes

```sh
tls-auth ta.key 0 # This file is secret
...
cipher AES-256-CBC
auth SHA256     ; ligne à ajouter juste après la directive cipher
...
dh dh.pem
...
user nobody
group nogroup
...
port 1194    ; 1194 port par défaut mais peut être modifié
...
proto udp    ; généralement UDP. Peut être modifié en TCP mais nécessite d'autres réglages
...
cert rpivpn.crt     ; certificat du serveur
key rpivpn.key      ; clé privée du serveur
...
push "redirect-gateway def1 bypass-dhcp"    ; Décommenter cette ligne pour forcer les client à utiliser le VPN
```

* Démarrer le service
```sh
sudo systemctl start openvpn@rpivpn    // le nom du fichier de conf juste après le '@'
```
* vérifier que le service fonctionne correctement
```sh
sudo systemctl status openvpn@rpivpn
```

## Modification de la configuration réseau
> **Hypothèse:** le firewall utilisé est UFW

* Editer le fichier `/etc/sysctl.conf`
* Décommenter la ligne suivante
```sh
net.ipv4.ip_forward=1
```
* Recharger la configuration avec la commande suivantee:
```sh
sudo sysctl -p
```
* Définir l'interface réseau par défaut (en général wlan0 ou eth0)
```sh
ip route | grep default
```
* Editer le fichier `/etc/ufw/before.rules`
* Ajouter les lignes suivantes en début de fichier:
```sh
# START OPENVPN RULES
# NAT table rules
*nat
:POSTROUTING ACCEPT [0:0]
# Allow traffic from OpenVPN client to wlan0 (change to the default interface!)
-A POSTROUTING -s 10.8.0.0/8 -o wlan0 -j MASQUERADE
COMMIT
# END OPENVPN RULES
```
* Editer le fichier `/etc/default/ufw`
* Changer la valeur du champ `DEFAULT_FORWARD_POLICY` de `DROP` vers `ACCEPT`
```sh
DEFAULT_FORWARD_POLICY="ACCEPT"
```
* Autoriser le trafic entrant sur le port 1194
```sh
sudo ufw allow 1194/ucp
```
* Redémarrer le firewall
```sh
sudo ufw reload
```

# Création configuration des clients
Les étapes suivantes ont pour objectif de déclarer et créer des clients autorisés sur le VPN. Les actions ci-dessous s'effectuent *sur le serveur**

## Création des clés/certificats client
* Création d'une requête de certificat
  * Cette commande crée un fichier de requête (`pki/reqs/dje.req`) et une clé privée (`pki/private/dje.key`)
```sh
./easyrsa gen-req dje nopass
```
* Signature de la requête (par la CA)
  * Cette commande crée le certificat (`pki/issued/dje.crt`)
```sh
./easyrsa sign-req client dje
```

## Création du fichier de configuration client
Cette étape est particulière car au lieu de créer manuellement tous les fichiers de configuration des clients, on va les générer automatiquement. On va même générer un unique fichier qui contient toutes les infos nécessaire (c'est tout de même plus simple que de manipuler plusieurs fichiers)
* Créer un dossier particulier sur le serveur exemple dans notre home (dans l'exemple ci-dessous, nous appelons ce dossier clients/
  * Créer également un sous dossier `clients/keys/` (qui contiendra toutes les clés privées et les certificats de nos clients)
  * Créer un sous-dossier `clients/files/`
* Copier les fichiers nécessaires dans le dossier `keys/`
  * les fichiers .crt et .key générés pour un client
  * les fichier ca.crt et ta.key du serveur
* Copier le fichier [client.conf]({{site.url}}/assets/files/client.conf) dans le dossier clients/. Le renommer `base.conf`
* Editer le fichier `/clients/base.conf` et modifier les lignes suivantes
```sh
remote <your_server_ip> 1194    ; Si on est derrière une box ou un routeur, on configurera ici l'adresse IP de la box (ou un nom de domaine)
...
proto udp
... 
user nobody
group nogroup
...
#ca ca.crt         ; Ces lignes sont commentées car les clés et certificats correspondants seront ajoutés en dur dans le fichier par notre script
#cert client.crt
#key client.key
...
#tls-auth ta.key 1    ; idem
...
cipher AES-256-CBC
auth SHA256       ; Ajouter cette ligne juste sous le cipher
...
key-direction 1   ; ligne à ajouter également
...
# script-security 2            ; Ces lignes sont présentes pour les client Linux qui possèdent un fichier /etc/openvpn/update-resolv-conf. On décommentera ces lignes dans ce cas précis. On les laisse commentées dans les autres cas.
# up /etc/openvpn/update-resolv-conf
# down /etc/openvpn/update-resolv-conf
```

* Créer un script `clients/make_config.sh`

```sh
#!/bin/bash

# First argument: Client identifier

KEY_DIR=keys
OUTPUT_DIR=files
BASE_CONFIG=base.conf

cat ${BASE_CONFIG} \
    <(echo -e '<ca>') \
    ${KEY_DIR}/ca.crt \
    <(echo -e '</ca>\n<cert>') \
    ${KEY_DIR}/${1}.crt \
    <(echo -e '</cert>\n<key>') \
    ${KEY_DIR}/${1}.key \
    <(echo -e '</key>\n<tls-auth>') \
    ${KEY_DIR}/ta.key \
    <(echo -e '</tls-auth>') \
    > ${OUTPUT_DIR}/${1}.ovpn
```

* exécuter le script en indiquant le nom du client (qui doit être le même nom que la clé privée du client)

```sh
./make_config.sh dje
```
* Récupérer le fichier de configuration généré `clients/files/dje.ovpn`

## Procédure simplifiée
* Créer une clé privée et une requête pour un client donné
```sh
./easyrsa gen-req <name> nopass
```
* Signer la clé et ainsi générer un certificat
```sh
./easyrsa sign-req client <name>
```
* Copier la clé et le certificat dans le dossier du script
```sh
cp pki/private/<name>.key clients/keys/
cp pki/issued/<name>.crt clients/keys/
```
* Générer le fichier de configuration
```sh
./make_config.sh <name>
```
* Récupérer le fichier de configuration <name>.ovpn
```sh
cp clients/files/<name>.ovpn where/you/want/
```

# Côté client
Récupérer le fichier .ovpn généré à l'étape précédente et le transférer sur l'appareil à connecter.

## Ubuntu
* Installer OpenVPN (si pas déjà présent)
* si le script `/etc/openvpn/update-resolv-conf` est présent
  * Editer le fichier .ovpn pour décommenter les lignes suivantes
```sh
script-security 2
up /etc/openvpn/update-resolv-conf
down /etc/openvpn/update-resolv-conf
```
* Se connecter au VPN avec la commande suivante:
```sh
sudo openvpn --config <name>.ovpn
```


## Android
* Installer l'appli OpenVPN
* Configurer une connexion en indiquant le fichier de configuration

# Biblio
* [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-18-04-fr#%C3%A9tape-6-ajustement-de-la-configuration-r%C3%A9seau-du-serveur](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-18-04-fr#%C3%A9tape-6-ajustement-de-la-configuration-r%C3%A9seau-du-serveur)
* [https://github.com/OpenVPN/openvpn/blob/master/sample/sample-config-files/server.conf](https://github.com/OpenVPN/openvpn/blob/master/sample/sample-config-files/server.conf)
* [https://github.com/OpenVPN/openvpn/blob/master/sample/sample-config-files/client.conf](https://github.com/OpenVPN/openvpn/blob/master/sample/sample-config-files/client.conf)
* [https://wiki.archlinux.org/index.php/OpenVPN#Firewall_configuration](https://wiki.archlinux.org/index.php/OpenVPN#Firewall_configuration)
* [https://openclassrooms.com/forum/sujet/openvpn-ne-change-pas-mon-ip-1](https://openclassrooms.com/forum/sujet/openvpn-ne-change-pas-mon-ip-1)
