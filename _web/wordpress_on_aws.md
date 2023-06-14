---
title: Wordpress on AWS
layout: default
icon: aws.png
---
# Présentation des différents services AWS
* EC2 (Elastic Cloud Computing)
  * Elastic IP
  * Security groups : Règles de firewall
* IAM (Identity and Access Management)
  * Groups : Un ensemble d'utilisateurs avec des autorisations communes à tous.
  * Users : Définit des utilisateurs nominatifs. Chaque utilisateur se voit affecté une ou plusieurs stratégies lui donnant ainsi des autorisations. Un utilisateur possède des paramètres d'authentification. Plutôt que de définir des stratégies pour un utilisateur, on peut rattacher l'utilisateur à un groupe.
  * Roles : Définit des rôles. Un rôle est comme un utilisateur, on lui associe des stratégies. La différence réside dans le fait qu'un rôle est associé à un service AWS. Ex: on peut associer un rôle à une instance EC2 pour lui donner les droits d'accès à une BDD RDS.
  * Strategies : Une stratégie définit des autorisations. Bcp de stratégies sont pré-existantes. Il est possible d'en créer de nouvelles pour spécialiser les stratégies. Ex: Donner les accès à un stockage S3 mais uniquement à un bucket précis.
* RDS (Relational Database Service)
* S3 (Simple Storage Service)
* S3 Glacier : Archives longue durée (sur bande magnétique). La restauration peut prendre plusieurs jours.
* VPC (Virtual Private Cloud) : Des sous réseau parmi l'infrastructure AWS sur lesquels on peut choisir de connecter différents service AWS
* CloudFront (CDN - Content Delivery Network) : Système de diffusion de contenus permettant de garder une copie cache au plus près des utilisateurs finaux. Notamment utilisé pour S3.
* Route 53


# Configurer le serveur Linux
* Lancer une instance EC2 Ubuntu
* se connecter avec la commande `ssh -i <path_to_private_key> -p ubuntu@<server_ip_address>`
* Mettre à jour l'OS: `sudo apt-get update && sudo apt-get upgrade`
* Installer le serveur HTTP (Apache2 sur les OS base debian ou httpd sur OS base RedHat) : `sudo apt-get install apache2`
* Installer PHP: `sudo apt-get install php7.2 php-mysql`
  * Eventuellement modifier la version PHP souhaitée
  * php-mysql correspond au module PHP permettant d'accéder à des bases MySQL
* Redémarrer le serveur HTTP: `sudo service apache2 restart`

***Facultatif:***
* Installer un client mysql: `sudo apt-get install mysql-client-core-5.7`

> ✏️ Note: Le client mysql permet de se connecter sur le serveur RDS pour administrer la base. Ce client n'est pas nécessaire sur le serveur LAMP si on administre sa base depuis notre PC.


#  Installer Wordpress
* Se placer dans le dossier du serveur web: `cd /var/www/html/`
* Télécharger la dernière version de Wordpress: `sudo wget http://wordpress.org/latest.tar.gz`
* Extraire l'archive: `sudo tar -xvf latest.tar.gz`
* Optionnel: Déplacer les fichiers pour que le site soit accessible à la racine du serveur: `sudo mv wordpress/* .`
* Changer le propriétaire du dossier wp-content: `sudo chown www-data:www-data wp-content`
* Dans le dossier wp-content, changer le propriétaire du dossier themes/ : `sudo chown www-data:www-data -R themes`
  * Le propriétaire est désormais le serveur web (apache), ce qui permettra d'uploader du contenu ou d'installer des thèmes

## Notes sur les permissions des fichiers et dossiers
* Définir le serveur apache comme propriétaires des fichiers et dossiers permettra de modifier ces fichiers et dossier directement par le site. Ce qui implique qu'il serait possible d'effectuer des mises à jour, d'uploader des fichiers ou d'installer des thèmes.
* Les permissions doivent être 755 pour les dossiers et 644 pour les fichiers
* Le dossier racine de wordpress n'est volontairement pas défini comme propriété du serveur web (tanpis pour les mises à jours)
* le dossier wp-content pour l'upload de fichiers (media notamment)
  * mais pas nécessairement tous les sous-dossiers
* le dossier wp-content/themes/ pour l'installation de thèmes

**💡 Tips**
* Changer les permissions sur tous les dossiers d'un seul coup
```sh
find . -type d -exec chmod 755 {} ;
```
* Changer les permissions sur tous les fichiers d'un seul coup
```sh
find . -type f -exec chmod 644 {} ;
```


