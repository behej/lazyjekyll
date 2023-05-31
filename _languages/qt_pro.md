---
title: Qt - fichiers .pro
layout: default
icon: qt.png
---
# Préambule
Les fichier `.pro` sont les fichiers projet de Qt. Ils décrivent la liste des fichiers source, les options de compil, les libs nécessaires, les resources, etc.

Ils ont été avantageusement remplacés par une configuration à base de **CMake**.

Tout ce qui suit est donc quelque peu obsolète. Cette section est nénmoins conservée à titre informatif.


# Généralités
* Définition d'une variable: `VAR = valeur`
* Utilisation d'une variable: `$$VAR`
* Réalisation sous condition: ``<test>:VAR += value`
* Autre syntaxe:

```sh
<test> {
  VAR += value
}
```

* condition if/else

```sh
<test> {
    VAR += val1
}
else {
    VAR += val2
}
```

# Principaux paramètres

|Paramètre|Description|
|---|---|
| QT += modules  | Spécifie les modules Qt à activer pour la compilation (core, gui, widgets, sql, etc.) |
| CONFIG += C++11 | Activation du C++11 |
| TARGET = nom | Nom du binaire produit |
| DEFINES += macro | Ajoute une définition de pré-processeur (utile créer des libs) |
| TEMPLATE = app | Crée une application (fichier .exe) |
| TEMPLATE = lib | Crée une library (fichier .dll) |
| TEMPLATE = subdirs | Un projet racine qui contient des sous-dossiers, chacun contenant son propre fichier .pro). Nécessite la déclaration de la variable SUBDIRS |
| SUBDIRS = dir1 dir2 | Donne la liste exhaustive des répertoires devant être analysés. Valable uniquement avec TEMPLATE = subdirs |
| SOURCES = ... | Donne la liste de tous les fichiers source du projet |
| HEADERS = ... | Donne la liste de tous les fichiers d'entête du projet |
| FORMS = ... | Donne la liste de tous les formulaires du projet |
| LIBS += -Ldirectory | Ajoute le répertoire indiqué à la liste des dossiers contenant des libraries (noter le L majuscule) |
| LIBS += -lmylib | Ajoute la library indiquée à la liste des éléments linkés (noter le l minuscule) |
| INCLUDEPATH += dir | Ajoute les dossiers indiqués à la liste des dossier contenant des headers |
| DESTDIR = dir | Indique le dossier dans lequel seront placés les fichiers produits (si omis, le dossier par défaut est ./debug/) |
| OBJECTS_DIR = dir | Indique le dossier dans lequel seront générés les objets (si omis, le dossier par défaut est ./debug/) |
| RESOURCES = resource.qrc | Fichier(s) de resources au format qrc. Les ressoures décrites dans ce fichier sont embarquées dans le binaire final. |
| RC_FILE = fichier.rc | Associe un fichier ressources. Ce fichier contient généralement l'icône et les propriétés de l'exécutable (version, company, copyright, product, etc.) |
| include(fichier.pri) | Insère à l'endroit même où se trouve cette instruction, le contenu du fichier .pri. Un fichier .pri est identique à un fichier .pro mais possède une extension différente pour bien indiqué que ce fichier a vocation à être inclus. Cette instruction un utile lorsque plusieurs directives sont communes à plusieurs fichiers .pro. On le consigne alors dans un unique fichier .pri qui sera inclus dans les fichiers .pro concernés.
| INSTALLS += mytarget | Ajoute mytarget à la liste des éléments déployés à l'installation avec `make install`. L'installation consiste à copier les fichiers indiqués dans le membre *files* dans le dossier indiqué par le membre *path*. mytarget doit être défini comme suit
| mytarget.files = fichiers | Le membre *files* indique la liste des fichiers qui seront copiés dans le dossier indiqué par le membre *path*. **Note:** les cibles *target* et *dlltarget* sont des mots clés reconnus. On peut omettre le membre *files* pour laisser Qt décider des fichiers à installer. Mais on peut tout aussi bien forcer les fichiers en spécifiant le membre *files*. |
| mytarget.path = dir ||

# Exemple de projet
## Description du projet
* Le projet est découpé en un exécutable principal et plusieurs dll

## Architecture
* Un dossier par module. Chacun de ces dossier contiendra les sources et le fichier .pro permettant de compiler la dll ou l'exécutable
* Un dossier 'common' qui contient tous les éléments communs (le fichier .pri, les ressources, un fichier globals.h, etc.)
* Un dossier debug et un dossier release dans lesquels seront produits les différents éléments des projets. Chaque dossier contient:
  * un dossier build: le résultat de la compilation est produit ici
  * un dossier interfaces: on vient copier les fichiers .h ici afin de tous les trouver au même endroit
  * un dossier bin: on copie les dll et les exécutables ici ainsi que les éventuels fichiers à livrer. A la fin, il suffira de distribuer le contenu de ce répertoire.

**Exemple:**
```
 projet
  |- common
  |- mainModule
  |- module1
  |- module2
  |- moduleN
  |- debug
  |   |- bin
  |   |- build
  |   |- interfaces
  |- release
      |- bin
      |- build
      |- interfaces
```

## Fichiers .pro
### Projet complet
Un fichier .pro qui sert uniquement à déclarer un projet composé des différents modules et exécutables (sous-projets)

```
TEMPLATE = subdirs

SUBDIRS = module1 \
         module2 \
         moduleN \
         mainModule
