---
title: Tcl/Tk
layout: default
icon: tcl_tk.png
---
# Généralités
* Une ligne d'instruction commence toujours par une commande
* Chaque argument est séparé par un espace
* Une ligne peut se terminer par un point-virgule (facultatif sauf si on place un commentaire à la suite)
* Les commentaires commencent par le caractère **`#`**
* En Tcl, tout est chaîne de caractères
* Avant d'exécuter la commande, le langage substitue tout ce qui est possible dans la ligne
* L'anti-slash (**`\`**) est le caractère d'échappement
* L'anti-slash (**`\`**) en fin de ligne est un caractère de continuation de ligne (La ligne suivante est considérée comme écrite sur la même ligne)
* Les arguments passés lors de l'appel d'un script sont accessibles par les variables globales:  `argc`: nombre d'arguments, `argv0`: nom du script et `argv`: liste des arguments.


# Commandes de base

**puts** *param*
* affiche le paramètre à l'écran

**set** *variable* valeur*
* Affecter la *valeur* à la *variable*. Si *valeur* n'est pas spécifiée, la commande affiche le contenu de la *'variable*

**unset** *variable*
* Détruit la variable

**expr*** {*expression*}
* Evalue l'expression (généralement mathématique) passée en paramètre. Les accolades ne sont pas obligatoires mais fortement conseillées pour éviter l'injection de code

**Conditions If/Then/Else**
```tcl
if {cond} {
  {cmd1}
} else/elseif {
  {cmd2}
}
```

**Switch**
```tcl
switch var {
  case chaine {
    cmd1}
  default {
    cmd2}
  }
```

**Boucle while**
```tcl
while cond
  cmd
  ```

**Boucle For**
```tcl
for init cond step
  cmd
  ```

**break**
* Interrompt totalement l'exécution d'une boucle

**continue**
* Interrompt l'itération courante de la boucle et passe à l'itération suivante

**incr** *var*
* Incrémentation

**Définition d'une fonction**
```tcl
proc nom arguments {
  code
  return }
```
* On peut déclarer plusieurs arguments si on les place entre accolades. Lors de l'exécution de la fonction les arguments sont définis en tant que variables locales. Le return est optionnel. Il définit la valeur de retour de la fonction. Si omis, c'est la valeur de retour de la dernière instruction qui est utilisée.

```tcl
proc nom {arg1 {arg2 defVal}} {
  code
  return }
```
* La valeur par défaut *defVal* est assignée à l'argument 2 si la valeur n'est pas définie lors de l'appel de la fonction

```tcl
proc nom {arg1 args} { 
  code
  return }
```
* La fonction accepte un nombre variable de paramètres. Les paramètres supplémentaires sont assignés à la variable *args* (sous forme de liste si plus de 1)

**global** *var*
* Crée une variable local *var* qui est un lien vers la variable globale du même nom

**upvar** *level $param var*
* Crée une variable locale *var* qui pointe vers la variable du niveau supérieur passée en paramètre. *level* est facultatif et vaut par défaut 1 (1 niveau au dessus). Si level vaut *i*, on remonte au i-ème niveau supérieur. Si level vaut `#i`, on va au i-ème niveau sous le niveau global

**exec** *programme args ?&?*
* Exécute *programme*. Les paramètres *args* sont passés au programme exécuté. Si le symbole & est ajouté à la fin, le programme est exécuté en arrière plan.


**open** *programme*

**info** *sous-commande*
* Renvoie des infos diverses sur l'environnement. Généralement, renvoie la liste des éléments existants. commands / exists varName / functions / globals / locals / procs / vars / cmdcount / level / patchlevel / script / tclversion / args procname / body procname / default procname arg varName

**pid**
* Renvoie le PID du script tcl

**source** *fichier*
* Charge et exécute le fichier. Utile pour structurer un programme en plusieurs fichiers/modules

**cd** *dir*
* change le répertoire courant


**pwd**
* Affiche le répertoire courant

