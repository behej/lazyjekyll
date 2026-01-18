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

## Autres options de rclone
Dans le cas où on ne veut pas synchroniser l'intégralité du dossier gdrive, Rclone permet des commandes plus fines
* `rclone ls <nom_remote>:directory/`: liste les fichiers présents et leur taille dans le dossier indiqué
* `rclone lsf <nom_remote>:directory/`: liste les fichiers présents dans le dossier indiqué. Le format de sortie est particulièrement adapté pour ensuite faire du parsing sur la liste des fichiers
* `rclone copyto <nom_remote>:directory/file dest/dir/`: copy un ficher de la source vers la destination indiqué


# Afficher les photos
## Option fbi
**fbi** (FrameBuffer Imageviewer) est un utilitaire qui permet de s'interfacer directement avec le framebuffer sans requérir de serveur graphique.

```sh
# Installation
sudo apt install -y fbi

# Afficher une image
sudo fbi -d /dev/fb0 -T 1 -a --noverbose -1 /path/to/image.jpg

# Afficher un diaporama
sudo fbi -d /dev/fb0 -T 1 -a --noverbose -1 /path/to/folder/*
sudo fbi -d /dev/fb0 -T 1 -a --noverbose -1 /path/to/image1.jpg /path/to/image2.jpg ...
sudo fbi -d /dev/fb0 -T 1 -a --noverbose -1 -l /path/to/list.txt

# Quitter proprement fbi
sudo killall -QUIT fbi
sudo pkill -QUIT fbi
sudo pkill -QUIT -f fbi

# Force le vidage de framebuffer
sudo dd if=/dev/zero of=/dev/fb0 bs=1024 count=7680

# Affiche un message sur le terminal depuis ssh
echo "Test" | sudo tee /dev/tty1
# L'utilisation de "sudo tee" car l'utilisateur ssh n'a pas le droit d'écrire directement dans /dev/tty1
```

* sudo: requit parce qu'on veut accéder à `/dev/fb0`, ce qui requiert des privilèges.
* -d: device. On veut afficher sur `/deb/fb0` qui correspond généralement à l'écran branché en HDMI
* -T 1: démarre sur la console virtuelle #1
* -a: autozoom
* --noverbose: n'affiche pas le bandeau avec les détails de la photo en bas d'écran
* -t <duration>: durée pendant laquelle affichée la photo avant de passer à la suivante
* -l <list_file>: Utilise un fichier texte qui contient la liste des images à afficher


## Option mpv
**mpv** est un player vidéo. Dans le cas présent il est détourné pour le faire afficher des photos.

```sh
mpv --vo=drm  --image-display-duration=inf -v /path/to/pic.jpg
```

Dans le cas du diaporama, on va le lancer d'une façon un peu différente. Le logiciel mpv va se lancer mais rester en attente. Et on va lui envoyer quelle photo afficher par un message *ipc* (Inter-Process Communication).
```sh
mpv --idle --input-ipc-server=/tmp/mpv-socket --fullscreen --vo=drm --osd-level=0
```

Le but de cette manoeuvre était de tenter de supprimer le glitch qui apparaissait avec **fbi** (la console était brièvement affichée entre 2 photos avec les logs qui apparaissaient).

Dans la pratique, bien que compliquée, cette méthode fonctionnait plutôt bien. Mais quelque photos n'arrivaient pas à être affichées correctement. Ces mêmes photos s'affichaient bien avec un appel direct à mpv. Je n'ai jamais réussi à comprendre ce qui ne marchait pas bien.

## Option feh

Requiert un serveur graphique minimal.


# Preprocessing des photos
## Reduction de la taille des images
Pour cela, on utilise un outil de retouche d'image en ligne de commande bien connu: **imagemagick**.

```sh
# Installation
sudo apt install -y imagemagick

# Réduction de la résolution des images
convert "/path/to/pic.jpg" -resize "1024x600" -quality 80 -strip "/path/to/dest/file.jpg"
# -resize: change la résolution
# -quality: baisse la qualité
```


# Installation d'un service
Créer un fichier `diaporama.service` dans le dossier `/etc/systemd/system/` et y copier les lignes ci-dessous (les adapter).


```sh

[Unit]
Description=Photo slideshow service
After=multi-user.target

[Service]
User=<user>
WorkingDirectory=/home/<user>/
ExecStart=/usr/bin/python3 /path/to/script.py
Restart=always
RestartSec=10
Environment=PYTHONUNBUFFERED=1

[Install]
WantedBy=multi-user.target
```

Activer le service:
```sh
sudo systemctl daemon-reload
sudo systemctl enable diaporama.service
```

Redémarrer le rpi ou démarrer le service manuellement avec `sudo systemctl start diaporama.service`


# Rechargement de la liste des photos
Principe de fonctionnement:
1. Le diaporama est lancé automatiquement au démarrage du rpi. Il liste toutes les photos présentes dans un dossier et les affiche successivement.
2. Périodiquement (chaque nuit), un script de synchro est lancé:
   1. Il récupère les nouvelles photos depuis gdrive et supprime celles qui ont été supprimées
   2. Il redimensionne les photos et les place dans le dossier utilisé par le diaporama

Afin que le diaporama prenne en compte la nouvelle liste de photos, il faut sigaler au diaporama qu'il doit se mettre à jour une fois que la synchro a été effectuée.

Pour cela, on utilise le mécanisme des signaux entre processes.
* On envoie un signal `HUP` au diaporama
* le signal est récupéré et déclenche une nouveau scan des photos à afficher

## Envoyer un signal
```sh
sudo pkill -HUP -f diaporama.py
```

## Ecouter le signal depuis python
```python
import signal

def handler_signal(signum, frame):
    do_sommething()

signal.signal(signal.SIGHUP, handler_signal)
```