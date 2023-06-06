---
title: Sysadmin Linux
layout: default
icon: linux.png
---
# Commandes courantes
## Gestion des process
* ps : affiche tous les processus du terminal en cours
  * ps u : affiche le nom de l'utilisateur
  * ps a : affiche les processus de tous les utilisateurs (uniquement ceux liés à un terminal - sauf si option x)
  * ps x : affiche tous les processus (même ceux non liés à un terminal)
  * ps o : spécifie les champs à affichage. *ex:* `ps o user:20,pid,start,time,cmd`

## Gestion des disques
* du \<folder\> : Disque Usage - liste tous le fichiers et leur taille dans le dossier indiqué
  * du -d*n* : limite la profondeur du scan à *n*
  * du -s : affichage l'espace total utilisé
  * du -h : affiche la taille en *human readable* (ko, Mo, Go, etc.)
* df : affiche les disques montés et les espaces occupés/libres
  * option -h : Human readable

## Gestion des utilisateurs et des droits
* adduser \<user\> : Ajoute un utilisateur
  * adduser \<user\> \<group\> : Ajoute l'utilisateur au groupe
* deluser \<user\>
* addgroup \<group\> : Ajoute un groupe
* delgroup \<group\> : Efface un groupe
* groups: affiche les groupe de l'utilisateur courant
  * groups \<user\>: affiche les groupe de l'utilisateur spécifié
  * la liste de tous les groupes existant est accessible dans le fichier /etc/group
  * la liste de tous les utilisateurs existants est accessibles dans le fichier /etc/passwd
* chown : change le propriétaire d'un fichier ou dossier
  * chown \<user\>:\<group\> fichier
  * chown -R : récursif
* chmod : modifie les permissions sur un fichier
  * chmod \<777\> \<file\>\|\<directory\>
  * chmod +x \<file\> : Ajoute les droits d'exécution à tout le monde (peut également être r pour read ou w pour write)
  * chmod -x \<file\> : Retire les droits d'exécution à tout le monde
  * chmod u+x \<file\> : Ajoute les droits d'exécution à l'utilisateur
    * **u** pour User, **g** pour Group et **o** pour Other
    * **\+** pour ajouter les droits et **-** pour retirer les droits
    * **r** pour Read, **w** pour Write et **x** pour eXecute
    * les dossier doivent nécessairement être **x** pour être browsés


# Réseau
## UFW
**UFW** (**U**ncomplicated **F**ire**W**all) est un utilitaire simplifié de configuration du firewall.
* ufw app list : Affiche la liste des applications connues
* ufw allow \<app\> : Autorise l'application indiquée (trouvée grâce à la commande précédente) - Ex: ufw allow WWW
* ufw allow \<port\>/\<protocol\> : Autorise le protocol (tcp/udp) sur le port indiqué. Ex: ufw allow 80/tcp
* ufw deny|reject \<app\> : Rejete les connexions indiquées. Deny ne laisse pas passer les paquets correspondants tandis que Reject retourne un message d'erreur à l'initiateur de la connexion.
* ufw enable : active le firewall
* ufw disable : désactive le firewall
* ufw reload : recharge la nouvelle configuration

# Services
Gérer les services
* sudo service \<nom du service\> start/restart/status/stop
* sudo systemctl start/status/restart/stop \<nom du service\>
* la commande **service** est une commande de plus haut niveau qui peut elle-même faire appel à la commande *systemctl* ou une autre commande selon l'implémentation
* la commande **systemctl** est une commande de plus bas niveau qui offre plus de possiblités

# Journaux système
## systemd
systemd est un daemon d'init du system (généralement PID 1). Il est en charge de démarrer les autres démons et services.
Toute appli démarrée à l'aide de systemd (via une commande systemctl) voit ses sorties standard (stdout et stderr) redirigées vers journald.

> *Bibliographie:* [https://guillaume.fenollar.fr/blog/journald-tutoriel-journald-journalctl/](https://guillaume.fenollar.fr/blog/journald-tutoriel-journald-journalctl/)


## dmesg
* dmesg (pour display messages) permet d'afficher les messages du kernel linux. Utile pour le boot du système ou lorsqu'on connecte/déconnecte un device.
* on peut écrire des message dans les logs kernel: `echo "mesage" > /dev/kmsg`

# Divers
* free -h : Affiche la mémoire dispo sur le système
* cat /sys/class/thermal/thermal_zone0/temp : Affiche la température CPU (en m°C)