**time** *{commande} ?count?*
* Exécute la commande et renvoie le temps d'exécution. Si *count* est spécifié, le script est exécuté *count* fois et time renvoie le temps d'exécution moyen

# Substitutions
Tcl procède en 2 étapes:
1. Substitution des expressions (remplacement des variables par leur valeurs) - une seule passe
2. Evaluation des expressions


## Double quotes " "
* Le texte entre quotes est considéré comme un tout.
* Les quotes autorisent les substitutions à l'intérieur des quotes

## Accolades { }
* Le texte entre accolades est considéré comme un tout.
* Les accolades désactivent les substitutions à l'intérieur des accolades (sauf dans les cas des expressions)
* Des accolades à l'intérieur d'un bloc *quote* sont considérées comme un simple caractère (i.e. elles ne désactivent pas la substitution)

## Crochets [ ]
* Une commande placée entre crochets est d'abord évaluée avant d'exécuter la ligne complète
* Des crochets à l'intérieur d'un bloc *accolades* ne sont pas évalués
* Des crochets à l'intérieur d'un bloc *quote* sont évalués

## Commandes liées

| Commande | Description |
|-|-|
| **eval** *$var* | Evalue la variable comme s'il s'agissait d'une commande. Si *$var* vaut `puts "toto"`, la commande `eval $var` affichera *toto*.
| **subst** | Force la substitution au moment de l'évaluation. Peut être utile quand une variable contient le nom d'une variable. |

# Opérateurs

| Opérateur | Description |
|-|-|
| + | Addition *ou* plus unaire |
| -| Soustraction *ou* moins unaire
| * | Multiplication |
| / | Division |
| %| Reste de la division euclidienne |
| **| Exposant |
| ~ | Inversion bit à bit |
| ! | NON logique |
| & | ET bit à bit |
| && | ET logique |
| \| | OU bit à bit |
| \|\| | OU logique |
| ^ | XOR bit à bit |
| < / <= / > / >= / == / != | Opérateurs de comparaison |
| eq | Comparateur d'égalité. Différent de == car compare les opérandes en tant que chaîne de caractère et non en tant que nombre. |
| ne | Comparateur d'inégalité. Différent de != car compare les opérandes en tant que chaîne de caractère et non en tant que nombre. |
| in | Cherche si une chaîne est comprise dans une liste |
| ni | Not In: Cherche si une chaîne n'est pas comprise dans une liste |
| x?y:z | Opérateur ternaire |


## Fonction mathématiques
* abs
* acos
* asin
* atan
* atan2
* bool
* ceil
* cos
* cosh
* double
* entier
* exp
* floor
* fmod
* hypot
* int
* isqrt
* log
* log10
* max
* min
* pow
* rand
* round
* sin
* sinh
* sqrt
* srand
* tan
* tanh
* wide

## Transtypage
* double()
* int()
* wide()
* entier()



# Listes

|Instruction|Description|
|-|-|
| **set** *listName* {*val1 val2 ...*} | Crée une variable de type *liste* |
| **list** *val1 val2 ...* | Retourne une liste avec les valeurs listées |
| **split** *"listeDeValeursSéparéesParUnCaract" separateur* | Crée une liste en scindant la liste de valeurs en éléments séparés par le séparateur spécifié (Valeur par défaut du séparateur: *espace*). Si le séparateur est constitué de plusieurs caractères, chaque caractère est considéré comme un séparateur. |
| **join** *liste separateur* | Réalise l'inverse de *split*. Crée une chaîne contenant tous les éléments de la liste séparés par le séparateur indiqué |
| **lindex** *liste pos* | Retourne l'élément situé à la position *pos* de la liste |
| **lrange** *liste posDeb posFin* | Retourne la portion de la liste comprise entre *posDeb* et *posFin* |
| **llength** *liste* | Retourne la taille de la liste |
| **foreach** *var list* | Parcourt tous les éléments de la liste. L'élément courant est accessible par la variable *var*. **Astuce:** *var* peut être plusieurs variables pour parcourir les éléments de la liste 2 par 2, 3 par 3, etc. On peut également parcourir plusieurs listes à la fois.
| *code* | |
| **concat** *val1 val2* | Concatène les valeurs en une liste |
| **lappend** *liste val1 val2 ...* | Ajoute les valeurs à la fin de la liste |
| **linsert** *liste pos val1 val2 ...* | Insert les valeurs à la position indiquée |
| **lreplace** *liste posDeb posFin val1 val2 ...* | Remplace les éléments entre *posDeb* et *posFin* par les valeurs données. Si moins de valeurs sont données, les autres valeurs sont effacées|
| **lsearch** *liste elemt* | Retourne la position le l'élément recherché. Retourne -1 si pas trouvé |
|**lsort** *liste* | Trie la liste |

