---
title: Pages person Free
layout: default
icon: free.png
---
Pour un compte ***account*** ➡️ site web www.***account***.free.fr

# Connexion FTP

* Host: ftpperso.free.fr
* Login: *\<account\>*
* Password: **idem connexion au site subscribe.free.fr**

# Admin MySQL
* url: sql.free.fr
* login: \<account\>
* password: **password défini pour la BDD MySQL. Différent du mdp du compte. Est géré depuis le site subscribe.free.fr**

# Connexion à la BDD MySQL
* DB Server: sql.free.fr
* DB name: \<account\> (remplacer les . par des _)
* DB login: \<account\>
* DB password: **password défini pour la BDD MySQL**

# Options du site
## Dans le fichiers `.htaccess` à la racine du ftp
* php 1 : activer php 5.1
* php56 1 : activer php v5.6

## Dans un fichier .html
* `<?php phpinfo(); ?>` : connaitre la version de php installée
