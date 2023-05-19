---
title: Redmine
layout: default
icon: redmine.png
---
# Installation de Redmine

* Téléchargement de Redmine
  * téléchargement et décompactage dans un répertoire sur le disque
* Installation/Configuration de MySQL
  * Installation du serveur MySQL (avec les outils de dev)
  * Création d'une table **redmine** et d'un utilisateur **redmine**
* Installation de Ruby
  *Version 1.9.3 préconisée. Utilisation de l'installeur **RubyInstaller**
* Installation du DevKit
  * Nécessaire pour pouvoir installer la gem mysql2
* installation de la gem **mysql2**
  * ligne de commande pour installation par le net: `gem install mysql2` --> *n'a pas fonctionné*
  * Installation de la version précise 0.3.11 --> utilisation de la version 0.3.11 (cf. problèmes rencontrés)
    * via le web avec la commande `gem install mysql2 -v 0.3.11`
    * en téléchargeant d'abord la gem sans l'installer puis avec une install locale : `gem install -f --local mysql2-0.3.11-x86-mingw32`
  * Lors de l'install, un message indique que cette gem a été compilée en utilisant le connecteur C version 6.0.2. On va donc le télécharger depuis le site [MySQL](http://dev.mysql.com/downloads/connector/c/6.0.html#downloads) et copier la dll dans le répertoire `Ruby/bin/`
* installation de la gem **bundler** (gestionnaire de dépendances)
  * ligne de commande: `gem install bundle`
* installation de toutes les gems requises
  * la liste des gems à utiliser est donnée dans le fichier **Gemfile** situé dans le répertoire de redmine
  * on utilise mysql, donc pas besoin de postgresql et sqlite. Rmagick non installé donc pas besoin de la gem.
  * Attention: pour la même raison qu'à l'installation de **mysql2**, il faut rester avec la version 0.3.11. Dans le fichier **gemfile**, il faut changer la version requise: remplacer `~>0.3.11` par `=0.3.11`
  * ligne de commande à exécuter **dans le repertoire de redmine**: `bundle install --without development test rmagick postgresql sqlite`
* Générer un secret de session
  * se placer dans le répertoire de redmine
  * exécuter la commande `rake generate_secret_token`
  * Note: c'est à cette étape qu'il est crucial d'avoir copié *libmysql.dll*
* Créer la structure de base
  * Exécuter la commande `set RAILS_ENV=production`
  * Puis exécuter immédiatement la commande `rake db:migrate`
* Config par défaut
  * Exécuter la commande `set RAILS_ENV=production`
  * Puis exécuter immédiatement la commande `rake redmine:load_default_data`
  * Choisir la langue: taper *fr* puis **ENTER**
* Activer la gestion de conf
  * Editer le fichier **configuration.yml** dans le répertoire `redmine/config/`
  * indiquer le chemin de l'application de SCM
* Démarrer le serveur
  * exécuter la commande `ruby script/rails server webrick -e production`
* Se connecter
  * http://localhost:3000/
  * compte admin par défaut: admin/admin

# Commandes ruby

|Commande|Description|
|---|---|
| gem install *nomDeLaGem* | Installation |
| gem uninstall *nomDeLaGem* | Désinstallation |
| gem fetch *nomDeLaGem* | Téléchargement mais sans installation |
| gem install --force --local *nomDeLaGem.gem* | Installation local du fichier .gem (à exécuter dans le répertoire contenant le .gem) |
| gem env | Liste l'environnement de dev |

# Erreurs
## DevKit manquant
**Description**

Lors de l'installation de *mysql2*, j'ai eu le message d'erreur suivant:
```bash
gem install mysql2
ERROR: Error installing mysql2:
The ‘mysql2′ native gem requires installed build tools.
 
Please update your PATH to include build tools or download the DevKit from http://rubyinstaller.org/downloads and follow the instructions at http://github.com/oneclick/rubyinstaller/wiki/Development-Kit
```

**Solution**

l'installation de mysql2 requiert le [development kit](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit). Il faut donc l'installer en suivant la procédure décrite sur la page officielle.

