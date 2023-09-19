---
title: CMake
layout: default
icon: cmake.png
---

# Projet type
```
# Configuration projet
cmake_minimum_required(VERSION 3.5)
project(modernCpp
        VERSION 1.0.0.0
        DESCRIPTION "My amazing project"
        HOMEPAGE project-url
        LANGUAGES CXX)

# Config propre à C++
set(CMAKE_CXX_STANDARD 20)            # Declare which C++ version to use. Can be 98, 11, 14, 17 (CMake >3.8), 20 (CMake >3.12)
set(CMAKE_CXX_STANDARD_REQUIRED ON)   # Requires C++ standard to be applied. CMake doesn't downgrade if no compatible compiler is found. (Default is OFF)
set(CMAKE_CXX_EXTENSIONS OFF)

# Ajout d'un module
add_subdirectory(path/to/dir/that/contains/another/CMakelists/file)

# Déclaration des binaires (exe & lib)
add_executable(ProgramName source1 source2)
add_library(LibName source1 source2)

# link entre exe et lib
target_link_libraries(ProgramName PUBLIC LibName)

# Déclaration des dossier d'include
target_include_directories(ProgramName PUBLIC path/to/include/files)
```


# Configuration du projet
## Indique la version minimum requise pour CMake
```
cmake_minimum_required(VERSION 3.5)
```

## Configurer le projet
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


# Compilation
* add_executable(ProgramName source1 source2): Crée un exécutable en compilant et linkant tous les fichiers source indiqués
* add_library(LibName source1 source2): Idem mais pour créer une lib
* target_link_libraries(ProgramName PUBLIC LibName): Lie la lib avec l'exécutable
* target_include_directories(ProgramName PUBLIC path/to/include/files): Inclut le dossier indiqué pour chercher les headers (directive applicable uniquement à la cible indiquée)
  * Voir aussi include_directories
* target_include_directories(LibName INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}) : Permet de déclarer le dossier indiqué comme contenant les includes d'une lib. Le dossier sera alors automatiquement inclus pour tous les exécutables qui sont linkés avec cette lib.
* target_compile_definitions(ProgramNale PRIVATE CUSTOM_DEFINE): Permet de créer une definition qui sera utilisable dans le code (#ifdef)
  * Voir aussi add_compile_definitions 
* add_subdirectory(path/to/dir/that/contains/another/CMakelists/file): Ajoute un sous-dossier au projet. Le sous-dossier est analysé et le fichier CMakeLists.txt s'y trouvant est interprété immédiatement.



# Gestion des dépendances externes
Find_package

# Variables prédéfinies utiles
* PROJECT_BINARY_DIR: Dossier de build
* PROJECT_SOURCE_DIR: Dossier parent du projet. Dossier où se trouve le fichier CMakeLists.txt parent de tout le projet
* CMAKE_CURRENT_SOURCE_DIR: Dossier courrant pour les fichiers en cours de traitement. Sous dossier dans lequel se trouve un CMakeLists.txt enfant



# Options avancées
## Copie et modification de fichiers
Cette commande permet de copier des fichiers en les modifiant pour y insérer des variables issues de la config CMake.
```
configure_file(<input file> <output file>)
```
Copie le fichier *input* et le renomme en *output*. Lors de la copie, CMake remplace toutes les variables identifiées `@VAR@`, `${VAR}` ou encore `$ENV{VAR}` par leur valeur qui doit avoir **préalablement** été définie dans le fichier CMkakeLists.txt.
> 💡 L'option `@ONLY` permet de ne remplacer que les variables du type `@VAR@`, ceci afin d'éviter de remplacer d'éventuelles variables avec la syntaxe `${VAR}` qui est normalement propre aux scripts bash.

> 💡 Les fichiers seront copiés dans le dossier de build. Il ne faudra pas oublier d'ajouter ce dossier à la liste des répertoires à inclure

## Création d'un option
```
option(MyOption "Description" ON)
```
Permet de définir une variable qui pourra être configurée différement à l'appel de la commande cmake. Cette variable peut ensuite être réutilisée dans le fichier pour des traitements conditionnels par exemple.

La valeur de la variables est conservée dans le cache.

On peut passer une valeur dans la commande cmake: `cmake . -DMY_VAR=ON`

## Traitement conditionnel
```
if(<test>)
    ...
else()
    ...
endif()
```
Le test peut être de nature variée: test d'un booléen, 

## Lib interface
```
add_library(target_compiler_flags INTERFACE)
target_compile_features(target_compiler_flags INTERFACE cxx_std_11)
```
Crée une cible virtuelle qui ne génèrera aucun artefact sur le disque. Néanmoins on peut affecter des options à cette cible afin de la réutiliser en la liant aux autres cibles afin d'appliquer les mêmes options.
