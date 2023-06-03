---
title: Git - revert partiel
layout: default
icon: git.png
---
# Introduction
On va traiter ici un cas un peu particulier mais qui peut nous arriver un jour. Pour aller vite, il nous arrive de grouper plusieurs modifications dans un seul et unique commit. C'est pas très joli et je préfère nettement avoir un commit pour une modification bien précise, même si qu'une seule ligne n'est modifiée, mais j'avoue, il m'arrive de faire des commit fourre-tout.

Tant qu'on avance, cela passe plutôt inaperçu. Le problème survient lorsqu'on veut reculer. Que se passe-t-il si on veut reverter un commit ? ou plus précisément si on ne veut reverter qu'une partie d'un commit. C'est là que les choses se corsent. Pas de panique, tout est possible avec Git et on va voir cela ensemble.

Pour que cela soit plus parlant, on va traiter un exemple concret. Le but du code présenté est uniquement de servir d'exemple. Il ne s'agit pas d'un code réel. Je n'ai même pas essayer de le compiler, le but étant uniquement de manipuler Git.

L'exemple est donc un bout de programme en C qui contient 2 fonctions utilitaires (un min et un max) et avec plusieurs commits. Parmi eux un commit fourre-tout dans lequel j'ajoute des commentaires (parce que c'est toujours mieux) et je supprime des parenthèses superflues. Après avoir passé mon analyseur de code favori, ce dernier m'indique que je n'aurais pas dû supprimer ces parenthèses. Je souhaite donc annuler la suppression des parenthèses mais conserver l'ajout des commentaires. On va voir maintenant comment on peut faire puisque ces 2 modifications ont été groupées dans un seul commit.

# Principe
On va d'abord regarder le principe de la manip avant de l'exécuter sur notre code. La manip est la suivante:
* On revert le commit complet, mais sans le commiter. Les fichiers modifiés (la manip inverse du commit qu'on revert) sont alors dans la staging area.
* Un petit coup de reset (soft hein !) pour virer les fichiers de la staging area
* On rajoute les fichiers à la staging area. On ne les rajoute pas bêtement, on va précautionneusement sélectionner ce qu'on veut rajouter (avec l'option `-p` ou `-i`). C'est ainsi qu'on obient un revert partiel
* On commit notre revert partiel
* On peut dégager les modifs non retenues pour notre revert partiel.

Il y a une petit gymnastique à faire lors de la commande add. On va préparer le commit qui annule partiellement un commit précédent. Il faut donc ajouter les morceaux de code qu'on veut reverter et ne pas ajouter les changements qu'on veut converver. C'est pas clair ? Ce sera plus facile avec un exemple.

Ce qu'il faut garder en tête, c'est que le revert a modifié nos fichiers de façon à défaire le commit complet. Parmi ces modifications, on va en garder certaines et en rejeter d'autres. Ici on veut bel et bien annuler la suppression des parenthèses. On va conserver la partie qui les restaures. Par contre, on ne veut pas annuler l'ajout de commentaires. On va sortir cette partie du commit.

Bon allez, c'est parti !

# La procédure détaillée
## Etat initial
### Fichier
```c
// Return lowest value of both inputs
int min(int a, int b) {
  if a <= b
    return a;
  else
    return b;

// Return highest value of both inputs
int max(int a, int b) {
  if a >= b
    return a;
  else
    return b;

```

### Git history

```sh
* 43f01bb (HEAD -> master) add comments and remove parenthesis
|
* d79f153 Create min and max functions
|
* 875b58c Create main file
```

## Revert
```sh
git revert --no-commit 43f01bb
```

Le commit est entièrement reverté. Etant donné qu'on a spécifié l'option `--no-commit`, l'annulation n'est pas commitée mais reste en **staging area**.

## Reset
```sh
git reset
```
Les modification sont retirées de la staging area, mais restent effectives dans le fichier.

## Add
Maintenant, on va sélectionner uniqement les modifications qu'on veut réellement effectuer, càd les parties du revert qu'on veut réellement appliquer.

```sh
git add -p
```

Git va nous demander pour chaque modification si on veut la pousser en staging area ou non. On va précautionneusement sélectionner uniquement les parties qu'on veut reverter.

> 💡 Si git nous propose tout le commit d'un seul bloc, il est possible de demander à ce que git fractionne le commit en plusieurs plus petits blocs. Pour cela, il faut sélectionner l'option **s** (comme **s**plit).
> 
> Si git n'arrive pas à découper un bloc, il est toujours possible de passer en édition manuelle avec l'option **e** (comme **e**dit)

```sh
@@ -1,4 +1,4 @@
 
 
-// Return lowest value of both inputs
+
 int min(int a, int b) {
(1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? 
```
> **NO**: on veut conserver cette partie --> n

```sh
@@ -4,7 +4,7 @@
 int min(int a, int b) {
-  if a <= b
+  if (a <= b)
     return a;
   else
     return b;
 
 
(2/4) Stage this hunk [y,n,q,a,d,K,j,J,g,/,e,?]? y
```
> **YES**: On veut justement reverter cette partie, et donc restaurer les parenthèses --> y

Une fois la sélection terminée, le fichier `main.c` apparait partiellement dans la staging area et partiellement non validé. C'est normal puisque le fichier contient à la fois des modifications ajoutées et non ajoutées.

```sh
$ git status
Sur la branche master
Modifications qui seront validées :
  (utilisez "git restore --staged <fichier>..." pour désindexer)
	modifié :         main.c

Modifications qui ne seront pas validées :
  (utilisez "git add <fichier>..." pour mettre à jour ce qui sera validé)
  (utilisez "git restore <fichier>..." pour annuler les modifications dans le répertoire de travail)
	modifié :         main.c
```

## Commit
On commit le revert partiel.
```sh
git commit -m "Revert removal of parenthesis"
```

## Reset
Et enfin, on annule la partie du revert qu'on ne retient pas.
```sh
git reset --hard
```

# En résumé
1. git revert --no-commit \<sha\>
2. git reset
3. git add -p
   1. sélection interactive des morceaux à commiter
4. git commit
5. git reset --hard

# Bibliographie
* [https://stackoverflow.com/questions/4795600/reverting-part-of-a-commit-with-git](https://stackoverflow.com/questions/4795600/reverting-part-of-a-commit-with-git)

