---
title: Libraries
layout: default
icon: linux.png
---
# Libs statiques ou dynamiques ?

* Libs statiques: fichiers `.a`. Archive de plusieurs fichiers objets. Doit être intégrée à un binaire final (executable ou lib dynamique) pour pouvoir être utilisée.
* Libs dynamiques (ou partagées): fichiers `.so` (pour shared object). Equivalent aux *dll* Windows. Contient du code qui peut être exécuté depuis un ou plusieurs binaires tiers (d'où la notion de *partagée*). Ex: de nombreuses libraries systèmes (libc) sont présentes et peuvent utilisées par n'importe quel exécutable.


# Libs dynamiques
## Conventions
Pour une lib contenant des fonctions utilitaires et qu'on appellera utils, on définit plusieurs noms:
* le nom de lib: '**soname**' : le préfix '*lib*' + le nom de la lib + "*.so*" + "." + version majeure
  * ex: *libutils.so.1*
* le nom de fichier : soname + "." + version mineure [+ "." + build]
  * ex: libutils.so.1.0.0


## Créer une lib
```sh
gcc -fPIC -c -o utils.o utils.c
```
* -fPIC : position independant code
* -c : no link

```sh
gcc -shared -o libutils.so.1.0.0 utils.o
```

* -shared : crée une lib partagée (so = shared object)

## Utiliser la lib
### Installer la lib
Copier la lib dans `/usr/local/lib/`
```sh
sudo cp libutils.so.1.0.0 /usr/local/lib/
```

Créer les liens symboliques pour ne pas être obligé de connaitre la version précise
```sh
sudo ln -s libutils.so.1.0.0 libutils.so.1
sudo ln -s libutils.so.1.0.0 libutils.so
```

A partir de maintenant, la lib est dans un dossier inclus qui est scruté par défaut lors d'une compil. On change la ligne de commande pour la compil pour modifier le link: on ajoute l'option `-l` et on colle directement le nom de la lib (sans le préfixe "lib" ni sans l'extension .so)
```sh
gcc -o test main.c -lutils
```

Par contre, l'exécution plante toujours. Il faut créer les liens pour l'exécution
```sh
ldconfig
```
Cette commande met un jour un cache avec toutes les lib.

### L'utiliser in situ
Fichier main.c qui effectue un appel à la lib utils.

Il faut compiler le prog en indiquant la lib à linker
```sh
gcc -o test main.c libutils.so.1.0.0
```

Pour l'utiliser, il faut soit que la lib ait été installée, sinon il faut ajouter l'emplacement de la lib dans la variable d'environnement `LD_LIBRARY_PATH`
```sh
export LD_LIBRARY_PATH=/path/to/library:${LD_LIBRARY_PATH}
```

#### Variante
Si la lib est nommée libutils.so (sans numéros de version), on peut également la compiler avec la ligne de commande suivante:
```sh
gcc -Lpath/to/lib -o test main.c -lutils
```

* l'option `-l` indique la lib à linker (même s'il est n'est pas dans le dossier `/usr/local/lib/`)
* l'option `-L` indique où trouver la lib

## Utilitaires
### Retrouver une lib
```sh
ldconfig -p | grep libxxx
```


# Bibliographie
* [Building and using static and shared libs](https://docencia.ac.upc.edu/FIB/USO/Bibliografia/unix-c-libraries.html)
* [Order to link libs does matter](https://stackoverflow.com/questions/45135/why-does-the-order-in-which-libraries-are-linked-sometimes-cause-errors-in-gcc)
* [Libs versionning and compatibility](https://begriffs.com/posts/2021-07-04-shared-libraries.html)
* [Particularité à propos de la résolution des symbôles](https://coyorkdow.github.io/linking/2024/11/17/C++_linking_linux.html)
* 