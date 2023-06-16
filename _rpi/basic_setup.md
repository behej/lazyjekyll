---
title: Basic setup
layout: default
icon: raspberrypi.png
---
# Basic setup
* Activer le ssh : créer un fichier ssh dans la partition boot de la carte SD
* Interface de configuration: `sudo raspi-config`
* Authentification par clés
  * sur le client ssh, ssh-keygen pour générer une paire de clés
  * copier la clé publique sur le rpi
  * concaténer toutes les clés autorisées dans le fichier `~/.ssh/authorized_keys`