```

### Déclaration communes
Tous les sous-projets partagent les caractéristiques communes suivantes:
* Dossier dans lequel produire les exécutables: dossier debug/build/ (ou release/build/)
* Dossier dans lesquels chercher les headers: dossiers debug/interfaces (ou release/interfaces) et common/
* Dossier dans lequel se trouvent les librairies à linker: dossier debug/bin/ (ou release/bin/)
* Fichier ressource (pour l'icône ou les propriétés): common/myResource.rc
* Il faut copier les binaires produits dans le dossier debug/bin/ (ou  release/bin/)
* Il faut copier les fichiers d'entête dans le dossier debug/interfaces/ (ou release/interfaces/)

On peut donc créer un fichier common.pri qui sera inclus dans les fichiers .pro de chaque module
```
CONFIG += C++11

CONFIG(debug, debug|release) {
    BUILD_TYPE = debug
}
else {
    BUILD_TYPE = release
}

INCLUDEPATH += ../$$BUILD_TYPE/interfaces ../common
DESTDIR = ../$$BUILD_TYPE/build
IFILES = *.h

LIBS += -L../$$BUILD_TYPE/bin
RC_FILE = ../common/ToolsDB_resource.rc
DISTFILES += ../common/ToolsDB_resource.rc

target.path = ../$$BUILD_TYPE/bin/

interfaces.files = $$IFILES
interfaces.path = ../$$BUILD_TYPE/interfaces

INSTALLS += target interfaces
```

### Modules
Les fichiers projet de chaque module sont structurés de manière identique:
* Les modules QT à inclure (QT += core ...)
* le nom de l'exécutable à produire (TARGET = ...)
* Le type de l'exécutable à produire (dll ou exe) - TEMPLATE = app|lib
* Les librairies à inclure (LIBS += -lmylib ...)
* les sources (SOURCES += ...)
* les fichiers d'entête (HEADERS += ...)
* Les formulaires (FORMS += ...)
* Les resources (pour les icones par exemple) - RESOURCES += icons.qrc
* Les fichiers additionnels à déployer (INSTALLS += ...) - utile pour copier des fichiers à déployer dans le dossier adéquat (dans notre cas le dossier release/bin/)

```
include(../common/common.pri)
QT       += core
 
TARGET = module1
DEFINES += MODULE1_LIBRARY
TEMPLATE = lib (ou app)
LIBS += -lmodule2
 
SOURCES += ...
HEADERS += ...
FORMS += ...
RESOURCES += ...
```

## Compilation
Cette architecture type de projet présente néanmoins les points d'attention suivants:
* L'ordre de génération à une importance (si le module1 utilise le module2, il faut compiler le module2 en premier)
* Pour que les fichiers soient copiés (les headers dans le dossier intefaces et les binaires dans le dossier bin), il faut exécuter la commande `make install` après la compilation

### Par l'IDE
* Ajouter une étape personnalisée de compilation: `make install` après la compilation
  * Ceci a pour effet de lancer l'étape d'install et donc de copier les fichiers
* Compiler les différents sous-projets un par un et dans l'ordre
* Lorsque tous les sous-projets ont été compilés et installés une première fois, l'ordre n'a plus d'importance tant que les interfaces des dll ne changent pas

### Par script
On peut créer un script qui se charge de compiler un par un les différents sous-projet. Dans ce cas, l'ordre est déterminé par le script.

```cmd
@echo off
set PATH=%PATH%;C:\Qt\Qt5.4.1\Tools\mingw491_32\bin;C:\Qt\Qt5.4.1\5.4\mingw491_32\bin\
set make=mingw32-make.exe
set qmake=qmake.exe

REM CREATE LIST OF MODULES
set modules=module1 module2 moduleN mainModule

REM CLEAR ALL DIRECTORIES
echo ===== Clear output directories =====
rmdir /S /Q debug
rmdir /S /Q release

REM RE-BUILD MAKEFILES
echo ===== Rebuilding makefiles =====
call %qmake% __GLOBAL_RPOJECT__.pro -r -spec win32-g++

REM FOR EACH MODULE: CLEAN MAKE INSTALL
for %%m in (%modules%) do (
    echo ===== Build module %%m =====
    cd %%m
    call %make% clean
    call %make%
    call %make% install
    cd ..
)

REM ADD DEPLOYMENT FILES
echo ===== Add deployment files =====
call windeployqt.exe ./release/bin/ --force --release --no-translations
```

# Resources
Les fichiers de ressource *.qrc permettent de définir des ressources qui seront embarquées dans le binaire final.
* Le fichier qrc est un fichier au format xml
* le plus simple est de l'éditer à l'aid de Qt Creator
* Lors du build, qmake fait appel à l'outil 'rcc' qui génère des fichiers .cpp à partir des fichiers de ressource.
* Ces fichiers cpp sont ensuite compilés avec le reste de l'appli

## Description du fichier qrc
* Le fichier contient des catégories (appelées prefix)
* Dans chaque catégorie, on peut ajouter un ou plusieurs fichiers
* Pour chaque fichier, on peut définir un alias (un alias est un chaine de caractères - avec ou sans extension de fichier, slashes acceptés - qui est utilisée au lieu du nom de fichier
* On peut également spécifier une langue applicable pour le fichier. Dans ce cas, la resource ne sera utilisée que pour la langue spécifiée.
  * on peut alors avoir des fichiers différents selon la langue. Chaque fichier à une langue différente mais un même alias. Qt charge alors automatiquement le bon fichier en fonction de la langue utilisée.

## Accès aux fichiers
* l'accès aux fichiers ressources depuis le code est identique à l'accès au fichiers présent sur le filesystem
* chemin d'accès diffère

```
:prefix/path/to/file/filename.ext     // si pas d'alias
:prefix/alias                         // si alias
Exemple
:/images/theme/picture.jpg
```