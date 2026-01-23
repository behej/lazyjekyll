---
title: Docker
layout: default
icon: docker.png
---
# Intro
* **image** : Description d'un environnement
* **container** : instance d'une image. Le container s'exécute. On peut avoir plusieurs containers basés sur une même image. Toutes les données à l'intérieur du container sont perdues dès que le container est arrêté.
* **volume** : volume de stockage géré par Docker. Le volume existe sur l'hôte et est monté dans le container à l'exécution. Cela signifie que les données continuent d'exister même après l'arrêt du container.
* **network** : réseau "virtuel" sur lequel les containers peuvent se connecter. Cela permet d'avoir plusieurs réseaux distincts et d'isoler certains container du réseau exposé.


Un container s'exécute tant qu'un process démarré dans le container est en cours d'exécution. Le dernier process s'arrête, le container s'arrête aussi.

# Installation
* `sudo apt-get install docker.io` 
* `sudo adduser $USER docker` : ajoute l'utilisateur au groupe docker. Résout le message d'erreur "Got permission denied while trying to connect to the Docker daemon socket"
  * Il faut impérativement se reconnecter après exécution de cette commande

# Commandes
## Interface avec le Hub
**Se connecter sur le hub (nécessite un compte)**
```sh
docker login
```

## Images 
**Liste les images présentes en local**
```sh
docker images
docker image ls [--all]
```

**Construit une image à partir du Dockerfile**
```sh
docker image build --tag <tag> path/to/folder/where/is/dockerfile
docker image build --tag <tag> -f path/to/file.dockerfile
```
* Pour la 1ère syntaxe, le fichier doit impérativement se nommer `Dockerfile`
* Syntaxe utile pour pousser vers le Hub: `--tag dockerID/app:1.0`

**Pousse l'image vers le Hub**
* Le nom de l'image doit être constitué de la sorte: `dockerID/nomImage:1.0`
* La commande login doit avoir été exécutée au préalable
```sh
docker image push <nomImage>
```

## Containers
**docker container ls**
* liste les containers (ne liste que les containers actifs)
  * docker container ls \-\-all : liste tous les containers (même ceux inactifs)

**docker container run *\<nomImage\>***
* Démarre un container à partir de l'image. Si l’image n'est pas présente en local, docker essaie de la télécharger depuis le [Hub](https://hub.docker.com)
  * **docker container run \-\-rm *\<nomImage\>*** : supprimer le container une fois celui-ci terminé
  * **docker container run \-\-interactive \-\-tty *\<nomImage\>*** : Démarre un container en mode interactif et associe un pseudo terminal (le terminal du container est mappé sur le terminal du host)
    * **docker container run -it *\<nomImage\>*** : `-it` == `--interactive --tty`
  * **docker container run *\<nomImage\> \<command\>*** : Démarre le container et exécute la commande en tant PID 1
  * *docker container run \-\-detach *\<nomImage\>*** : Démarre le container en arrière-plan
  * **docker container run \-\-name *\<nomContainer\> \<nomImage\>*** : Donne un nom au container (si omis, un nom est généré au hasard)
  * **docker container run -e MY_ENV_VAR=myValue *\<nomImage\>*** : Crée et initialise une variable d'environnement au sein du container
  * **docker container run \-\-mount type=bind,source="path/to/local/folder",target=path/to/container/dir/ *\<nomImage\>***  : Monte le dossier local dans un dossier du container. Les modifs faites dans le dossier local sont effectives dans le dossier du container.
    * **IMPORTANT:** Le montage de type "volume" est maintenant à privilégier par rapport au type "bind"
  * **docker container run -v /path/to/volume:/path/to/container/dir *\<nomImage\>*** : Monte le volume dans un dossier du container.
    * On peut indiquer un chemin vers un volume, mais le mieux est encore de laisser docker gérer les volumes (cf commandes de la section volume)
    * L'avantage des volumes par rapport au bind: les volumes sont gérés par docker. On est indépendant par rapport à l'architecture de l'hote (pas besoin de s'assurer que le dossier monté est existant sur l'hôte.)
    * Un fois l'exécution du container terminée, le volume reste présent (sauf si le container a été démarré avec l'option `--rm`). Il est possible d'y accéder ou de le supprimer.
  * **docker container run \-\-publish *\<portSrc\>:\<portDst\> \<nomImage\>*** : mappe le port source de l'hote vers le port destination du container
  * **docker container run -u \<username\>** : démarre le container et y exécute les commande en tant qu'utilisateur particulier (note: fonctionne aussi avec les user ID et group ID)
  * **docker container run -u \<username\>:\<group\>** : démarre le container et y exécute les commande en tant qu'utilisateur particulier appartenent à un groupe particulier

**docker container logs *\<nomContainer\>***
* Affiche les logs du container

**docker container top *\<nomContainer\>***
* Liste les processus du container

**docker container exec [options] *\<nomContainer\> \<command\>***
* execute une commande dans un container actif. On peut ajouter les options `-it`.

**docker container rm *\<nomContainer\>***
* supprime le container
  * docker container rm \-\-force <nomContainer> : force l'arrêt du container s'il est toujours en cours d'exécution

