---
title: Wiki
layout: default
icon: mediawiki.png
---
# Descriptif
le Wiki est ensemble de pages PHP en liaison avec une base SQL qui permet aux utilisateurs de modifier le contenu des pages.

Pour fonctionner le Wiki à besoin:
* d'un serveur web (type Apache)
* une base SQL
* un interpréteur PHP


La démarche décrite ci-dessous consiste à:
* installer un WAMP[^1] en local
* créer le Wiki en local
* migrer le tout vers le serveur (par exemple les pages perso Free)

[^1]: WAMP = **W**indows **A**pache **M**ySQL **P**hp. L'équivalent sous Linux s'appellera **LAMP**

> ⚠️ **Important:** En cas d'utilisation de l'espace Free, il faut se limiter à la version 1.16.5 de MediaWiki

# Installation et configuration d'un Wiki
## Pré-requis:
* un serveur web: on utilisera [Apache](http://httpd.apache.org/)
* un système de gestion de base de données: on utilisera [MySQL](http://www.mysql.com/)
* un moteur [PHP](http://php.net/my.php)


On peut trouver sur le net des installations complètes qui comprennent tout ces composants (et éventuellement d'autres dont PHPMyAdmin - utile pour gérer votre base de données).

On retiendra:
* [EasyPHP](http://www.easyphp.org/)
* [XAMPP](http://www.apachefriends.org/fr/xampp.html)

Pour ma part, j'ai choisi EasyPHP.

> 📅 Le 15/09/2013, la dernière version stable était la 13.1 VC11. Elle intégrait Apache 2.4.4, MySQL 5.6.11, PHP 5.5.0 et phpMyAdmin 4.0.3. On notera qu'il ne s'agit pas des dernières versions disponible de chaque composant puisque on peut trouver Apache 2.4.6, MySQL 5.6.13, PHP 5.5.3 et phpMyAdmin 4.0.6. EasyPHP prévenait d'ailleurs que la version de MySQL était buggée et qu'il était nécessaire de migrer vers la 5.6.12 (l'install de la mise à jour était fourni sur le site d'EasyPHP)

## Installation de Mediawiki
J'ai choisi d'utiliser Mediawiki parce que c'est sans doute le plus utilisé et aussi le moteur de Wikipédia.
* Télécharger [Mediawiki](http://www.mediawiki.org/wiki/MediaWiki)
* Décompresser les fichiers et le copier dans un répertoire accessible du serveur (dans le cas d'EasyPHP, "EasyPHP/data/localweb/projects" par exemple)
* Se connecter au Wiki avec un navigateur internet [http://127.0.0.1/projects/](http://127.0.0.1/projects/)
* Mediawiki détecte automatiquement qu'il s'agit de la première installation et propose un assistant d'installation (depuis la version 1.2 de Mediawiki).
* Suivre les différentes étapes de l'assistant avec les options suivantes:
  * Nom de la base: renseigner le même nom que votre base Free
  * Préfixe utilisé pour les tables: `wiki_`
* A la fin, un fichier localSettings.php est créé. Ce fichier contient toutes les options configurées.
* Récupérer ce fichier localSettings.php afin de le modifier pour l'adapter au serveur final

> ✏️ **Note:** l'assistant de configuration de Mediawiki peut également s'exécuter directement depuis le serveur final.

# Héberger votre Wiki sur les pages perso de Free

> ⚠️ **Attention:** Free fourni au mieux PHP 5.1.3 --> nécessite au mieux mediawiki 1.16.5

* modifier le fichier LocalSettings.php
  * DBserver: sql.free.fr
  * DBname: le nom de la base indiqué lorsque vous vous connectez au [phpMyAdmin](http://phpmyadmin.free.fr/)  de Free
  * DBuser: votre login Free
  * DBpassword: votre mot de passe Free
* transférer le répertoire wiki sur le serveur (via FTP)
* exporter la bdd (locale sur le poste vers un fichier) - via phpMyAdmin installé en local. **Ne pas utiliser de compression**
* importer la bdd sur le serveur (ficher vers serveur) - via [phpMyAdmin](http://phpmyadmin.free.fr/) de Free



# Bibliographie
* [Un Wiki chez Free](http://patrice.dargenton.free.fr/wiki/index.php?title=Un_Wiki_chez_Free)
* [MediaWiki chez Free](http://piblo29.free.fr/wiki/index.php?title=MediaWiki_chez_Free) 

# Notes et références 
