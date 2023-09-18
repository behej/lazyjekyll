---
title: CMake
layout: default
icon: cmake.png
---

# Projet type
```
cmake_minimum_required(VERSION 3.5)
project(modernCpp
        VERSION 1.0.0.0
        DESCRIPTION "My amazing project"
        HOMEPAGE project-url
        LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 20)            # Declare which C++ version to use. Can be 98, 11, 14, 17 (CMake >3.8), 20 (CMake >3.12)
set(CMAKE_CXX_STANDARD_REQUIRED ON)   # Requires C++ standard to be applied. CMake doesn't downgrade if no compatible compiler is found. (Default is OFF)
set(CMAKE_CXX_EXTENSIONS OFF)

add_executable(ProgramName source1 source2)

target_include_directories(ProgramName path/to/include/files)
```


# Configuration du projet
**Indique la version minimum requise pour CMake**
```
cmake_minimum_required(VERSION 3.5)
```

**Configure le projet**
```
project(modernCpp
        VERSION 1.0.0.0
        DESCRIPTION "My amazing project"
        HOMEPAGE project-url
        LANGUAGES CXX)
```
* Nom du projet
* Version du projet (*optionel*) - peut également être défini indépendamment avec la variable `PROJECT_VERSION` ou `<project-name>_VERSION`
* Description du projet (*optionel*) - peut également être défini indépendamment avec la variable `PROJECT_DESCRIPTION` ou `<project-name>_DESCRIPTION`
* Lien vers le site web du projet (*optionel*) - peut également être défini indépendamment avec la variable `PROJECT_HOMEPAGE_URL` ou `<project-name>_HOMEPAGE_URL`
* Langage de développement (*optionel*) - `C`, `CXX`, `CSharp`, `ASM`, `ASM_NASM`, etc.

## Options propres au langage C++
* `set(CMAKE_CXX_STANDARD 20)`: Déclare la version de C++ à utiliser: 98, 11, 14, 17 (à partir de CMake 3.8), 20 (à partir de CMake 3.12)
* `set(CMAKE_CXX_STANDARD_REQUIRED ON)`: Requiert l'application du standard C++ indiqué. CMake ne choisira pas tout seul une version antérieure si aucun compilateur comaptible n'est détecté. (OFF par défaut)
* `set(CMAKE_CXX_EXTENSIONS OFF)` 


# Création d'un binaire
## Exe
**Création d'un exécutable par compilation et link des fichiers source indiqués**
```
add_executable(ProgramName source1 source2)
```

**Déclaration des répertoires d'include**
```
include_directories(path/to/include/files)
```
Inclus le dossier indiqué pour la recherche des headers lors de la compilation. Cette directive est applicable à toutes les cibles.
```
target_include_directories(ProgramName path/to/include/files)
```
Inclus le dossier indiqué pour la recherche des headers lors de la compilation. Cette directive n'est applicable que pour la cible indiquée. Cette directive doit figurer **après** la déclaration de la cible.


## lib
## Lier la lib avec l'exe

# Gestion des dépendances externes
Find_package

# Variables prédéfinies utiles
* PROJECT_BINARY_DIR: Dossier de build
* 

# Options avancées
## Copie et modification de fichiers
Cette commande permet de copier des fichiers en les modifiant pour y insérer des variables issues de la config CMake.
```
configure_file(<input file> <output file>)
```
Copie le fichier *input* et le renomme en *output*. Lors de la copie, CMake remplace toutes les variables identifiées `@VAR@`, `${VAR}` ou encore `$ENV{VAR}` par leur valeur qui doit avoir **préalablement** été définie dans le fichier CMkakeLists.txt.
> 💡 L'option `@ONLY` permet de ne remplacer que les variables du type `@VAR@`, ceci afin d'éviter de remplacer d'éventuelles variables avec la syntaxe `${VAR}` qui est normalement propre aux scripts bash.

> 💡 Les fichiers seront copiés dans le dossier de build. Il ne faudra pas oublier d'ajouter ce dossier à la liste des répertoires à inclure

