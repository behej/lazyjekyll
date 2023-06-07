---
title: Personnaliser le prompt
layout: default
icon: linux.png
---
# Personnaliser le prompt
Le pattern du prompt est défini par la variable $PS1 dans le fichier `.bashrc`. Modifier le pattern pour le configurer selon ses besoins.
* \u : user
* \h : hostname
* \\$ : $ ou # selon qu'on soit utilisateur standard ou root
* \s : shell name
* \v : version du shell
* \w : current workdir
* \d : date
* \\@ : date & time (12h)
* \T : date & time (hh:mm:ss sur 12h)
* \A : date & time (24h)
* \t : date & time (hh:mm:ss sur 24h)
* $(commande) : execute la commande et insère le résultat
* $(__git_ps1) : Affiche la branche courante si le dossier est un repo git
  * le résultat peut être modifié en positionnant des variables d'environnement

# Options Git
* export GIT_PS1_SHOWDIRTYSTATE=1 -> Affiche un symbole si des fichiers modifiés ou prêts en staging area
* export GIT_PS1_SHOWSTASHSTATE=1
* export GIT_PS1_SHOWUNTRACKEDFILES=1 -> affiche un symbole si des fichiers untracked sont présents
* export GIT_PS1_SHOWUPSTREAM=auto\|verbose
* export GIT_PS1_DESCRIBE_STYLE=default\|branch

## Ajouter des couleurs
* \e[XXm : La couleur spécifiée par le XX sera appliquée pour tous les caractères suivants
* \e[0m : Retour à la couleur par défaut pour les caractères suivants


## Couleurs disponibles
### Couleur de fond
A appliquer avec la commande `\e[XXm`. *XX* correspondant à une des couleurs suivantes:
* 40: noir
* 41: rouge
* 42: vert
* 43: jaune
* 44: bleu
* 45: violet
* 46: turquoise
* 47: blanc

### Couleur de texte
A appliquer avec la commande `\e[XXm`. *XX* correspondant à une des couleurs suivantes:
* 30: noir
* 31: rouge
* 32: vert
* 33: jaune
* 34: bleu
* 35: violet
* 36: turquoise
* 37: blanc

### Autres options
On peut également spécifier si le texte doit être affiché en gras, souligné, barré, etc. avec l'option `\e[X;YYm`. *X* correspondant à l'option choisie et *YY* à la couleur.
* 1: gras
* 4: souligné
* 5: clignottant
* 9: barré

### Exemples
```sh
\e[31m           -> rouge
\e[1;31m         -> rouge, gras
\e[4;34m         -> bleu, souligné
\e[1;4;34m       -> bleu, gras, souligné
\e[43m\e[37m     -> blanc sur fond jaune
\e[43;37m        -> blanc sur fond jaune
\e[43m\e[1;37m   -> blanc et gras sur fond jaune
\e[43;1;37m      -> blanc et gras sur fond jaune
```

> 💡 **NOTE:** Le modificateur reste actif tant qu'il n'est pas annulé ou remplacé par un autre modificateur. Pour éviter les effets de bord, il est d'usage d'annuler le modification à la fin du texte avec l'option `\e[0m`.


# Biblio
* [https://www.ostechnix.com/hide-modify-usernamelocalhost-part-terminal/](https://www.ostechnix.com/hide-modify-usernamelocalhost-part-terminal/)
* [https://delicious-insights.com/fr/articles/prompt-git-qui-dechire/](https://delicious-insights.com/fr/articles/prompt-git-qui-dechire/)
* [http://www.tux-planet.fr/les-codes-de-couleurs-en-bash/](http://www.tux-planet.fr/les-codes-de-couleurs-en-bash/)
