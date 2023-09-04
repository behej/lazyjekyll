---
title: Makefile
layout: default
icon: make.png
---
# Principe de base
La syntaxe de base du makefile consiste à définir:
* une cible
* des dépendances (optionnelles)
* les commandes à exxécuter pour réaliser la cible

```sh
cible: dependance1 dependance2 ...
  commande1
  commande2
```

* La cible peut être soit un fichier à produire ou une cible virtuelle.
* Les dépendances peuvent être des fichiers ou d'autres cibles

Avant de construire une cible, make va vérifier si les dépendances sont à jour et les reconstruire si nécessaire.

Une fois la chaine des dépendances parcourue, le dernier élement est généralement un fichier, make va alors reconstruire la cible associée uniquement si le fichier a été modifié puis remonter la chaine de dépendance afin de générer la cible désirée.

# Cibles usuelles
* **make all**
  * généralement la première cible du makefile (exécuté lorsque make est appelé sans argument)
  * génère l'ensemble du projet
* **make test**
  * compile et exécute les tests
* **make install**
  * installe le logiciel sur l'hôte
* **make clean**
  * Supprime les fichiers générés


# Phony
La directive ***phony*** permet de lister toutes les cibles qui ne correspondent pas à des fichiers, mais sont des cibles virtuelles (ex: all, clean, etc.)
```sh
.PHONY: all clean install
```

# Macros
```sh
CC=gcc    # déclaration

$(CC)     # utilisation
```

Les opérandes dispos sont les suivantes:

| Opérande | Signification |
|----------|--------------|
| =  | Affectation simple |
| ?= | Définition de la macro seulement si pas encore définie |
| += | Concaténation |

# Variables internes

| Variable | Signification |
|----------|---------------|
| $@ | Nom de la cible |
| $? | Toutes les dépendances plus récentes que la cible |
| $< | Première dépendance |
| $^ | Toutes les dépendances |
| $* | Le nom du fichier sans l'extension |


# Règle générique
Il est possible de définir des règles génériques pour une extension donnée
```sh
%.o: %.c
  $(CC) -o $@ -c $< $(CFLAGS)
```
Chaque fichier .o sera donc dépendant du fichier .c associé (même nom de fichier) et sera construit selon la commande décrite. On utilise les variables internes afin de récupérer la cible et la dépendance de manière automatique.

# Fonctions
## Wildcard
```sh
SRC=$(wildcard *.c)
```
La variable `SRC` contient la liste de tous les fichiers *.c

## Création de la liste des fichiers objet
```sh
OBJ=$(SRC:.c=.o)
```
La variable `OBJ` contient la liste de tous les fichiers `.o` construite à partir de la liste des fichiers `.c`

## Substitution
La commande `patsubst` permet de remplacer un pattern dans une chaine (ex une liste de fichier) par une chaine de notre choix.

```sh
OBJ=$(patsubst %.c, build/%.o, $(SRC))
```
La commande ci-dessus remplace chaque fichier `.c` présent dans la liste `SRC` par la chaine `build/<nom_fichier>.o`

**Exemple**
* Si `SRC=file1.c file2.c`
* Alors `OBJ=build/file1.o build/file2.o`

## Chemin absolu
La commande `abspath` renvoie le chemin abslolu d'un fichier ou d'un dossier.

```sh
file_abs=$(abspath <file>)
```



# Sous-makefile
On veut parfois avoir plusieurs makefile qui puissent être appelés par un fichier makefile *maitre*.

Le makefile *maitre* peut déclarer des macros qui seront également définies dans les makefile *enfants*. Pour cela, il faut les déclarer avec le mot clé **export**
```sh
export CC=gcc
```

Ensuite, le makefile enfant est appelé grâce à la variable `$(MAKE)`. 2 possibilités pour indiquer le makefile enfant:
```sh
# Option 1
cd <subdir> && $(MAKE)

# Option 2
$(MAKE) -C <subdir> 
```

> 📝 Le Makefile enfant est appelé avec les mêmes options que le makefile parent si aucune option n'est indiquée explicitement dans l'invocation par le makefile parent.

On peut également passer des variables/macros au makefile enfant depuis le makefile parent, directement depuis la commande
```sh
$(MAKE) -C <subdir> MYVAR=<value>
```
Dans ce cas particulier, on pourra déclarer la variable en utilisant l'opérande `?=`: Si la variable est définie par le makefile parent, celle-ci n'est pas rédéfinie. Mais si la variable n'est pas positionnée par le makefile parent, celle-ci possède une valeur par défaut.

# Fichier type
```sh
CC=gcc
CFLAGS=-W -Wall -ansi

SRC_DIR=src
BUILD_DIR=build
SRC=$(wildcard $(SRC_DIR)/*.c)
OBJ=$(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRC))


.PHONY: all clean

all: myExecutable

myExecutable: $(OBJ)
  $(CC) -o $(BUILD_DIR)/$@ $^

%.o: %.c
  mkdir -p $(BUILD_DIR)
  $(CC) -o $@ -c $< $(CFLAGS)


clean:
  rm -rf $(BUILD_DIR)

```
