---
title: Outils d'inspection
layout: default
icon: binary.png
---
# Introduction
Les fichiers compilés existent sous plusieurs formes:
* .o : fichier objet. Contient le code compilé d'un fichier source
* .a : librairie statique. Assemblage de plusieurs .o. Doit lui-même être assemblé pour créer un exécutable
* .so : librairie dynamique. Contient du code exécutable qui sera chargé dynamiquement par un exécutable
* .exe : Fichier executable. Contient tout ou partie du code exécutable d'un programme
* .elf : **E**xecutable and **L**inking **F**ormat. globalement tous les fichiers cité ci-dessus.

Il existe une multitude d'outils pour analyser le contenu de ces fichiers.

## ldd
Permet de lister les dépendances d'un fichier et d'indiquer lesquelles sont utilisées

```sh
ldd <binaire>
```



## nm
Liste tous les symbôles présents dans un exécutable. Les symbôles correspondent aux fonctions, classes, variables qu'on peut écrire dans un code source.

```sh
nm <binaire>

> output:
         U external_function
00000000 T internal_function1
00000000 T internal_function2
```


On obtient tous les symboles contenus dans le fichier
* 1ère colonne: adresse du symbole
* 2e colonne: le type
* 3e colonne: le nom du symbole

| Type | Description |
|:----:|-------------|
| B | BSS - variable globale non initialisée |
| b | BSS - variable locale non initialisée |
| D | Data - variable globale initialisée |
| d | Data - variable locale initialisée |
| R | Read only data - constante globale |
| r | Read only data - constante locale |
| T    | Text - dans la section text, ce qui signifie que le symbole est définit et correspond à du code |
| t    | text - mais privé |
| U    | Undefined - le symbôle est utilisé mais non défini. Il devra être fourni par un autre exécutable au moment du link.  |
| W    | Weak - si un autre symbôle de même nom est trouvé ailleurs, alors cet autre symbôle sera utilisé de préférence |

### Options utiles

| Option | Description |
|:---:|--------|
| -A | affiche toujours le nom du fichier devant l'adresse (pratique lorsqu'on liste les symboles d'une lib qui regroupe plusieurs objets) |
| -C | demangle des symboles |
| -D | Affiche uniquement les symbôles dynamiques |
| -v | trier par nom |
| -S | trier par taille d'objet |
| -n | trier par adresse |
| -r | inverse l'ordre |
| -u | uniquement les symboles non définis |
| -g | uniquement les symboles externes |

## file

Permet d'avoir des informations rapides sur le type d'un fichier.

Permet de savoir si le fichier est du code source, une lib so, une archive .a, un exécutable, etc. Si le fichier est destiné aux architectures x86, arm, s'il est 32 ou 64 bits.

> ne s'applique pas uniquement aux binaires mais à tous les types de fichiers.


## readelf
Permet de lire les différentes sections d'un fichier elf et d'obtenir des infos sur le binaire.

### Header
`readelf -h binaire`

Lit le header pour avoir des infos générales

### Dynamic
`readelf -d binaire`

Permet d'avoir des infos sur les liens dynamiques du binaire

* NEEDED: les libs requises par le binaire
* RUNPATH: le dossier dans lequel le binaire va cherher les libs
* SONAME: le nom de la lib dans le cas d'un .so 



## objdump
Permet de dumper tout le contenu d'un fichier binaire.

Dans une utilisation basique, son utilité est très proche de **readelf**.

* `objdump -p binaire`: permet d'avoir des infos sur les libs requises