# Arrays
* En Tcl, on utilise des tableaux associatifs.
* Pour accéder à un élément, on utilise la syntaxe tableau(clé). Exemple `set id(prenom) Jérôme'` ou `puts $id(prenom)`


## Opérations sur les tableaux
Les fonctions liées aux tableaux sont des sous-commandes de la commande **`array`**.

|Instruction|Description|
|-|-|
| **exists** *nomTab* | Renvoie 1 si *nomTab* existe ET si est un tableau |
| **names** *tab pattern* | Renvoie la liste des clés du tableau qui correspondent au pattern. *pattern* est facultatif, si omis la liste complète des clés est retournée. |
| **size** *tab* | Renvoie le nombre d'éléments contenus dans le tableau |
| **get** *tab* | Convertit le tableau en liste de la forme {cle1 val1 cle2 val2 ...} |
| **set** *tab list* | Convertit la liste en tableau associatif. La liste fournie doit être du même format qu'une liste retournée par la fonction *get* |
| **unset** *tab pattern* | Efface les éléments dont la clé correspond au *pattern*. *pattern* est facultatif, si omis toutes les clés sont effacées. |


## Parcourir un tableau
```tcl
foreach cle [array names tab] {     // On établit la liste des clés du tableau puis on parcourt chacun des éléments de cette liste
    puts $tab($cle)                // On accède à la valeur correspond à la clé en cours
}
```

```tcl
foreach {cle valeur} [array get tab] {     // On crée une liste avec les clés et les valeurs et on parcourt cette liste en récupérant ces infos 2 par 2
    puts $cle          // on accède à la clé
    puts $valeur       // on accède à la valeur
}
```

## Passage d'un tableau en paramètre
Pour passer un tableau en paramètres à une procédure, il faut:
* Passer le **nom** du tableau (ie sans le $)
* Effectuer un **upvar** dans la procédure

```tcl
proc toto tab {
    upvar $tab t     // fonction upvar
    puts $t(cle)     // on accède au tableau
}
``` 

```tcl
toto tableau     // Appel de la procédure avec le nom du tableau
``` 

# Strings
La commande **`string`** nécessite des sous-commandes pour réaliser l'action désirée.

**Exemple:** `string length $myString`

# Opérations sur les chaînes

|Instruction|Description|
|-|-|
| **string length** *chaine* | Longueur d'une chaine |
| **string index** *chaine pos* | Retourne le caractère qui se trouve à la position *pos* |
| **string range** *chaine deb fin* | Retourne le morceau de chaine entre les positions *deb* et *fin* |
| **string compare** *chaine1 chaine2* | Compare les chaines. -1 si chaine1\<chaine2, +1 si chaine1\>chaine2, 0 si chaine1=chaine2 |
| **string first** *chaine1 chaine2* | Cherche *chaine1* dans *chaine2* et renvoie la position de la 1ère occurence |
| **string last** *chaine1 chaine2* | Cherche *chaine1* dans *chaine2* et renvoie la position de la dernière occurence |
| **string wordend** *chaine pos* | Identifie le mot situé autour de la position *pos*. Retourne l'index du caractère juste après ce mot. Un mot est une suite continue de lettres, chiffres ou underscore |
| **string wordstart** *chaine pos* | Identifie le mot situé autour de la position *pos*. Retourne l'index du premier caractère de ce mot |
| **string match** *pattern chaine* | Renvoie 1 si le pattern est trouvé dans la chaine. |
| **string tolower** *chaine* | Transforme les caractères en minuscules |
| **string toupper** *chaine* | Transforme les caractères en majuscules |
| **string trim** *chaine caract* | Supprime les caractères spécifiés se trouvant à chaque extrémité de la chaine. Par défaut, les caractères sont les espaces, les tab et les newlines. Si une chaine est utilisée comme *caract*, chaque caractère qui la compose est individuellement considéré. |
| **string trimleft** *chaine caract* | Idem trim mais uniquement à gauche |
| **string trimright** *chaine caract* | Idem trim mais uniquement à droite |
| **format** *modèle arguments* | Crée une chaîne de caractère à la manière de *sprintf* |