**docker container attach *\<nomContainer\>***
* attache le terminal sur le terminal du container (comme s'il était démarré avec -it)
  * pour détacher le container, enchainer les combinaisons suivantes: CTRL+P, CTRL+Q
  * Si le container est en train de tourner un shell, on peut s'y attacher. Sinon, la commande risque de ne pas donner gd chose

**docker container exec *\<nomContainer\> \<commande\> [\<options\>]*** : execute la commande indiquée dans le container
  * **docker container exec -it *\<nomContainer\>* sh** : execute un shell dans le container en mode interactif


## Volumes
**docker volume create *\<nomVolume\>***
* crée un volume

**docker volume ls**
* liste les volumes existants

**docker inspect *\<nomVolume\>***
* affiche les détails d'un volume

**docker volume rm *\<nomVolume\>***
* supprime le volume

## Sauvegarde des volumes
Il peut être intéressant de sauvegarder le contenu d'un volume, soit parce que container est terminé et on veut récupérer les fichiers produits, soit parce qu'on souhaite effectuer une sauvegarde. Voici la procédure recommandée sur la doc officielle docker. On peut la scripter avec les outils de notre choix.

### Principe
* On démarre un nouveau container qui va monter le volume à sauvegarder (avec l'option volumes-from)
  * Le volume est monté sur le 2nd container avec les mêmes options (et donc le même mount point) que le container initial
* Le second container est également monté avec un volume pour accueillir la sauvegarde
* Le second container est lancé avec une commande pour créer une archive du volume à sauvegarder et l'enregistrer dans le volume qui accueil la sauvegarde

### Exemple
Si le 1er container est lancé ainsi:

```sh
docker run -v <volume>:/path/to/volume --name <nomContainer1> <image>
```
Lancer le container de backup (une image alpine ou ubuntu fait l'affaire)

```sh
docker run --volumes-from <nomContainer1> -v $(pwd):/backup_folder/ alpine tar cvf /backup_foler/backup.tar /path/to/volume
```

## Networks
**docker network create \<nomNetwork\>**
* créer un network

**docker network ls**
* liste les networks existants

**docker inspect \<nomNetwork\>**
* affiche les détails d'un network

**docker network rm \<nomNetwork\>**
* supprime le network

# Dockerfile
Un dockerfile est un fichier contenant toutes les commandes et options permettant la création d'une nouvelle image. L'image peut ensuite être lancée dans un container.

|Instruction|Description|
|---|---|
| FROM \<dockerImage\> | Indique sur quelle image baser la nouvelle image |
| COPY path/to/local/file path/to/container/file | copie un ficher local vers le container |
| RUN \<command\> | execute une commande dans le container en construction |
| EXPOSE \<portNb\> \<portNb\> ... | Indique quels ports exposer par le container (Aucune utilité fonctionnelle, uniquement à but documentaire) |
| CMD ["\<command\>", "\<arg1\>", "\<arg2\>", ...] | Exécute la commande dans le container |

# Docker compose
Pour lancer un container, la liste des options peut être très longue (volume, vars d'environnement, ports, etc.). Cela peut devenir très compliqué si en plus, il y a plusieurs container à lancer en parallèle pour fait fonctionner l'appli.

Pour simplifier cette tâche, l'outil Docker Compose permet de stocker tous les paramètres dans un ficher YAML.

Voir les commentaires du docker-compose.yml sur [github](https://github.com/behej/redmine_docker_rpi/blob/main/docker-compose.yml) pour les options principales.

**Informations supplémentaires:**
## Démarrage/arrêt
Les commandes doivent être exécutées depuis le dossier contenant le fichier *docker-compose.yml*

**docker-compose up**
* démarre les containers selon la description du fichier docker-compose.yml

**docker-compose up -d**
* démarre en tant que service

**docker-compose -f \<composeFile.yml\> up**
* Si le fichier est nommé différemment de *docker-compose.yml*

**docker-compose down**
* Stoppe les containers

## Structure du fichier
* la section *services* liste tous les containers à démarrer
* la section *networks* liste les réseaux utilisés (les réseaux sont ensuite référencés dans `services/<container>/networks/`)
  * Le réseau est automatiquement créé s'il n'existe pas. Possibilité de déclarer/utiliser un réseau pré-existant avec l'option `external: true`
* la section *volumes* liste les volumes utilisés (les volumes sont ensuite référencés dans `services/<container>/volumes/`)
  * Le volume est automatiquement créé s'il n'existe pas. Possibilité de déclarer/utiliser un volume pré-existant avec l'option `external: true`
* la section *secrets* liste les secrets utilisés (les secrets sont ensuite référencés dans `services/<container>/secrets/`)
  * Cette section est utile pour partager des secrets (mots de passe) sans les écrire en clair dans le compose file.
  * Le secret est écrit dans un fichier externe, géré en-dehors de docker
  * Le secret est monté en tant que fichier dans le container sous `/run/secrets/<nomSecret>`

## Divers
* Démarrage automatique
  * Les container déclarés `restart: always` ou `restart: unless-stopped` redémarrent automatiquement au reboot
  * Pour autoriser cela, il faut exécuter la commande `sudo systemctl enable docker`
* Dépendances
  * l'option `depends_on: <nomContainer>` permet de créer des dépendances entre les containers
  * les containers sont démarrés dans l'ordre des dépendances
  * Si un seul service est démarré, les dépendances sont automatiquement démarrées
