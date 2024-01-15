---
title: Sysadmin Linux
layout: default
icon: linux.png
---
# Commandes courantes
## Gestion des paquets
* sudo apt install \<paquet\> : installe le paquet indiqué
  * option -y : accepte automatiquement l'installation (utile pour ne pas avoir besoin d'intervention utilisation dans scripts)
* apt-file search \<lib/bin\> : indique quel(s) paquet(s) installer pour obtenir la lib ou le binaire indiqué
  * nécessite l'installation du paquet `apt-file` et d'avoir exécuter précédemment la commande `sudo apt-file update`
  * fonctionne probablement avec n'importe quel type de fichier
## Gestion des process
* ps : affiche tous les processus du terminal en cours
  * ps u : affiche le nom de l'utilisateur
  * ps a : affiche les processus de tous les utilisateurs (uniquement ceux liés à un terminal - sauf si option x)
  * ps x : affiche tous les processus (même ceux non liés à un terminal)
  * ps o : spécifie les champs à affichage. *ex:* `ps o user:20,pid,start,time,cmd`

## 💽 Gestion des disques
* du \<folder\> : Disque Usage - liste tous le fichiers et leur taille dans le dossier indiqué
  * du -d*n* : limite la profondeur du scan à *n*
  * du -s : affichage l'espace total utilisé
  * du -h : affiche la taille en *human readable* (ko, Mo, Go, etc.)
* df : affiche les disques montés et les espaces occupés/libres
  * option -h : Human readable

## 👥 Gestion des utilisateurs et des droits
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


> 📚 *Biblio*: [https://doc.ubuntu-fr.org/mount_fstab](https://doc.ubuntu-fr.org/mount_fstab)

 
### Montage automatique
Pour un montage automatique au démarrage du PC, ajouter les lecteurs à monter ainsi que les options dans le fichier `/etc/fstab`.

> ✏️ **Note:** Le montage des lecteurs sera alors effectué par un service en tant que root. 

```sh
192.168.0.xxx:/media/	/media/nas-media	nfs	defaults,auto,nofail,noatime,bg	0	0
192.168.0.xxx:/Documents/	/media/nas-doc	nfs	defaults,auto,nofail,noatime,bg	0	0
```

`mount -a` : Effectue tous les montages décrits dans le fichier *fstab*.




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
## Créer un service
Créer un fichier myService.service à un des emplacements suivants:
* /etc/systemd/system - pour que service s'exécute au démarrage du système
* /etc/systemd/user - pour que le service s'exécute à la connexion de n'importe quel utilisateur
* ~/.config/systemd/user/ - pour que le service s'exécute à la connexion d'un utilisateur spécifique

```sh
[Unit]
Description=Description du service
After=network.target other_service.service
Before=<idem after mais avant>
Wants=<service à démarrer avant. Dépendance faible, ie le service démarre même si la dépendance échoue>
Requires=<idem Wants mais dépendance dure. ie le service ne démarrera pas si la dépendance a échoué>

[Service]
Type=simple / forking / oneshot / notify / dbus / idle -> généralement simple ou idle
User=<optionnel - user spécifique pour exécuter le service>
Group=<optionnel - group spécifique pour exécuter le service>

Environment=MY_VAR=my_value

ExecStartPre=<commande à exécuter avant ExecStart>
ExecStartPre=<on peut en mettre plusieurs>
ExecStart=<commande à exécuter pour le service>
ExecReload=<optionnel - commande à exécuter en cas de redémarrage du service>
ExecStartPost=<commande à exécuter après ExecStart>

Restart=no / on-success / on-failure / on-abnormal / on-watchdog / on-abort / always
RestartSec=3

[Install]
WantedBy=multi-user.target
ou
RequiredBy=<idem WantedBy mais en dépendance dure>
```
La section **[Install]** est utilisée pour le démarrage automatique du service (avec la commande `enable`). Indique l'état du système qui va essayer de démarrer le service en automatique. Généralement `multi-user.target` - le système est booté et attend qu'un utilisateur se logge.

### Dépendances
Pour les options *After*, *Before*, *Wants*, *Requires*, on peut spécifier des dépendances sur
* un autre service -- Extension `.service`. Exemple: myService.service
* un état du système atteint durant la phase de boot -- Extension `.target`. Exemple: network.target
  * poweroff.target : éteint
  * rescue.target
  * multi-user.target : le système est démarré, les utilisateurs peuvent se connecter en non graphique
  * graphical.target : la partie graphique est démarrée
  * network.target : le réseau est prêt

Pour les options *WantedBy* et *RequiredBy*, on se limite habituellement aux targets

> **Biblio**
> * https://www.malekal.com/creer-service-linux-systemd/
> * https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html
> * https://www.baeldung.com/linux/systemd-target-multi-user

## Gérer les services

* sudo service \<nom du service\> start/restart/status/stop
* sudo systemctl start/status/restart/stop \<nom du service\>
* sudo systemctl enable/disable \<nom du service\> : active/désactive le démarrage automatique du service
* la commande **service** est une commande de plus haut niveau qui peut elle-même faire appel à la commande *systemctl* ou une autre commande selon l'implémentation
* la commande **systemctl** est une commande de plus bas niveau qui offre plus de possiblités
* systemctl list-units : liste tous les services
* systemctl list-units -type=target/service/socket: liste tous les services du type indiqué



# Journaux système
## systemd
systemd est un daemon d'init du system (généralement PID 1). Il est en charge de démarrer les autres démons et services.
Toute appli démarrée à l'aide de systemd (via une commande systemctl) voit ses sorties standard (stdout et stderr) redirigées vers journald.

> 📚 *Bibliographie:* [https://guillaume.fenollar.fr/blog/journald-tutoriel-journald-journalctl/](https://guillaume.fenollar.fr/blog/journald-tutoriel-journald-journalctl/)


## dmesg
* dmesg (pour display messages) permet d'afficher les messages du kernel linux. Utile pour le boot du système ou lorsqu'on connecte/déconnecte un device.
* on peut écrire des message dans les logs kernel: `echo "mesage" > /dev/kmsg`


# Hardware

* `lspci`: Liste tous les périphériques PCI
* `lsusb`: Liste tous les périphériques USB
* `lshw`: Liste les périphériques matériel
  * `lshw -C <categorie>`: Filtre par catégorie (ex: *lshw -C network*)
* `lsmod`: Liste les modules du kernel qui sont chargés (mise en forme du fichier */proc/modules*)

# Divers
* free -h : Affiche la mémoire dispo sur le système
* cat /sys/class/thermal/thermal_zone0/temp : Affiche la température CPU (en m°C)

