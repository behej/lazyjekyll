---
title: CUPS
layout: default
icon: cups.png
---
> 💡 CUPS: Common Unix Printing System


# Principe
* L'imprimante est connecté au RPi en USB
* Le RPi est conecté au réseau
* Les autres PC du réseau impriment au travers du RPi

👍 **Avantages:**
* Si l'imprimante est vieille et n'a plus de drivers sur les Windows modernes, il y a qd meme de fortes chances qu'elle soit toujours reconnues par Linux
* Passer par le RPi permet alors aux Windows d'imprimer qd meme sur l'imprimante, au travers du RPi et sans se soucier des drivers

# Procédure
## Côté RPi
### Installation de CUPS
* Mise à jour du système: `sudo aptitude update && sudo aptitude full-upgrade`
* Installation de CUPS: `sudo aptitude install cups`
* on ajoute l'utilisateur pi au groupe lpadmin (le groupe qui a le droit de gérer les imprimantes): `sudo usermod -a -G lpadmin pi`
  * -a pour append (fonctionne uniquement avec l'option -G)
  * -G ajoute le groupe
* on autorise l'administration à distance: `sudo cupsctl --remote-any` (pas sur que ça soit utile)
* on redémarre le service: `sudo /etc/init.d/cupsd restart`
* on doit maintenant pouvoir se connecter à une page d'administration de CUPS: `http://<adresse_du_RPi>:631`

### Installation de l'imprimante

* se connecter à l'interface d'administration CUPS : `http://<adresse_RPi>:631`
* onglet administration, cliquer sur "**add printer**"
  * si un login/password est demandé, utiliser le login/password de l'utilisateur Pi (comme on l'a ajouté au groupe lpadmin, il a le droit d'administrer CUPS)
* L'imprimante est normalement disponible et est affichée dans la liste.
* Cliquer sur "**continue**" et configurer l'imprimante.
  * ne pas oublier de cocher la case pour partage l'imprimante

## Côté Windows
* Ajouter une imprimante avec l'option: "**Sélectionner une imprimante partagée par nom**"
* indiquer l'adresse: `http://<adresse_du_RPi>:631/printers/<nom_de_limprimante>`
  * Le nom de l'imprimante est celui visible dans l'interface CUPS: onglet printers, champs "Queue name"
* une popup demande de sélectionner le fabricant et le modèle de l'imprimante.
* si le modèle ne figure pas dans cette liste, sélectionner:
  * Fabricant: Microsoft
  * Modèle: Microsoft IPP Class Driver


# Informations diverses
* Lors de l'installation, j'ai également installé le service SAMBA sur le RPi. Il semblerait que ce dernier ne soit pas nécessaire.
  * En effet, il est possible d'imprimer soit via Samba (qui est un vieux protocole), soit via IPP (qui est plus récent)
  * l'installation du driver Microsoft IPP choisit de fait l'utilisation du protocole IPP


# Bibliographie
* [https://www.mrbinr.com/2017/08/11/transformer-raspberry-pi-serveur-dimpression](https://www.mrbinr.com/2017/08/11/transformer-raspberry-pi-serveur-dimpression)
* [https://techno.firenode.net/article.sh?id=d20171216085929940](https://techno.firenode.net/article.sh?id=d20171216085929940)
* [https://wiki.archlinux.org/index.php/CUPS/Printer_sharing](https://wiki.archlinux.org/title/CUPS/Printer_sharing#Linux_server_-_Windows_client)
