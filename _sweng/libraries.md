---
title: Libraries
layout: default
icon: linux.png
---
# Libs statiques ou dynamiques ?

* Libs statiques: fichiers `.a`. Archive de plusieurs fichiers objets. Doit être intégrée à un binaire final (executable ou lib dynamique) pour pouvoir être utilisée.
* Libs dynamiques (ou partagées): fichiers `.so` (pour shared object). Equivalent aux *dll* Windows. Contient du code qui peut être exécuté depuis un ou plusieurs binaires tiers (d'où la notion de *partagée*). Ex: de nombreuses libraries systèmes (libc) sont présentes et peuvent utilisées par n'importe quel exécutable.


# Libs statiques
Une librairie statique est en réalité une archive de un ou plusieurs fichiers objet (`.o` ou `.obj`).

Un fichier objet est un fichier source qui est compilé. Il contient fonctions ou encore des variables, appelés **symbôles**.

> 📝 Note: une lib statique peut bien évidemment être construite avec **gcc**, mais on peut également la construire avec la commande `ar rcs libtoto.a foo.o bar.o ...` 

> 💡 Etant donné que lib statique est une simple archive de plusieurs objets, il est possible d'avoir un même symbôle défini plusieurs fois. On peut très bien avoir une fonction `toto` définie dans plusieurs `.o`.

## Utilisation de la lib
Tous les symbôles de la lib sont utilisables par un autre executable (une autre lib, un elf).

Le code appelant doit simplement *avoir connaissance* de la déclaration des symbôles utilisés. Pour cela, il doit inclure les headers de la lib utilisée. Lorsque le code appelant sera compilé, les symbôles de la lib seront *non définis*.

La résolution des symbôles sera effectuée au moment de link final pour produire un code exécutable: soit un .exe, soit une lib dynamique. C'est uniquement à ce moment que tous les symbôles utilisés doivent être définis.

> 📝 Si une lib statique utilise une autre lib statique, elles ne sont pas link entre elles. La première lib statique fera appel à des symbôles non définis et cela restera ainsi jusqu'au link final.
> 
> Cela signifie également que si lib1 utilise lib2, le code de lib1 **n'embarque pas** le code de lib2. Ce dernier devra être fourni au moment du link final.
>
> C'est différent des lib dynamiques ou des exe: si un exe utilise lib1, alors le code de lib1 se retrouve dans l'exécutable.

## Résolution des symbôles

Au moment de la compilation d'un exécutable (elf ou .so), il faut que tous les symbôles utilisés soient définis au moment du link. Pour cela, le linker va les rechercher un par un et pour cela, il va passer par l'étape de résolution des sylbôles.

Le principe est très simple: un premier fichier objet (.o ou .a) fait appel à un symbôle non défini. Le linker va rechercher ce symbôles dans les autres objets.
* S'il le trouve, le symbôle est utilisé et le link peut poursuivre
* S'il ne le trouve pas, le link échoue et s'arrête

Mais il y a 2 cas de figure particuliers:

### 1. Un symbôle est défini plusieurs fois
Le linker cherche le symbôle et s'arrête dès qu'il l'a trouvé. Cela signifie que si ce même symbôle est défini une seconde fois, mais plus loin dans l'ordre de recherche du linker, cette 2e définition n'est pas considérée.

> ⚠️ **L'ordre de link est important**

**Exemple**
* Un fichier .c fait appel à une fonction `foo()`.
* Cette fonction est définie dans la lib `libtoto.a`
* Cette fonction est définie une seconde fois dans la lib `libtutu.a`

Il va doit falloir indiquer les libs toto et tutu pour compiler le fichier .c. Comme la fonction existe dans les 2 libs, le code peut fonctionner en utilisant indépendamment l'une ou l'autre implem.

L'implémentation utilisée sera celle de la première lib indiquée dans la commande de link.
```cmake
target_link_libraries(main PRIVATE toto tutu)    # l'implem de toto sera utilisée
target_link_libraries(main PRIVATE tutu toto)    # l'implem de tutu sera utilisée
```

> 📝 Cette même logique est applicable si un symbôle est défini plusieurs fois au sein d'une même lib. Le premier symbôle trouvé sera utilisé et les suivants ignorés. L'ordre est défini par l'ordre d'appel des fichiers .o lors de la création de l'archive.
> ```cmake
> add_library(toto STATIC file1.c file2.c)
>```
> Si la même fonction est définie dans file1 et file2, c'est celle de file1 qui sera utilisée


### 2. Un symbôle n'est pas (encore) utilisé
Autre action du linker: il se débarrasse des symbôles non utilisés. Encore une fois, le linker travaille dans l'ordre où les fichiers lui sont donnés.

Si un symbôle n'est pas utilisé **au moment où** le linker traite la lib, ce symbôle n'est pas inclus dans l'exécutable final. Ce qui signifie que si ce symbôle est utilisé par une autre lib mais qui arrive plus tard dans l'ordre des fichiers, il aura été supprimé et ne sera pas dispo pour la lib qui l'utilise.

**Exemple**
* la lib toto définit une fonction `foo()`
* la lib tutu utilise cette fonction

```cmake
target_link_libraries(main PRIVATE toto tutu)
```
AuLe linker traite d'abord `toto`, `foo()` n'est pas encore utilisé et le symbôle est droppé. Puis vient le tour de `tutu` qui utilise `foo()`. Le linker recherche ce symbôle mais ne le trouve pas -> ❌ **Erreur**

```cmake
target_link_libraries(main PRIVATE tutu toto)
```
Le linker traite d'abord `tutu`, il recherche `foo()` et le trouve dans `toto`.

Attention donc à l'ordre des fichiers, surtout si un même symbôle est défini plusieurs fois.

```cmake
target_link_libraries(main PRIVATE toto tutu tata)
```
Si tutu utilise la fonction `foo()` et que celle-ci existe dans `toto` et `tata`. Même si toto arrive en premier dans l'ordre des fichiers, c'est bien l'implem de tata qui sera utilisée.

toto est traité en 1er, le symbôle n'est pas utilisé et droppé. Puis tutu qui utilise le symbôle. Le linker le trouve dans tata.


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