## Failed to build native gem native extension lors de l'installation de *mysql2*
[http://www.redmine.org/boards/2/topics/38765](http://www.redmine.org/boards/2/topics/38765)

## Failed to build native gem native extension lors de l'exécution de *bundle install*

Pour la même raison que ci-dessus, la version 0.3.13 de mysql2 pose problème. Il faut donc s'en tenir à la version 0.3.11.

Pour cela, il faut modifier le fichier *gemfile* pour modifier la version requise de mysql2.

Remplacer `"mysql2", "~> 0.3.11"`, qui signifie la version 0.3.11 ou plus mais en restant en version 0.x
par `"mysql2", "= 0.3.11"`, qui signifie la version 0.3.11 (et aucune autre)

## Erreur "*RAILS_ENV* n'est pas reconnu en tant que commande interne ou externe, un programme exécutable ou un fichier de commandes."
**Description**

Lors de l'exécution d'une des commandes suivantes:
```bash
RAILS_ENV=production rake db:migrate
RAILS_ENV=production rake redmine:load_default_data"
```

le message d'erreur suivant est affiché:
```bash
RAILS_ENV n est pas reconnu en tant que commande interne ou externe, un programme exécutable ou un fichier de commandes.
```

**Solution**

Sous Windows, il faut séparer la commande
```bash
RAILS_ENV=production <commande>
```

en 2 lignes distinctes
```cmd
set RAILS_ENV=production
<commande>
```
## Activer les repos
**Description**

On peut lier le SCM directement à Redmine. Pour cela, le repo doit être cloné sur le même serveur que Redmine


**Solution**

1. Cloner le repo avec l'option mirroir: `git clone --mirror <url>`
2. Le repo doit recupérer régulièrement les dernières modifs du repo distant. Le plus simple est de créer une tâche cron qui effectue périodiquement une requête `fetch`

Plus d'infos ici: 
* [Cloner les repos](https://github.com/behej/redmine_docker_rpi#first-usage)
* [Script pour pull périodique](https://github.com/behej/redmine_docker_rpi/blob/main/redmine-repos/fetch_repos.sh)

## Les demandes ne sont pas automatiquement liées aux commits
**Description**
Une fois Redmine installé et opérationel, il est possible de lier automatiquement un commit à une demande simplement en indiquant `#<id>` dans le message de commit. Il est même possible de clore ou mettre à jour des tâche en utilisant certains mot clés.

Le problème décrit ici est qu'il obligatoirement déclencher l'affichage de la page *dépôt* pour que le lien soit créé.


### Solution 1 (non fonctionnelle)

Ajouter un hook post réception pour envoyer une commande HTTP au serveur à chaque fois que des données sont reçues depuis origin.

Voir sur le site officiel pour pls d'infos : [HowTo setup automatic refresh of repositories in Redmine on commit](https://www.redmine.org/projects/redmine/wiki/HowTo_setup_automatic_refresh_of_repositories_in_Redmine_on_commit)

> ⚠️ Si Redmine est hébergé sur des containers Docker, la requête HTTP ne doit pas être dirigée vers localhost mais vers le container qui héberge le serveur web.

**Note:** Le script fonctionne correctement mais le hook *post-receive* n'est pas déclenché après la commande `git fetch`.

### Solution 2 (non adaptée)

La mise à jour des trackers redmine peut être effectuée lors de chaque modification sous Github par l'intermédiaire du plugin redmine [Github hooks](https://github.com/koppen/redmine_github_hook).

**Note:** Cette solution impose que le serveur redmine soit accessible depuis Internet. Inadapté dans notre cas.

### Solution 3 (**OK**)

La dernière solution consiste à ajouter la commande *curl* de la solution 1 dans le script exécuté périodiquement par le *cron*.



# Add-ons
## Turtlemine
Plugin pour TortoiseGit qui permet de récupérer la liste des demandes depuis Redmine pour les insérer directement dans le message de commit.

[TurtleMine](https://code.google.com/p/turtlemine/)
