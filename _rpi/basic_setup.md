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


# Options au démarrage

Editer le fichier `/boot/firmware/cmdline.txt` et modifier les options selon l'effet souhaité
* console=serial0,115200: Configure un terminal sur liaison série. Utile pour du deboggage.
* console=tty3: Redirige la console sur tty3. Par défaut, c'est tty1 qui est utilisé. Concrètement, cela a pour effet de rediriger la console vers un terminal non affiché et donc masquer les messages
* consoleblank=0: empêche l'écran de s'éteindre en cas d'inactivité
* vt.global_cursor_default=0: désactive le curseur clignottant sur le terminal
* fsck.repair=yes: demande la vérification du disque en cas de coupure de courant
* rootwait: attend que la carte SD soit bien prête avant de monter le filesystem
* logo.nologo: supprime l'affichage du logo (les framboises) au boot
* quiet: supprime la grande majorité des messages d'information du noyau au démarrage
* loglevel=0: Défini le niveau de criticité max des logs à afficher (0=urgence / 1=alerte / 2=critical / 3=error / 4=warning / 5=notice / 6=info / 7=debug)
* systemd.show_status=false: empêche systemd d'afficher la liste des services démarrés
* rd.udev.log_level=0: idem ci-dessus mais pour des phases de démarrage plus précoce
* rd.systemd.show_status=false: idem