# Créer une BDD
* Avec AWS RDS, créer une BDD MySQL
  * Ajouter une règle de trafic permettant de s'y connecter
  * Rendre la base publique
* Identifier le 'endpoint' et le port de connexion de la base
* Se connecter à la base en tant qu'admin
```sh
mysql -h <endpoint> -P <port> -u <admin_login> -p
```
* Créer un utilisateur dédié
```sql
CREATE USER <usernamedb>@% IDENTIFIED BY <password>;
```
* Créer une base pour le Wordpress
```sql
CREATE DATABASE <db_wordpress> CHARACTER SET 'urf8';
```
* Ajouter les droits pour l'utilisateur dédié sur la base dédiée
```sql
GRANT SELECT, INSERT, UPDATE, DELETE ON <db_wordpress>.* TO <usernamedb>@%;
```
* Depuis la console AWS, rendre à nouveau la base privée
  * seul le serveur pourra y accéder car il se trouvera dans le même VPC que la base. En revanche, la BDD ne sera pas exposée sur le réseau public, ce qui limite les risques d'attaque.

# Configurer Wordpress
* Se connecter à l'adresse du site Wordpress
* Suivre les instructions de configuration
  * Renseigner les infos de connexion à la BDD


# Configurer le stockage sur AWS S3
## Intro

Bon, on va faire une pause et expliquer rapidement les options possible et ce qu'on va faire.
On va utiliser un plugin qui va stocker nos fichiers media non plus sur le serveur mais dans un bucket AmazonS3. C'est plus pratique, plus rapide, moins cher et plus secure de séparer notre site et les fichiers media. En plus, on pourra dans le futur opter pour un CDN sans tout chambouler.

Maintenant, il faut configurer tout cela pour donner les accès S3 à notre site.
Le plugin utilisé nous propose 3 options:
* Créer un utilisateur IAM et stocker ses identifiants d'accès directement dans la BDD. Solution la moins recommandée car la BDD est l'élément le plus vulnérable. Dans notre cas, cette recommandation est à relativiser car notre BDD n'est pas directement exposée sur le net.
* Stocker les identifiants d'accès de l'utilisateur IAM dans le fichier `wp-config.php`. Solution plus ou moins équivalente à la précédente.
* Ne pas créer d'utilisateur IAM mais créer un rôle. L'avantage est qu'on peut déléguer ce rôle à notre instance EC2 (à noter que cela n'est pas possible uniquement car notre site est hébergé par AWS). Ainsi, pas de d'identifiant à stocker puisque c'est directement notre instance EC2 qui à les droits d'accès à S3.

C'est cette dernière solution qu'on va utiliser. Pour les autres, je vous renvoie à la documentation du plugin qui est très bien faite.


## Procédure côté AWS
* Sur la console AWS, Ouvrir IAM et créer un nouvel rôle
  * Entité de confiance: Service AWS
  * Service: EC2
  * Autorisation: AmazonS3FullAccess
* Dans la console EC2, sélectionner l'instance EC2 qui héberge notre site
  * Actions > Paramètres de l'instance > Attacher/remplacer le rôle IAM
  * Sélectionner le rôle créé précédemment
  * Appliquer
* Dans la console S3
  * Créer un bucket
  * Ne PAS bloquer l'accès public au bucket


### Notes
* Il est possible de renforcer les contrôles en créant une stratégie plus spécifique que "S3FullAccess". Pour cela, on va créer une stratégie basée sur S3FullAccess mais en restreignant l'accès au seul bucket souhaité.
* Il doit également être possible de faire fonctionner le tout sans rendre le bucket public. Peut-être avec un CDN, il faut encore que je creuse cette piste.


## Procédure côté Wordpress
* Installer le plugin **WP Offload Media Lite**
* Se connecter en ssh au serveur et installer les modules nécessaires
```sh
sudo apt-get install php7.2-xml php7.2-curl
```
* Redémarrer le serveur http: `sudo service apache2 restart`
* Editer le fichier wp-config.php sur le serveur (en ssh)
  * Insérer la ligne "`define( 'AS3CF_AWS_USE_EC2_IAM_ROLE', true );`" juste avant le commentaire "*That's all, stop editing!*"
* Se rendre sur la page de configuration du plugin
  * Storage provider: Amazon S3
  * "*My server is on Amazon Web Services and I'd like to use IAM Roles*"
  * En cliquant sur le bouton "*Browse buckets*", le bucket créé précédemment apparait
  * Le sélectionner puis cliquer sur next
  * Configurer les dernières options de fonctionnement du plugin (notamment, le fait de supprimer automatiquement les fichiers du serveurs lorsqu'ils ont été migrés sur S3)
