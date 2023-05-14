---
title: Linux
layout: default
icon: linux.png
---
# Général
## Description du filesystem
|Dossier|Usage|
|---|---|
|/bin|Binaires essentiels pour le fonctionnement de l'OS|
|/boot/|Fichiers nécessaires au démarrage du système (inclus le kernel)|
|/dev/|Devices. Tous les périphériques sont représentés ici en tant que fichier texte|
|/etc/|Fichiers de configuration de différents aspects de l'OS ou de programmes|
|/home/|Répertoires home de tous les utilisateurs|
|/lib|Shared libraries pour bin et sbin|
|/opt/|Pour les programmes optionnels. Rarement besoin de naviguer dedans|
|/proc/|Processes. Ne correspond pas à de vrais fichiers ou des périphérique, mais est créé à la volée par l'OS pour tracker tous les processes exécutés.|
|/root/|Répertoire home de root|
|/sbin|System binaries. Binaires essentiellement destinés à être utilisé par root|
|/tmp/|Dossier temporaire. Est effacé à chaque redémarrage du système|
|/usr/bin/|Binaires destinés à l'utilisateur final de la machine|
|/usr/local/bin/|Binaires compilés manuellement et non gérés par le gestionnaire de paquets|
|/var/|Variables files. Fichiers utilisés par l'OS et les app pour stocker des infos en cours d'utilisation.|




# Réseau
## Associer des noms à des adresses IP

Permet de donner des noms à des IP du réseau local (plus simple de retenir un nom qu'une IP)
* fichier `/etc/hosts`

```sh
192.168.0.xxx	nas
192.168.0.yyy	raspberry4
```

## Montage de lecteurs réseau
### Prérequis
Nécessite l'installation d'utilitaires NFS si montage NFS.
```sh
sudo apt install nfs-common
```
*Note:* Cela va installer l'utilitaire `/sbin/mount.nfs`

### Montage
La commande `mount` permet de monter un lecteur (USB, réseau, etc.) vers un point de montage n'importe où dans le filesystem. Néanmoins, les montages se feront généralement dans `/media/`.

Le dossier sur lequel sera monté le lecteur doit préalablement exister (dans l'exemple ci-dessous, le dossier `stock` doit exister).

```sh
sudo mount -t [type] -o [options] /dev/sdc3 /media/stock
```

|Option|Signification|
|---|---|
|defaults|paramètres de montage par défaut (équivalent à `rw,suid,dev,exec,auto,nouser,async`)|
| rw | Lecture/Ecriture |
| ro | Read-only |
|exec/noexec|	Autorise l'exécution des programmes (par défaut)|
|users|permet à n'importe quel utilisateur de monter/démonter le système de fichiers (cela implique noexec,nosuid,nodev).|
|nouser|autorise seulement le compte root à monter le fichier système (par défaut). **Note:** si le montage est effectué par un service (ex dans fichier fstab), il sera nécessairement monté en tant que root. Cette option n'empêche donc pas les utilisateurs d'avoir un lecteur monté sur leur session. |
|auto|le système de fichiers sera monté automatiquement au démarrage, ou quand la commande `mount -a` sera jouée|
| nofail|si la partition n'est pas disponible au démarrage, elle n'est pas montée et ne bloque pas le démarrage|
|noatime|ne pas mettre à jour la date d'accès sur l'inode pour le système de fichier|
|bg|Montage en arrière plan. Si le montage échoue, le process parent continue et des retry sont effectués en arrière-plan|


*Biblio*: https://doc.ubuntu-fr.org/mount_fstab

## Montage automatique
Pour un montage automatique au démarrage du PC, ajouter les lecteurs à monter ainsi que les options dans le fichier `/etc/fstab`.

**Note:** Le montage des lecteurs sera alors effectué par un service en tant que root. 

```sh
192.168.0.xxx:/media/	/media/nas-media	nfs	defaults,auto,nofail,noatime,bg	0	0
192.168.0.xxx:/Documents/	/media/nas-doc	nfs	defaults,auto,nofail,noatime,bg	0	0
```


