---
title: Cadre photo
layout: default
icon: camera.png
---
# Présentation
On va faire un cadre photo connecté sur lequel on peut uploader des photos depuis n'importe où et le cadre va afficher un diaporama avec toutes ces photos.

La base est un Raspberry Pi avec un écran. L'affichage des photos est réalisé directement en utilisant framebuffer, c'est à dire pas besoin de serveur graphique X ni de distribution Linux lourde avec desktop.

Le transfert de photo est assuré par Google Drive. Un dossier drive sert d'hébergement pour les photos. L'intérêt est qu'on peut partager le dossier très facilement et que n'importe qui ayant un accès au partage peut ajouter des photos.

La synchro entre Google Drive et le Raspberry est assurée par ***rclone***, petit utilitaire permettant de se connecter à divers stockages en ligne et de récupérer les photos.

# Config de base
Un Raspberry avec un OS lite (sans desktop, ni serveur graphique), un écran.


# Synchro Google Drive avec Rclone
## Installation
 
```sh
sudo apt install rclone
```

## Configuration
**sur le Rpi**

Lancer l'assistant de configuration avec:
```sh
rclone config
```

Renseigner les différentes questions comme suit:
1. n: new remote
2. name: <nom_remote>
3. 18: Google drive
4. client_id: leave empty
5. client_secret: leave empty
6. 2: read only*
7. service_account_file: leave empty
8. advanced config: no
9. auto config: no

A ce moment, rclone a besoin de se connecter au compte Google et de demander les autorisations d'accès. Cette étape se réalise avec un navigateur Web, chose qu'on n'a pas sur le RPi. Rclone donne les indications nécessaires et indique une commande du genre: `rclone authorize "drive" "nsqdkjcnsdjknksn" ` à tapier dans un PC avec navigateur internet.

**sur le PC**

1. Taper la commande `rclone authorize "drive"` sur un PC avec un navigateur internet.

Rclone ouvre un navigateur et demande d'autoriser la connexion au compte Google drive.

Autoriser l'accès: le navgateur affiche un message de sucès et demande de retourner dans rclone.

Rclone indique un token d'accès qu'il faut copier/coller sur le raspberry

**sur le RPi**

Poursuivre la configuration en renseignant le token obtenu sur le PC

1. config_token: <le token obtenu>
2. shared drive: no
3. config completed. Keep this drive: yes
4. q: quit config

### Test
On peut tester la connexion en listant les dossiers présents sur Google Drive avec la commande
```sh
rclone ls <nom_remote>:
```

## Synchroniser GDrive avec un dossier local
1. Créer un dossier sur le RPi qui va stocker les photos: `/home/pi/pictures/`
2. Créer un dossier dans Google Drive pour y déposer les photos: `photoframe/`
3. Synchroniser le dossier local avec Google Drive:
```sh
rclone sync <nom_remote>:photoframe/ /home/pi/pictures/
```

## Planifier une synchro régulière
la commande de synchro doit être appelée régulièrement. On peut réaliser cela très facilement avec cron.

```sh
crontab -e
```

```sh
*/10 * * * * /usr/bin/rclone sync <nom_remote>:photoframe/ /home/pi/pictures/
```

