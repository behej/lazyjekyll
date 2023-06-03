---
title: Git - stats
layout: default
icon: git.png
---
# Nombre de commits
```sh
git --rev-list --count commit1..commit2
```

\<commit1\> peut être soit un hash de commit, un tag ou encore une branche.

# Différences entre commits
```sh
git diff commit1..commit2
git diff commit1..commit2 -- files
```

## Options
\-\-name-only: uniquement les noms des fichiers modifiés

\-\-diff-filter=[ACDMRTUXB*]
* A Added
* C Copied
* D Deleted
* M Modified
* R Renamed
* T have their type (mode) changed
* U Unmerged
* X Unknown
* B have had their pairing Broken
  * All-or-none

## Filtre sur les fichiers
```sh
folder1/* : All files within folder1/
!(folder2) : ignore folder2/
```

# Différences entre commits sur branches différentes
Prenons l'arbre suivant:
```
     E--F--G branche1
    /
A--B--C--D master
```

## Différence simple entre 2 commits
```sh
git diff D..G
git diff master..branch1
```

Ces commandes donnent la liste de toutes les différences du commit G par rapport à D:
* les commits C et D seront vus comme "supprimés"
* les commits E, F et G seront vus comme "ajoutés"

## Différence d'une seule branche
```sh
git diff D...G
git diff master...branch1
```

Ces commandes donnent la liste des différences du commit G (ou de la branche **branch1**) depuis qu'elle a divergé de master. = toutes les différences de G par rapport à son dernier ancêtre commun avec D.
* les commits E, F et G seront vus comme "ajoutés"
* les commits C et D n'apparaitront pas


# Biblio
* [https://stackoverflow.com/questions/6879501/filter-git-diff-by-type-of-change](https://stackoverflow.com/questions/6879501/filter-git-diff-by-type-of-change)
* [https://matthew-brett.github.io/pydagogue/git_diff_dots.html#diff-with-two-dots](https://matthew-brett.github.io/pydagogue/git_diff_dots.html#diff-with-two-dots)
