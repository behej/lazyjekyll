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

# Inclusion d'un fichier cmake pour déclarer certaines fonctions/librairies externes
include(path/to/file.cmake)

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
* **add_executable**(ProgramName source1 source2): Crée un exécutable en compilant et linkant tous les fichiers source indiqués
* **add_library**(LibName source1 source2): Idem mais pour créer une lib
* **target_link_libraries**(ProgramName PUBLIC LibName): Lie la lib avec l'exécutable
* **target_include_directories**(ProgramName PUBLIC path/to/include/files): Inclut le dossier indiqué pour chercher les headers (directive applicable uniquement à la cible indiquée)
  * Voir aussi include_directories
* **target_include_directories**(LibName **INTERFACE** ${CMAKE_CURRENT_SOURCE_DIR}) : Permet de déclarer le dossier indiqué comme contenant les includes d'une lib. Le dossier sera alors automatiquement inclus pour tous les exécutables qui sont linkés avec cette lib.
* **target_compile_definitions**(ProgramNale PRIVATE CUSTOM_DEFINE): Permet de créer une definition qui sera utilisable dans le code (#ifdef)
  * Voir aussi add_compile_definitions
* **target_compile_feature**(\<target_name\> INTERFACE \<requirement\>): Exige que le compilateur possède une certaine fonctionalité
* **target_compile_options**(\<target_name\> INTERFACE \<options\>): Ajoute des options de compilation à la target
  * On peut créer une cible virtuelle qui possède ces paramètres et ensuite lier cette cible virtuelle à n'importe quelle autre cible réelle (le link se fait alors de la même manière que pour lier une lib)
  * On peut également spécifier les options pour le build de l'appli uniquement (cf. generator expression et BUILD_INTERFACE). Dans ce cas, les options seront appliquées pour le build de la lib mais pas pour le déploiement.
* **add_subdirectory**(path/to/dir/that/contains/another/CMakelists/file): Ajoute un sous-dossier au projet. Le sous-dossier est analysé et le fichier CMakeLists.txt s'y trouvant est interprété immédiatement.
* **include**(external/file.cmake): Permet d'inclure un autre fichier cmake contenant des cibles ou des options connexes. Ce fichier porte généralement l'extension **.cmake**
* **add_custom_command**(OUTPUT \<generated_output\> COMMAND \<commande\> DEPENDS \<dependance\>): Permet d'exécuter une commande personnalisée afin de générer des fichiers. Ces fichiers peuvent ensuite être utilisés comme dépendances d'autres cibles
  * OUTPUT: les fichiers générés par cette commande. On peut ensuite utiliser ces fichiers comme dépendance pour d'autres cibles. Au moment de builder ces autres cibles, la commande personnalisée sera alors exécutée préalablement. Les fichiers générés doivent être ajoutés comme dépendance des autres cibles même si les fichiers générés sont des headers.
  * COMMAND: la commande à exécuter. Eventuellement suivi des arguments nécessaires
  * DEPENDS: les dépendances de cette commande. Si la dépendance est une cible, la cible sera rebuildée avant d'exécuter la commande. Si la dépendance est un fichier, la commande sera automatiquement re-exécutée si le fichier est modifié.

# Installation
* **install**(TARGETS \<targetName\> DESTINATION \<dir/to/install/files/corresponding/to/target\>): Copie les fichiers correspondant à la cible dans le dossier indiqué (Habituellement /usr/bin ou /usr/lib)
  * A cette étape, la target peut être une liste de plusieurs cibles (ex: une collection de libs).
  * La liste peut également contenir des cibles virtuelles définies avec `add_library(<target_name> INTERFACE)`. Cette possibilité est surtout intéressant si on a défini des options de compil activées uniquement en config build associées à cette cible virtuelle.
* **install**(FILES \<files\> DESTINATION \<dir/where/to/copy/files\>): Copie les fichiers indiqués dans le dossier choisi. On s'en sert notamment pour copier les headers d'une lib dans le dossier /usr/include

# Test
CMake intègre le module CTest qui permet de lancer des tests. Les commandes ci-dessous permettent de coder les tests directement dans CMakeLists.txt, ce qui n'est pas la meilleure solution.

CMake offre également une bonne compatibilité avec d'autres suites de tests, comme [GoogleTest](https://cmake.org/cmake/help/latest/module/GoogleTest.html#module:GoogleTest) par exemple. 

```
enable_testing()
add_test(NAME <test case name> COMMAND <command to launch>)
set_tests_properties(<test case name> PROPERTIES PASS_REGULAR_EXPRESSION "regexp to match for test to pass" )
```
* la commande **enable_testing** permet seulement d'activer la fonction test de CMake
* la commande **add_test** crée un test qui va lancer la commande indiquée. Cette commande seule ne vérifie rien
* la commande **set_tests_properties** permet d'ajouter une vérification au test

## Hint
Si plusieurs tests sont similaires, on peut créer une fonction qui va créer/exécuter le même test plusieurs fois avec des paramètres différents
```
function(<nom_fonction> <args...>)
  add_test(NAME <test_name_${arg}> COMMAND <commande> <args...> ${arg})
  set_tests_properties(<test_name_${arg}> PROPERTIES PASS_REGULAR_EXPRESSION "regex to match" )
endfunction()

nom_fonction(param1 param2 ...)
nom_fonction(param3 param4 ...)
...
```


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

> 📝 CMake possède également des options internes permettant de modifier le comportement par défaut de certaines commandes. Ces options se gèrent de la même façon. Seul le nom de l'option devra correspondre à l'option retenue.

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
target_compile_options(target_compiler_flags INTERFACE -Wall)
```
Crée une cible virtuelle qui ne génèrera aucun artefact sur le disque. Néanmoins on peut affecter des requirements ou des options à cette cible afin de la réutiliser en la liant aux autres cibles afin d'appliquer les mêmes options.

## Generator expressions
Les expressions génératrices permettent de produire des informations spécifiques en fonction de l'environnement et de sa configuration au moment du build. Elles permettent par exemple de définir des options de compilations particulière en fonction du compilateur utilisé.

Une telle expression est de la forme: `$<...>`.

> 💡 Ces expressions peuvent être imbriquées

### Forme élémentaire
Sa forme la plus élementaire est la suivante:
```
$<condition:true_string>
```
L'expression retourne "true_string" si la condition est vérifiée. Sinon, elle renvoie une chaine vide. La condition peut être soit une autre expression imbriquée, soit directement une variable. Dans ce cas, on n'oublera pas de rensigner la variable sous la forme `${variable}`.

### Forme avancée
On retrouvera plus souvent ces expressions avec un opérateur en première position
```
$<OPERATOR:parameters>
```
CMake propose une liste variée d'opérateurs permettant de vérifier de nombreux paramètres et de les combiner entre eux.

Liste non exhaustive des opérations possibles:
* IF: Permet de retourner une valeur spécifique selon que la condition soit vérifiée ou non
* AND: Réaliser un ET logique entre plusieurs conditions
* OR: Réaliser un OU logique entre plusieurs conditions
* EQUAL: Compare 2 valeurs numériques
* STREQUAL: Compare 2 chaines de caractères
* VERSION_LESS/VERSION_GREATER: Compare 2 numéros de version
* LOWER_CASE/UPPER_CASE: Transforme une chaine de caractères
* IN_LIST: Indique si un élément est présent dans une liste
* LIST:LENGTH: Indique le nombre d'éléments dans une liste
* LIST:GET: Renvoie un élément d'une liste à une position donnée
* LIST:APPEND: Ajoute des éléments à une liste
* PATH:xxx: De nombreuses expressions permettant de manipuler des chemins (cf. doc pour plus d'infos)
* C_COMPILER_VERSION/CXX_COMPILER_VERSION: Revoie la version du compilateur utilisé
* COMPILE_LANG_AND_ID: Renvoie 1 si le compilateur utilisé pour le language indiqué figure dans la liste des compilateurs attendus dans l'expression
* BUILD_INTERFACE: Renvoie les paramètres indiqués uniquement lorsqu'on build la cible. Ne renvoie rien si on installe la cible
* INSTALL_INTERFACE: Renvoie les paramètres indiqués uniquement lorsqu'on installe la cible. Ne renvoie rien lorsqu'on build la cible

> 👉 Voir la [doc officielle](https://cmake.org/cmake/help/latest/manual/cmake-generator-expressions.7.html#generator-expression-reference) pour plus de détails

## Introspection
L'introspection permet à CMake d'effectuer des tests sur le système afin de déterminer si tous les prérequis pour construire notre application sont présents. On peut ainsi adapter la configuration en fonction du système.

Le principe de base est de fournir un petit bout de code (au moins une fonction main()) dans le fichier CMakeLists.txt. Idéalement, cet extrait de code met en oeuvre la fonction ou la lib qu'on veut tester. CMake va alors essayer de compiler ce morceau. Si la compilation réussi, cela signifie que le composant requis est présent et utilisable sur le système. Une variable booléenne est alors positionnée à 1.
```
include(CheckCXXSourceCompiles)      # Inclus le module qui permet de tester du code C++. Exite pour d'autres languages

check_cxx_source_compiles("
#include ...
int main() {
   ... Le code qu'on veut tester
}
" <result var>)
```
On peut ensuite utiliser cette variable booléenne comme toute autre variable. Les usages peuvent être les suivants:
* déclaration d'un **DEFINE** qui sera utilisé comme compilation conditonner directement dans les fichiers source
* utilisation dans un bloc **if()** pour activer la compilation et l'installation du module manquant
* etc.

> ⚠️ Une fois le test effectué, le résultat est gardé en cache et le test n'est plus jamais ré-exécuté, même si le bout de code à tester est modifier. Il faut alors supprimer la variable directement dans le cache ou tout nettoyer.

> 📝 Le comportement de ce test peut être modifié en positionnant l'une ou l'autre des variables suivantes avant d'effectuer le test: CMAKE_REQUIRED_FLAGS, CMAKE_REQUIRED_DEFINITIONS, CMAKE_REQUIRED_LINK_OPTIONS, CMAKE_REQUIRED_LIBRARIES, etc. 
