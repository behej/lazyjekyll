---
title: Bash
layout: default
icon: bash.png
---
# Shebang
Ligne de commentaire à placer au tout début du fichier. Cette ligne indique à Linux le programme à utiliser pour exécuter le script.
```sh
#! /bin/bash 
```
* `/bin/bash` : indique le chemin absolu vers le programme à utiliser
  * Nécessite que le programme soit réellement installé à cet endroit sur la machine cible
* `/usr/bin/env bash` : Utilise les variables d'environnement pour déterminer automatiquement l'emplacement du programme indiqué. Cette solution est plus portable que la précédente.


> Le shebang ne s'applique pas uniquement pour les scripts bash, mais également pour python ou tout autre script.
 
# Modification du comportement du shell
Il est possible de modifier le comportement par défaut en positionnant certaines options à l'aide de la commande `set`.
* **set -e** : exit 1 immédiatement en cas d'erreur (sauf dans les `if`, `&&` et `||`)
* **set -u** : Retourne une erreur en cas de tentative d'accès à une variable indéfinie
* **set -v** : Verbose
* **set -x** : Affiche une trace de l'exécution de chaque commande (utile pour le debug)
* **set -o \<option\>** : positionne l'option correspondante (certaines options possèdent un raccourci court)
  * **pipefail** : Renvoie une erreur si une commande dans un pipe renvoie une erreur (ce n'est pas le cas par défaut)

> Plus d'options dans la [documentation](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html)

# Variables
## Variables particulières
* $# : nombre d'arguments du script ou de la fonction
* $*n* : *n*-ième argument
  * $0 étant le nom du script
* $@ : la liste de tous les arguments du script ou de la fonction sous forme de tableau
  * l'argument $0 (le nom du script) ne figure pas dans cette liste)
* $? : code de retour de la dernière instruction exécutée
* \$$ : PID courant du script en cours
* $! : PID du dernier process exécuté en background
* $LINENO : numéro de ligne courant
* $PATH : path courant

## Opérations sur variables
* $maVar : accès à une variable
* \${maVar} : idem ci-dessus mais identifie clairement les limites du nom de la variable. Utile dans une utilisation type: `echo "${n}th iteration"`
* ${maVar:-default} : Si la variable indiquée n'existe pas, utilise la valeur par défaut à la place
* ${maVar:n:m} : retourne du n-ème au m-ème caractère de la chaine de caractère (ex: ${maVar:0:4} pour les 4 premiers caractères)
* ${maVar:n} : retourne du n-ème caractère de la chaine jusqu'à la fin
* ${maVar^} : retourne la variable mais avec la première lettre en majuscule
* ${maVar^^} : retourne la variable mais avec tous les caractères en majuscules
* ${maVar,} : retourne la variable mais avec la première lettre en minuscule
* ${maVar,,} : retourne la variable mais avec tous les caractères en minuscules
* ${maVar~} : retourne la variable mais en inversant la casse de la première lettre
* ${maVar~~} : retourne la variable mais en inversant la casse de tous les caractères
* ${maVar#pattern} : retourne la variable en supprimant la partie de la chaine qui match le pattern (?=1 unique caractère; *=nombre quelconque de caractères (y compris aucun))
> NOTE: la correspondance se fait uniquement du début de la chaine.
> NOTE: la correspondance se fait sur la partie la plus petit possible.
  * exemples (avec maVar=abcdef)
  * ${maVar#a} --> bcdef
  * ${maVar#a?} --> cdef
  * ${maVar#a*} --> bcdef (l'astérisque ne capture aucun caractère - correspondance la plus petite possible)
* ${maVar##pattern} : idem ci-dessus mais avec la correspondance maximale
  * exemples (avec maVar=abcdef)
  * ${maVar##a*} --> \<rien\> (l'astérisque capture tous les caractères - correspondance maximale)
* ${maVar%pattern} : idem # mais en partant de la fin de la chaine
* ${maVar%%pattern} : idem ci-dessus mais avec la correspondance maximale

## Tableaux & Dictionnaires
### Tableaux
Déclarer un tableau
```sh
myList=(item1 item2 item3)
```
Affecter une valeur à une case du tableau
```sh
tab[0]='valeur'
```
Afficher une valeur du tableau
```sh
echo ${tab[0]}
```
Afficher toutes les valeurs du tableau
```sh
echo ${tab[@]}
```
Afficher toutes les clés du tableau
```sh
echo ${!tab[@]}
```

### Dictionnaires
Déclarer un tableau comme dictionnaire
```sh
declare -A tab
```
Affecter une valeur à une case du tableau
```sh
tab['cle']='valeur'
```
Afficher une valeur du tableau
```sh
echo ${tab['cle']}
```
Afficher toutes les valeurs du tableau
```sh
echo ${tab[@]}
```
Afficher toutes les clés du tableau
```sh
echo ${!tab[@]}
```

# Fonctions
```sh
myfunc()
{
  $# : nombres d'arguments
  $1 : 1er argument
}

myFunc arg1 arg2 ...
```

# portée des variables
* Par défaut une variable est globale
* Si une variable est définie dans une fonction, elle sera globale mais ne sera définie et donc accessible qu'une fois la fonction appelée une 1ère fois
* Pour définir une variable local à une fonction, il faut le faire explicitement avec le mot clé **local**

# exit codes
* dans les fonctions, avec le mot clé **return**
* pour un script entier avec le mot clé **exit**
* On récupère la valeur avec la variable **$?**
* La variable **$?** contient le code d'erreur de la dernière fonction exécutée


# Conditions
## IF/THEN/ELSE
```sh
if [ $maVar -eq 2 ]    # attention aux espace autour des brackets
then
  ...
elif [ $mavar -eq 3] 
then
  ...
else
  ...
fi
if [ $maVar -eq 2 ]; then   # autre syntaxe, ne pas oublier le point-virgule
  ...
fi
```

Syntaxe particulière pour récupérer le code d'erreur d'une fonction sur une seule ligne.
```sh
ERROR=0
myFunc || ERROR=$?
```

## Conditions disponibles
```sh
if [ -z $maVar ]   # si la variable est vide
if [ -n $maVar ]   # si la variable est non vide
if [ -e $fichier ]   # si le fichier/dossier existe
if [ -d $fichier ]   # si le fichier est un dossier
if [ -f $fichier ]   # si le fichier existe et est vraiment un fichier
if [ -s $fichier ]   # si le fichier existe et est non vide
if [ -L $fichier ]   # si le fichier est un lien
if [ -r/w/x $fichier ]   # si le fichier est accessible en lecture/écriture/exécution
if [ $fichier1 -nt/ot $fichier2 ]   # si le fichier1 est plus récent/ancien que fichier2 (nt: newer than / ot: older than)
if [ ! <condition> ]   # si la condition n'est pas remplie
```

## Operateur ternaire
```sh
[ $a -eq 2 ] && funcIfTrue || funcIfFalse      # ici encore, attention aux espaces autour des brackets
```

## FOR
```sh
for var in $liste
do
    ...
done

for i in {1..10}
do
    echo $i
done
```


## WHILE
```sh
while <condition>
do
    ...
done
```

## SWITCH/CASE
```sh
case $maVar in
    "cas1")
        <code>
        ;;
    "cas2")
        <code>
        ;;
    *)
        <default>
        ;;
esac
```

## Parcourir un fichier
### Option 1
Le fichier à lire est indiqué au début de la boucle *while*
```sh
cat file.txt | while IFS= read var1 var2 ; do
    echo $var1 $var2
done
```
* IFS (optionnel) permet d'indiquer le séparateur à utiliser pour découper une ligne
* Chaque morceau découpé de la ligne est affecté aux variables indiquées
  * Si plus de variables que de morceaux découpés &rarr; les variables restantes sont vides
  * Si plus de morceaux que de variables &rarr; La dernière variable contient le reste de la ligne, non découpé

### Option 2
Le fichier à lire est indiqué à la fin de la boucle *while*
```sh
while IFS="/" read var1 var2 ; do
    echo $var1 $var2
done < file.txt
```

### Variante: lire 2 fichiers à la fois *(ou plus)*
```sh
while read var1 && read var2 <&3 ; do
    echo $var1 $var2
done < file1.txt 3< file2.txt
```
* La boucle s'arrête dès qu'un des 2 fichiers atteint la fin



# Itérations
```sh
while <condition>; do
  <do some stuff>
done
```

# operateur ternaire
```sh
[ $a -eq 2 ] && funcIfTrue || funcIfFalse      # ici encore, attention aux espaces autour des brackets
```

# Here document
La syntaxe *here document* permet d'insérer un *document* dans un script bash ou directement dans un terminal.
Typiquement du texte sur plusieurs lignes mais à traiter d'un seul bloc par une seule commande.
```bash
cat << EOF > file.txt
line 1
line 2
EOF
```
Tout le contenu à partir de la ligne suivante les `<<` sera pris en compte par la commande indiquée (ici `cat`), jusqu'à rencontrer le mot-clé spécifié (ici `EOF`).

> **file1.txt**
> ```sh
> line1
> line2
> ```

> **Notes:** 
> * Le mot-clé peut être remplacé par n'importe quel mot
> * Les variables sont remplacées par leur valeur et les commandes entre *back-quotes* sont exécutées
> * Si le mot clé est entre quotes ou précédé par un back-slash, les variables ne sont pas remplacées, les back-quotes ne sont pas exécutées

# Faire des calculs
```sh
echo $((4+2))
> 6

a=3
echo $(($a+5))
> 8

i=$(($i+1))   # equivalent à i++
```


# bc : calculatrice en ligne de commande
```sh
echo "3*50" | bc
> 150

a=50
echo "$a*3" | bc
> 150

a=`echo "3*12" | bc`
echo $a
> 36
```


# Passer des options
Utiliser des options avec les scripts
```sh
./myScript.sh -h
./myScript.sh --help
./myScript.sh -f <option> -v
```

## Options courtes
Si on ne souhaite utiliser que des options courtes, la commande **getopts** est suffisante.
* Toutes les options disponibles collées
* Les options nécessitant un paramètre immédiatement suivies d'un '`:`' 

**Exemple pour un script avec les options suivantes:**
* -h pour l'aide
* -f pour indiquer un nom de fichier. Le nom doit être indiqué juste après l'option
* -v pour verbose

```sh
while getopts "hf:v" opt     # On parcourt toutes les options, en ayant pris soin de spécifier les options autorisées.
do
    case $opt in
        h)
            usage ;;
        f)
            filename=$OPTARG ;;    # Si l'option requiert un argument, celui-ci est dispo dans la variable $OPTARG
        v)
            VERBOSE=1 ;;
        *)
            usage ;;
    esac
done
```

## Options longues
L'utilisation d'options longues (ex: --help) se fait à l'aide de la commande **getopt**
* **-o** pour les options courtes
  * Toutes les options disponibles collées
  * Les options nécessitant un paramètre immédiatement suivies d'un '`:`'
* **-l** pour les options longues
  * Toutes les options dispo séparées par une virgule
  * Les options nécessitant un paramètre immédiatement suivies d'un '`:`'

**Exemple pour un script avec les options suivantes:**
* -h ou --help pour l'aide
* -f ou --file pour indiquer un nom de fichier. Le nom doit être indiqué juste après l'option
* -v pour verbose (pas d'option longue associée)

```sh
options=$(getopt -o hf:v -l help,file: -- "$@")    # Les options sont réarrangées. Les connues sont placée à gauche, puis un double -- et enfin la liste des options inconnues à droite. Les options combinées sont également séparées.
 
eval set -- "$options"   # Utilise la liste 'options' et la réinjecte en tant qu'argument du script. 
while true; do 
    case "$1" in     # L'option en cours d'analyse est en position 1
        -h|--help)
            usage      # On défini généralement une fonction usage() qui affiche les utilisations possibles du script
            break;;    # Instruction break qui permet de sortir de la boucle 'while true'
        -f|--file)
            fileName=$2    # L'argument placé après l'option est en position 2
            shift 2;;      # L'option et son argument ont été traités. On décale de 2 pour passer à la suite des options
        -v)
            VERBOSE=1
            shift;;      # On a mémorisé l'option -v dans une variable interne. On décale pour continuer à traiter les autres options.
        --)              # Fin des options connues. On interrompt la boucle (on peut continuer si on veut exploiter les autres options inconnues, mais il faut être sûr de quitter la boucle 'while true'.
            break;;
        *) usage      # Cas par défaut. On peut soit afficher un message d'erreur, soit rappeler le usage.
            break;;
    esac 
done
```

**Exemple de fonction usage()**
```sh
usage()
{
    echo "Usage: ./myScript.sh [options]" 
    echo "-h|--help                Display this help" 
    echo "-f|--file <filename>     Do whatever with the given file"
    echo "-v"                      Verbose"
}
```

### Tips
* Si l'ordre des options a de l'importance, il faut ajouter un tiret avant la première option courte.
> *Exemple:* `getopt -o -hf:v`
