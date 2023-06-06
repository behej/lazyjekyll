---
title: Vi
layout: default
icon: vim.png
---
# Gestion
* i : passe en mode insertion
* a : passe en mode insertion après le curseur
* A : passe en mode insertion à la fin de la ligne
* :q : Ferme le fichier courant
* :qa : Ferme tous les fichiers (ferme Vi)
* :q! : quitte avec forçage si fichier non enregistré
* :w : Enregistre le fichier
* :wq ''ou'' :x : Enregistre et quitte
* :w <filename> : enregistre le fichier sous un autre nom
* :!<cmd> : exécute la commande externe cmd
* :help : affiche l'aide
* v : Active le mode visuel. Permet de sélectionner plusieurs lignes (le texte sélectionné est surligné). La sélection s'effectue en déplaçant le curseur
  * Une fois en mode visuel, on peut sauvegarder la sélection avec la commande ':w filename' (même si une ligne est partiellement sélectionnée, elle sera enregistrée en entier)
* :%!xxd : Ouvre le fichier en mode hexadécimal
* :%!xxd -r : Retourne le fichier en mode texte (nécessaire avant de sauvegarder le fichier)

**NOTE:**
Lorsqu'on est en train de taper une commande:
* TAB : autocompletion
* CTRL+D : affiche la liste des commandes qui commencent par ce qui a déjà été tapé

# Déplacement
* :n : Saute directement à la ligne n
* h : gauche
* j : bas
* k : haut
* l : droite
* 0 : début de ligne
* $ : fin de ligne
* w : début de mot suivant
* e : fin de mot
* G : fin de fichier
* gg : début de fichier
* *n* \<commande\> : répète la commande *n* fois. Exemple: 3w: déplace de 3 mots, 4k: descend de 4 lignes, etc.

# Edition
* dw : Efface depuis le curseur jusqu'au début du mot suivant
* de : Efface depuis le curseur jusqu'à la fin du mot
* dd : efface la ligne
* d$ : efface depuis le curseur jusqu'à la fin de la ligne
* x : supprimer le caractère sous le curseur
* r : remplace le caractère sous le curseur
* R : remplace tous les caractères jusqu'à appui sur ECHAP
* ce : Efface depuis le curseur jusqu'à la fin du mot et se place immédiatement en mode édition
* c$ : Efface depuis le curseur jusqu'à la fin de la ligne et se place immédiatement en mode édition
* o : insère une ligne SOUS la ligne courante et se place immédiatement en mode édition
* O : insère une ligne AU DESSUS de la ligne courante et se place immédiatement en mode édition
* :r filename : Insère le contenu du fichier indiqué sous la ligne courante
* :r !cmd : Insère le résultat de la commande sous la ligne courante

> **NOTE:** *N*dw ou d*N*w efface *N* mots. Idem pour de, dd, etc. 
> 
> *Exemple:* 3dd: efface 3 lignes (idem d3d)


# Copier/Coller
* dd : couper la ligne (idem que pour effacer la ligne)
* p : coller (paste) **sous** le ligne du curseur
* y : copier la sélection (réalisée en mode visuel)
* yy : copier la ligne courante


# Rechercher / Remplacer
* /pattern puis Enter : recherche le pattern dans le fichier
* /pattern\c : recherche le pattern sans tenir compte de la casse
* n : recherche l'occurrence suivante
* % : recherche la parenthèse associée (fonctionne aussi pour les crochets et les accolades)
* :s/old/new : remplace la chaine *old* par la chaine *new*. Applicable pour la 1ère occurrence de la ligne courante
* :s/old/new/g : remplace toutes les occurrences de la ligne courante
* :#1:#2s/old/new/g : Remplace toutes les occurrences pour les lignes #1 à #2
* :%s/old/new/g : Remplace toutes les occurrences de tout le fichier
* :%s/old/new/gc : Remplace toutes les occurrences de tout le fichier mais avec demande de confirmation à chaque remplacement

## Options
* :set ic : Ignore case (option active pour toutes le recherches)
* :set hls : Highlight search: Surligne toutes les occurrences trouvées
* :set is : Incremental search : Surligne la prochaine occurrence trouvée au fur et à mesure de la saisie du pattern à rechercher

**NOTES**
1. pour supprimer une option taper `:set no<option>`
2. On peut cumuler les options pour en activer plusieurs à la fois `:set \<option1\> \<option2\>`

# Annuler
* u : Annuler la dernière action
* U : Annule tous les changements effectués sur la ligne courante
* CTRL+R : Rétablit les dernières annulations

# Options
Les options suivantes peuvent être tapées directement dans Vim (précédées du symbole :). Elles auront alors un effet temporaires dans la session courante.
Pour un effet permanent, il faut saisir toutes ces commandes dans le fichier ~/.vimrc.


* set tabstop=4 (ou set ts=4) : Une tabulation équivaut à 4 espaces
* set shiftwidth=4
* set expandtab : Des espaces sont insérés à la place d'une tabulation
* set smarttab
* set autoindent (set ai)