## Expressions régulières
* **`regexp`** *expr chaine varMatch varGroup1 varGroup2* ...
  * Recherche l'expression régulière *expr* dans la chaîne.
  * la portion de la chaîne qui correspond à la regexp est stockée dans la variable varMatch
  * Si des groupes sont présents dans la regexp (portions de regexp entre paranthèses), le résultat de chaque groupe est placé dans varGroup*i*
* **`regsub`** *expr chaine remplac var*
  * Recherche l'expression régulière *expr* dans la chaîne et remplace toutes les occurrences par la chaîne définie dans *remplac*
  * Le résultat est retourné dans *var*



# Manipulation de fichiers
## Lire/Ecrire dans des fichiers

|Instruction|Description|
|-|-|
| **open** *fichier access* | Ouvre le fichier spécifié avec les accès indiqués: r: read / w: write / a: append / a+: append and create is doesn't exist. Renvoi un handler sur le fichier |
| **close** *fichier* | Ferme le fichier |
| **gets** *fichier ?var?* | Si *var* n'est pas spécifié, retourne la ligne lue depuis le fichier et passe à la ligne suivante. Retourne une chaîne vide si EOF. Si *var* est spécifié, la ligne lue est placée dans *var* et la fonction retourne le nombre de caractères lus ou -1 si EOF. |
| **puts** *?-nonewline? fichier chaine*| Ecrit la chaine dans le fichier puis crée une nouvelle ligne. *fichier* peut aussi valeur *stdout* ou *stderr*. Avec *-nonewline*, la nouvelle ligne n'est pas créée |
| **read** *?-nonewline? fichier* | Retourne le contenu du fichier depuis la position actuelle jusqu'à la fin. Si *-nonewline* est précisé, si le dernière caractère est une nouvelle ligne, il est supprimé. |
| **read** *fichier nbcar* | Retourne *nbCar* du fichier |
| **seek** *fichier offset ?origine?* | Déplace le curseur dans le fichier. *Origine*' peut valoir **start, current* ou *end*. La variable *fichier* peut également valoir *stdin*, *stdout* ou *stderr* |
| **tell** *fichier* | Renvoie la position actuelle du curseur |
| **flush** *fichier* | Force l'écriture du fichier |
| **eof** *fichier* | Renvoi 1 si la fin du fichier est atteinte|


## Manipuler des fichiers/répertoires
* **`glob`** *pattern*: liste les fichier qui correspondent au *pattern*
* **`file`**: Nécessite une des sous-commandes suivantes:
  * Manipulation du nom d'un fichier
    * dirname
    * extension
    * join
    * nativename
    * rootname
    * split
    * tail
  * Information sur un fichier
    * atime
    * executable
    * exists
    * isdirectory
    * isfile
    * lstat
    * mtime
    * owned
    * readable
    * readlink
    * size
    * stat
    * type
    * writable
  * Action sur un fichier/répertoire
    * copy
    * delete
    * mkdir
    * rename


# Namespaces & Packages
## Namespaces
* Un namespace est un espace dans lequel les variables et procédures dont indépendantes des autres namespaces
* Pour accéder à une variable d'un namespace, on utilise la syntaxe: **`nomEspace::maVar`** (en relatif) ou **`::nomEspace::maVar`** (en absolu depuis l'espace global)

|Commande|Description|
|-|-|
| **namespace eval** *nomEspace*  *script* | Crée le namespace *nomEspace* et exécute le script |
| **namespace delete** *nomEspace* | Supprime le(s) namespace(s) indiqué(s) et toutes les variables s'y trouvant |
| **namespace current** | Renvoie l'arborescence complète du namespace courrant |
| **namespace export** *pattern* | Rend accessible tous les éléments (proc, var) qui correspondent au pattern à l'extérieur du namespace |
| **namespace import** *pattern* | Importe tous les éléments qui correspondent au pattern dans le namespace courrant. Le pattern peut être du type *::nomEspace::proc_\** |
| **namespace ensemble create** | Toutes les éléments exportés du namespace seront accessible sous la forme d'une sous-commande. Les syntaxes *NomEspace::proc* deviennent *NomEspace proc* |

## Packages
Un package permet d'empaqueter un ensemble cohérent de fonctions, généralement à l'intérieur d'un namespace.

Pour créer et utiliser un package, 3 étapes:
1. Coder le package. Au début du package doit se trouver l'instruction **package provide** *nomPack ?version?* pour indiquer à Tcl qu'on fournit le package suivant.
2. Créer un index. L'index est créé avec la commande **pkg_mkIndex** *repertoire ?pattern?*. Cette étape a pour effet de créer un fichier *pkgIndex.tcl* pour permettre à tcl d'indexer le package.
3. Ajouter le répertoire contenant le fichier *pkgIndex.tcl* à l'une des variables globales **auto_path** ou **tcl_pkgPath**. Ces variables contiennent la liste des répertoires que va explorer Tcl pour indexer les packages.

|Commande|Description|
|-|-|
| **package provide** *nomPaquet ?version?* | Annonce à Tcl qu'on fournit le paquet |
| **package require** *?-exact? nomPaquet ?version?* | Charge le paquet demandé dans la version indiquée (si indiqué). Si *-exact* est précisé, la version spécifiée doit parfaitement correspondre. Sinon la version peut être supérieure ou égale à la version demandée (la version majeure doit quand même être respectée) |


### Exemple type d'un package:
```tcl
package provide monPaquet 1.0		// Annonce à Tcl qu'on fournit le monPaquet en version 1.0
package require autreDependance 2.5    // ce paquet requiert un autre paquet pour fonctionner
 
# Création du namespace
namespace eval ::paqNameSpace {
    namespace export proc1 proc2      // Rend les éléments listés accessible par l'extérieur du namespace
 
    variable maVar1 0                 // Crée une variable globale au namespace
    variable maVar2 "du texte"
}
 
 
# Définition des procédures
proc ::paqNameSpace::proc1 {param} {
    variable maVar1                   // Crée une variable locale qui est un alias vers la var globale du namespace du même nom
 
    // Code
}
```

# Gestion des erreurs
* Une fonction retourne toujours un statut indiquant la présence d'une erreur ou non.
* le statut est retourné implicitement (uniquement en cas d'erreur) ou explicitement (avec les commandes return ou error)
* Tcl propose un mécanisme pour vérifier le statut d'une fonction

|||
|-|-|
| **error** *message ?info? ?codeErr?* | Renvoie explicitement une erreur. *info* contient un texte d'information pour aiguiller le debogage et *codeErr* contient le code d'erreur. |
| **return** -code code -errorinfo info -errorcode codeErr ?value? | Utilise la fonction return pour renvoyer une erreur. ` -code` peut renvoyer *ok, error, return, break, continue*. *info* est le texte d'information et *codeErr* le code d'erreur. |
| **catch** *commande ?args?* | Exécute la commande (avec ses éventuels arguments) et récupère les erreurs. Catch renvoie 1 si la commande ne s'est pas déroulée correctement |
| **errorInfo** | Variable globale qui contient le texte d'information de la dernière erreur |
| **errorCode** | Variable globale qui contient le code d'erreur de la dernière erreur |

