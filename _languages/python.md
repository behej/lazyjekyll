---
title: Python
layout: default
icon: python.png
---
# Règles de syntaxe
* Commentaire: #
* L'indentation permet de délimiter les bloc de code (par exemple pour une condition ou une boucle)
* Les chaines de caractères sont délimités par des quotes simples, des double quotes ou encore des triples double quotes
  * Les triples double quotes (ex: `"""ma chaine"""`) permettent d'écrire une chaine sur plusieurs lignes et que chaque retour chariot sont retranscrit tel quel dans la chaine
* On écrit une ligne de code sur 2 lignes en terminant la première ligne par un backslash
* Après le nom de la fonction, on peut rajouter un commentaire (indenté bien sûr) avec des triple double quotes. Ce commentaire sera utilisé pour la documentation (notamment en faisant ''help(NomFonction)''
* Rendre un script executable directement
  * Rajouter `#! /usr/bin/python3` en 1ère ligne du fichier (Linux) : indique à Linux le chemin vers python pour exécuter le script
  * Rajouter `#-*-coding:utf-8-*-` en 2e ligne pour indiquer l'encodage. utf-8 pour Linux, Latin-1 pour Windows

# Instructions de base
* del: Détruit un objet
* Mots clé pour les tests: `and`, `or` et `not`
* Bloc if
```python
if condition:
  code
else:
  code
if condition
  code
elif condition:
  code
else:
  code
```

* Bloc while
```python
while condition:
  code
```

* Bloc for
```python
for element in sequence:
  code
```

* Teste la présence d'un élément dans une séquence:
```python
if element in sequence:
```

* Affiche une variable à l'écran
```python
print(arg1, arg2, ...)
print("Hello World")
print("Hello {}".format(name))
print("Hello World", end="\r")    # spécifie le caractère de fin. Ici un retour chariot, donc la prochaine ligne sera écrite par dessus celle-ci.
```

# Exceptions
```python
try:
  code
except:
  traitement de l'exception
```

* Catch les exceptions correspondant au type indiqué. Note: on peut enchainer plusieurs except avec des type différents
  * exemple d'exceptions: ValueError, NameError, TypeError, ZeroDivisionError

```python
except typeException:
```

* Récupère l'exception: Crée un objet correspondant à l'exception levée

```python
except typeException as objetException:
```

* Définir du code si aucune exception n'est levée: cela se fait avec le mot `else`
```python
try:
except ...:
else:
  code
```

* Exécuter du code après le bloc try, quelque soit le résultat. Ce code s'exécutera même si le `try` ou les `except` contiennent un `return`. Cela se fait avec le mot clé `finally`
* Catcher une erreur mais ne rien faire: mot clé `pass`
```python
try:
  code
except typeException
  pass
```

* Assertions: mot clé `assert`. Lève une exception `AssertionError`.
```python
assert test
```

* Lever une exception: `raise TypeException("message d'erreur")`


## Exceptions personnalisées
On peut définir nos propres classes d'exception
```python
class MonException(Exception):
  __init__(self, message):
    self.message = message
  __str__(self):
    return self.message
```

* La classe d'exception personnalisée hérite généralement de `Exception` ou `BaseException`
* Il faut à minima définir un constructeur et un méthode `__str__`

# Fonctions de base

| Fonction | Description |
|----------|-------------|
| // | Division entière |
| type(var) | Donne le type de la variable |
| print(var1, var2) | Affiche une variable à l'écran |
| break | Abandonne la boucle en cours |
| continue | Abandonne l'itération de la boucle en cours et exécute immédiatement l'itération suivante |
| def nomFonction(param1, param2): | Définition d'une fonction. **Note:** on peut appeler la fonction fonction(2, 3) ou encore fonction(param1=2, param2=3). La 2e syntaxe permet d'identifier le paramètre si beaucoup de paramètres
| def nomFonction(param1=val1, param2): | Affectation d'une valeur par défaut pour un paramètre |
| return param | Renvoie une valeur en retour d'une fonction |
| return 'param1, param2 | Renvoie un tuple constitué de param1 et param2 |
| f=lambda param1, param2: code avec param1 et param2 sur une seule ligne | Crée une fonction lambda: une fonction très courte pouvant sécrire sur une seule ligne. Plus simple et plus rapide que d'écrire une fonction avec def |
| def fonction(*parametres) | Définit une fonction qui admet un nombre variable de paramètres. La variable ''parametres'' est en réalité un tuple qui contient la ou les variables passées à la fonction. |
| def fonction(**parametres) | Définit une fonction qui admet un nombre variable de paramètres nommés. La variable ''parametres'' est en réalité un dictionnaire. |
| def fonction(*parNonNommes, **parNommes) | Définit une fonction qui admet n'importe quoi comme paramètres. parNonNommes est un tuple qui contient tous les paramètres non nommés et parNommes est un dictionnaire qui contient tous les paramètres nommés |
| fonction(*myList) | Fourniture d'une liste en tant que paramètres d'une fonction |
| fonction(**myDict) | Fourniture d'un dictionnaire en tant que paramètres d'une fonction |
| fonction(*myList, **myDict) | Fourniture d'une liste et d'un dictionnaire en tant que paramètres d'une fonction |
| global maVar | Déclare la variable *maVar* comme variable globale. Cette instruction est placée dans une fonction et maVar est définie en dehors de toute fonction. Par convention, l'instruction *global* est placée immédiatement après le docstring  |

## Classe str
Les méthodes suivantes s'appliquent sur les objets de la classe  `str` (chaines de caractères)

| Méthode | Description |
|---------|-------------|
| upper() | Mettre en majuscules |
| lower() | Mettre en minuscules |
| strip()  | Supprime les espaces inutiles en début et fin de chaine |
| "ma chaine {}".format(var) | Remplace les occurences de {} par les variables indiquées dans *format* |
| "ma chaine {0}".format(var) | Idem ci-dessus mais le numéro entre accolades précise l'ordre des variables. Les variables peuvent être placées dans n'importe quel ordre |
| "ma chaine {var1}".format(var1=valeurVar) | Idem ci-dessus mais on peut donner des noms explicites aux variables à insérer |
| chaine1 + chaine2 | Concaténation de 2 chaines |
| chaine[n] | Accède au n-ième élément de la chaine. Si n est négatif, on part de la fin de la chaine. **Important**: on ne pas modifier une lettre ainsi. chaine[i] = 'a' est interdit. |
| chaine[n:p] | Renvoie le morceau de *chaine* entre le n-ième et le (p-1)-ième élément. Noter que l'indice *p* est exclus. |
| chaine[n:]  | Renvoie l'extrait de la chaine du début jusqu'à l'élément n-1 |
| chaine[:n] | Renvoie l'extrait de la chaine de l'élément n à la fin |
| len(chaine) | Renvoie la longueur de la chaine |
| count | |
| find | |
| replace | |
| split(car) | Sépare une chaine en éléments délimités par '*car* |
| chaine.join(liste) | Crée une chaine contenant tous les éléments de liste séparés par *chaine*. Exemple: `" ".join(['Hello', 'World', '!'])` |



## Listes
Une liste peut contenir des éléments de types différents.

| Méthode | Description |
|---------|-------------|
| list() | Crée un liste |
| [] | Crée un liste |
| [a, b, ...] | Crée un liste |
| maListe[i] | Accède au i-ème élément. On peut le modifier. |
| append(a) | Ajoute a à la fin de la liste |
| insert(pos, elem) | Insert l'élément *elem* à la position *pos* |
| liste1.extend(liste2)  | Concaténation de listes |
| liste1 += liste2  | Concaténation de listes |
| liste.remove(i) | Supprime le i-ème élément de la liste |
| del(liste[i]) | Supprime le i-ème élément de la liste |
| [fonction(elem) for elem in sequence] | Parcourt chaque élément d'une liste et applique la fonction. Cette instruction ne modifie par la liste parcourue mais en crée une nouvelle. |
| [fonction(elem) for elem in sequence if condition] | Parcourt chaque élément d'une liste. Si la condition est vraie, la fonction est exécutée sur l'élément courant et le résultat est placé dans liste de retour. Si la condition est fausse, l'élément et ignoré. |
| liste2 = liste1  | Crée une nouvelle référence sur une liste. Liste2 est en faite une référence à liste1. Les 2 listes pointent sur la même liste |
| liste2 = list(liste1) | Crée une nouvelle liste à partir des valeurs de liste1. Les 2 listes référencent des listes distinctes |
| liste1 == liste2 | Compare les contenus des listes |
| liste1 is liste2 | Compare les références des listes |
| liste1.sort() | Trie la liste. Ceci implique que python sache comparer les 2 objets. Cela peut passer par une surcharge de l'opérateur < |
| liste1.sort(key) | Trie la liste selon la clé indiquée (le paramètre key est une fonction). La clé peut être définie par une fonction lambda. Ex `key=lambda x:x[n]` si les objets sont des tuples ou encore `key=lambda x:x.attr` pour trier selon un attribut particulier de l'objet x |
| liste1.sort(reverse=True/False) | Tri inversé de la liste |

### Trier des listes
Python permet des fonctions poussées permettant le tri de listes.

Se référer aux points suivants:
* sorted
* itemgetter
* attrgetter


## Dictionnaires
Un dictionnaire est comme une liste mais les différents éléments sont référencés à l'aide d'une clé (ie une variables qui sert d'indice plutôt qu'un entier dans le cas des listes)

| Méthode | Description |
|---------|-------------|
| dict() | Crée un dictionnaire |
| {} | Crée un dictionnaire |
| {"cle1":val1, "cle2":val2, ...} | Crée un dictionnaire |
| monDico["cle"] = valeur  | Crée ou remplace la valeur d'un élément |
| monDico.pop("cle") | Retire l'élément correspondant à la clé et renvoie la valeur associée |
| monDico.keys() | Renvoie la liste des clés du dictionnaire (en réalité, ce n'est pas vraiment une liste mais se parcourt de la même manière |
| monDico.values() | Renvoie la liste des valeurs du dictionnaire (en réalité, ce n'est pas vraiment une liste mais se parcourt de la même manière |
| (cle, valeur) in monDico.items() | Récupère un tuple issu du dictionnaire. Utile surtout pour parcourir simultanément clé et valeur |

## Tuples
> TODO


## Regex
* import re
* Pour les regex, il faut échapper le backslash pour les caractère spéciaux (\n, \t, etc.). `\n` devient donc `\\n`. Pour simplifier l'écriture, on fait précéder la chaine de la lettre 'r' (pour *raw*). Ainsi "\n" devient r"\n"

| Fonction | Description |
|----------|-------------|
| re.search(regex, chaine) | Cherche la regex dans chaine. Renvoi un objet si trouvé, None sinon |
| re.sub(regex, repl, chaine) | Remplace tous les patterns qui matchent la regex par *repl*. **Note:** Si on utilise des groupes de capture (avec les parenthèses), ils sont référés en tant que \n (avec n le numéro de groupe). **Note:** On peut nommer les groupes de capture: (`?P<id>groupe`) dans la regex. `\g<id>` dans la chaine de remplacement |
| re.compile(regex) | Compile une regex pour améliorer le temps d'exécution |
| regexCompilee.search(chaine) | Utilisation d'une regex compilée pour chercher la regex dans la chaine |
| regexCompilee.sub(repl, chaine) | Utilisation d'une regex compilée pour remplacer des patterns de regex dans la chaine |

## Time
* import time
* import datetime

| Fonction | Description |
|----------|-------------|
| time.time() | Retourne le timestamp courant |
| time.localtime([timestamp]) | Convertit un timestamp en *struct_time*, unobjet contenant l'année (tm_year), le mois (tm_mon), le jour du mois (tm_mday), le jour de la semaine (tm_wday), le jour de l'année (tm_yday), l'heure (tm_hour), les minutes (tm_min) et les secondes (tm_sec). Si aucun timestamp n'est précisé, la date et l'heure courante sont utilisées |
| time.mktime(struct_time) | Convertit un struct_time en timestamp |
| sleep(x) | Met le programme en pause pendant x secondes |
| time.strftime(format, struct_time) | Convertit une structure de temps en chaine de caractère formatée selon les indications données dans la chaine *format*. %Y année, %B nom du mois, %d jour du mois, %H heure, %M minutes, %S secondes, etc.) |
| datetime.date(annee, mois, jour) | Crée un objet date |
| datetime.time(heure, minutes, secondes, microsecondes, timeZoneInfo) | Crée un objet time |
| datetime.datetime(A, M, J, H, m, S, ms) | Crée un objet datetime |
| datetime.now() | Crée un objet datetime à l'horodate courante |
| datetime.fromtimestamp(timestamp) | Crée un objet datetime à partir d'un timestamp |

# Fichiers

| Fonction | Description |
|----------|-------------|
| monFichier = open("fichier.txt", 'r') | Ouvre un fichier en lecture. Il existe également les mode w, a, rb, wb et ab |
| monFichier.close() | Ferme le fichier |
| monFichier.read() | Lit l'intégralité du fichier |
| monFichier.write("texte a ecrire") | Ecrit dans le fichier |
| with open("fichier.txt", 'r') as monFichier: | Définit un gestionnaire de contexte. L'instruction *open* est exécutée et l'objet retourné est référencé en tant que variable *monFichier*. Après cette ligne de code, on écrit un *bloc* d'instructions. A la fin du bloc, monFichier est automatiquement fermé (que le bloc se soit terminé normalement ou suite à une exception) |
| pickle.Pickler | Permet de sauvegarder un objet dans un fichier. Requiert la classe *Pickler** du module 'pickle'. Le fichier doit être ouvert en mode binaire. Cet objet enregistre sur le disque le dictionnaire des attributs de l'objet à sauvegarder. Ce dictionnaire peut être obtenu avec la méthode spéciale `__dict__` de l'objet |
| pickle.Unpickler | Permet de restaurer un objet depuis un fichier. Requiert la classe *Unpickler* du module 'pickle'. Le fichier doit être ouvert en mode binaire. |

# Modules & packages
## Modules 
Un fichier python avec des fonctions est un module.
* Créer un fichier .py
* Pour linux: 1ère ligne: `#! /usr/bin/python3` : Sert à indiquer le chemin vers l'exécutable pour interpréter le script. Utile si on veut exécuter directement le fichier.
* 2ème ligne: `#-*- coding: utf-8 -*-` (ou Latin-1): Sert à indiquer l'encodage du fichier
* Ecrire ensuite la liste des fonctions implémentées par ce module
* Test du module: Rajouter une directive `if __name__ == "__main__":` et écrire ensuite le code nécessaire au test (ou autre)
  * Ce code n'est pas exécuté lorsqu'on importe le module (la condition n'est pas vérifiée)
  * Code code est exécuté lorsqu'on exécute directement le fichier
* Pour importer le module:
  * `from nomModule import *` : importe toutes les fonctions du module. Les fonctions s'appellent directement en utilisant le nom de la fonction.
  * `from nomModule import fonction` : importe une seule fonction du module
  * `import nomModule` : importe le module mais les fonctions devront être appelées nomModule.fonction (revient un peu à importer un package)

## Packages
Un package est un répertoire dans lequel on peut ranger des modules (des fichiers) ou d'autres packages (des sous-répertoires)
1. Créer un répertoire portant le nom du package
2. Placer dans ce répertoire tous les fichiers (modules) composant le package. Éventuellement créer des sous-répertoires pour faire des sous-packages.
3. Créer le fichier d'initialisation du package: fichier `__init__.py`


Pour importer le module:
* `from nomPackage.nomModule import *` : importe toutes les fonctions du module du package. Les fonctions s'appellent directement en utilisant le nom de la fonction.
* `from nomPackage.nomModule import fonction`: importe une seule fonction
* `import nomPackage.nomModule`: importe le module mais les fonctions devront être appelées *nomPacakge.nomModule.fonction*


# Orienté Objet
```python
class NomClasse:     # Création d'une classe
  """Ceci est le docstring de la classe.
  Il s'agit de la documentation embarquée dans le code"""

  attribut = valeur     # Attribut de classe: attribut commun à tous les objets (equivalent aux attributs statiques en C++)

  def __init__(self, par1, ...):    # Constructeur
    self.attribut1 = par1
    ...

  def __del__(self):     # Destructeur
    code

  def methode1(self, param1, ...):
    code de la méthode

  def methodeDeClasse(cls, params):
    code
  methodeDeClasse = classmethod(methodeDeClasse)

  def methodeStatique(params):
    code
  methodeStatique = staticmethod(methodeStatique)
```

* le mot clé *class* permet de début la déclaration d'une classe
* les attributs déclarés en dehors des méthodes sont des attributs de classe (dépendant de la classe et non de l'objet)
  * Ces attributs s'accèdent avec NomClasse.attribut
* le constructeur est nommé `__init__`
* le destructeur est nommé `__del__`
* le 1er paramètre de toutes les méthodes (constructeur compris) est le paramètre **self**
** Les méthodes sont attachées à la classe et non à l'objet. Lorsqu'on appelle la méthode, il est donc utile de lui passer l'objet sur lequel est appelé la méthode.
* En python, on peut accéder directement aux attributs. Pas besoin de getter/setter
* Les méthodes de classe
  * 1er paramètre: **cls**. C'est en quelques sorte un pointeur sur la classe
  * travaille sur les attributs de classe avec **cls.attr**
  * requiert l'instruction **classmethod**
  * sont appelées avec **NomClasse.methode** ou peuvent être appelées sur un objet de la classe
* Méthode statique
  * paramètres ne contenant ni self, ni cls
  * requiert l'instruction **staticmethod**
  * Ne travaille ni sur les attributs d'un objet, ni sur les attributs de classe

## Héritage
```python
class ClasseFille(ClasseMere1, ClasseMere2):
```

* Le constructeur de la classe mère doit être appelé explicitement. Sinon, il n'est pas appelé et tous les attributs présents dans le constructeur de la classe mère mais pas celui de la classe fille ne seront pas créés
* `issubclass(ClasseFille, ClasseMere)`: Renvoie true si ClasseFille hérite de ClasseMere
* `isinstance`(monObjet, MaClasse): Renvoie true si monObjet est un instance de MaClasse (ou d'une classe dérivée)

## Propriétés
Les propriétés permettent de faire de l'encapsulation avec python.

```python
class NomClasse:
  def __init__(self):
    _attribut = ''valeur''

  def _getAttribut():
    return _attribut

  def _setAttribut(val):
    _attribut = val

  attribut = property(_getAttribut, _setAttribut)
```

* Par convention, les attributs et méthodes qui commencent par un underscore (_) ne doivent pas être accédées de l'extérieur
* On définit un attribut (que l'on veut privé) qui commence par _
* On définit un getter et un setter pour cet attribut. Tous 2 commencent par un _
* On définit une propriété qui s'appelle comme l'attribut mais sans le _.
* On rattache le getter et le setter à la propriété avec le mot clé **property**
* **property** accepte jusqu'à 4 paramètres facultatifs:
  * la méthode appelée lorsqu'on veut accéder à l'attribut
  * la méthode appelée lorsqu'on veut modifier l'attribut
  * la méthode appelée lorsqu'on veut supprimer l'attribut
  * la méthode lorsqu'on demande l'aide associée à l'attribut

## Méthodes spéciales

| Méthode | Description |
|---------|-------------|
| `__repr__(self)` | Méthode appelée lorsqu'on demande à afficher l'objet depuis l'éditeur. Elle est également appelée si on appelle la commande print sur l'objet et que la méthode `__str__` n'est pas définie. return type: str |
| `__str__(self)` | Méthode appelée lorsqu'on exécuter la commande print sur l'objet ou lorsqu'on veut convertir l'objet en string. return type: str |
| `__getattr__(self, nomAttr)` | Méthode appelée si on tente d'accéder à un attribut inexistant. return type: ce qu'on veut comme valeur retour d'un paramètre inexistant |
| `__setattr__(self, nomAttr, valeur)` | Méthode appelée lorsqu'on modifie un attribut. Cette méthode se substitue à la méthode par défaut (héritée de la classe *object*. Pour réellement modifier le valeur de lattribut, il faut explicitement appeler la méthode de la classe mère `object.__setattr__(self, nomAttr, valeur)` |
| `__delattr__(self, nomAttr)` | Méthode appelée lorsqu'on supprimer un attribut. Pour réellement supprimer l'attribut, appeler la méthode de la classe mère `object.__delattr__(self, nomAttr)` |
| `__getitem__(self, index)` | Méthode appelée lorsqu'on veut accéder à un élément d'un conteneur. Par exemple lorsqu'on fait `monObjet[index]` |
| `__setitem__(self, index, valeur)` | Méthode appelée lorsqu'on veut modifier un élément d'un conteneur. Par exemple lorsqu'on fait `monObjet[index] = valeur` |
| `__delitem__(self, index)` | Méthode appelée lorsqu'on veut supprimer un élément d'un conteneur. Par exemple lorsqu'on fait `del monObjet[index` |
| `__contains__(self, valeur)` | Méthode appelée lorsqu'on écrit `valeur in monObjet`. return type: True/False |
| `__len__(self)` | Méthode appelée lorsqu'on écrit `len(monObjet)`. return type: int |
| `__add__(self, valeur)` | Surcharge de l'opérateur +. Cette méthode est appelée lorsqu'on écrit `monObjet + valeur`. **Note:** Charge à cette méthode de gérer les différents types pour *valeur*
| `__sub__` | Surcharge de l'opérateur - |
| `__mul__` | Surcharge de l'opérateur * |
| `__truediv__` | Surcharge de l'opérateur / |
| `__floordiv__` | Surcharge de l'opérateur // |
| `__mod__` | Surcharge de l'opérateur % |
| `__pow__` | Surcharge de l'opérateur ** (puissance) |
| `__radd__` | Lorsqu'on écrit `valeur + monObjet`, cela suppose que la classe de *valeur* sache comment additionner *monObjet*, ce qui n'est pas le cas si valeur est d'un type standard. Dans ce cas, pyhton tente d'appeler la méthode `__radd__` (qui revient à `monObjet + valeur`). en général: return monObjet + valeur. Permet notamment d'appeler l'opération `sum` sur une collection d'objets. Dans ce cas, le premier appel correspond à `0 + premierObjetDeLaListe`. **Note:** s'applique pour toutes les méthodes mathématiques ci-dessus |
| `__iadd__` | Surcharge de l'opérateur +=. **Note:** valable pour tous les opérateurs (-=, *=, etc.). Il suffit de rajouter un ***i*** |
| `__eq__(self, objetAComparer)` | Surcharge de l'opérateur ==. return type: True/False |
| `__ne__(self, objetAComparer)` | Surcharge de l'opérateur != . return type: True/False |
| `__gt__(self, objetAComparer)` | Surcharge de l'opérateur >. return type: True/False. **Note:** Si python n'arrive pas a exécuter objet1 < objet2, il va automatiquement tenter d'exécuter l'opération inverse: objet2 >= objet1 |
| `__ge__(self, objetAComparer)` | Surcharge de l'opérateur >=/. return type: True/False |
| `__lt__(self, objetAComparer)` | Surcharge de l'opérateur <. return type: True/False |
| `__le__(self, objetAComparer)` | Surcharge de l'opérateur <=. return type: True/False  |
| `__getstate__(self)` | Cette méthode est appelée juste avant l'enregistrement de l'objet à l'aide de la classe Pickle. Cette méthode sert à récupérer le dictionnaire des attributs de l'objet. Il faut donc obtenir le dictionnaire de l'objet avec `dict(self, __dict__)`, éventuellement modifier ce dictionnaire et enfin de renvoyer en tant que donnée retour de la méthode. |
| `__setstate__(self, dictAttr)` | Cette méthode est appelée juste après le chargement d'un objet à l'aide de la classe Unpickle. Cette méthode doit se charger de mettre à jour le dictionnaire des attributs de l'objet: `self.__dict__ = dictAttr` |

# Itérateurs
Lorsqu'on exécuter le code `for elem in sequence`, python effectue les actions suivantes:
* Il appelle la fonction **iter(sequence)** qui va elle-même appeler la méthode `sequence.__iter__()`
  * Cette méthode renvoie un itérateur sur la séquence.
* Il appelle successivement la fonction `next(iterateur)`, ce qui revient à appeler la méthode `iterateur.__next__`.
  * Cette méthode passe à l'élément suivant et renvoie sa valeur
  * Lorsque la fin de la séquence est atteinte, cette méthode lève une exception *StopIteration*


> ⚠️ **Important:** Si la méthode `__iter__` contient une instruction `yield`, ce sont les générateurs qui sont utilisés au lieu de l'itérateur (cf. ci-dessous)

Si on veut créer une classe qui peut être parcourue avec l'instruction for, il faut:
* définir la méthode spéciale `__iter__`. Cette méthode devra créer et retourner un itérateur sur la classe
* Créer une classe itérateur capable d'itérer sur la classe à parcourir
  * Cette classe implémente à minima la méthode `__next__`
    * cette méthode renvoie l'élément suivant à chaque appel
    * cette méthode lève une exception StopIteration lorsque la fin de la séquence est atteinte


## Générateur
Avec le mot clé `yield`, la fonction est suspendue et renvoie la valeur spécifiée après l'instruction yield. La fonction poursuit son exécution au prochain appel de next. Lorsque la fonction arrive à la fin, l'exception StopIteration est automatiquement levée

> ✏️ **Note:** Si la méthode `__iter__` contient un instruction *yield*, c'est cette méthode qui est appelée pour chaque élément de la séquence. On peut alors se passer de définir une classe Itérateur.



**Note:** On peut interagir avec le générateur:
* On peut stopper la boucle du générateur avec la méthode `close()`
* On peut passer une valeur au générateur avec la méthode `send()`

# Interactions avec l'OS
* Signaux: le programme python est capable d'émettre ou de réceptionner des signaux et d'y associer un traitement spécifique
  * le signal SIGINT est émis lorsqu'on demande au programme de se terminer
* Récupérer les arguments de la ligne de commande
  * sys.argv fournit la liste des arguments de la ligne de commande (le 1er élément est le nom du programme)
  * le module `argparse` est utile pour extraire les options d'exécution (ex: -h ou --help)
* Exécuter une commande système
  * `os.system("commande")`

# Réseau
* import socket

## Côté serveur

| Instruction | Description |
|-------------|------------|
| maConnexion = socket.socket(socket.AF_INET, socket.SOCK_STREAM) | Création d'une socket |
| maConnexion.bind((hote, port)) | Affecte la connexion à l'interface réseau (nom d'hôte et numéro de port). Mettre hote = '' |
| maConnexion.listen(backlog) | Placer la connexion en mode d'écoute. Backlog est un chiffre qui indique combien de client peuvent être simultanément en attente de connexion (généralement réglé à 5) |
| (connexion, infos) = maConnexion.accept() | Accepte une demande de connexion d'un client. Retourne 2 infos: la connexion qui est un socket connecté au client et un tuple contenant les infos de connexion (adresse IP, port de sortie). **Note:** cette méthode est bloquante si aucun client n'a fait de demande de connexion |
| maConnexion.send(b'Message à envoyer') | Envoie le message indiqué. **important:** Le message est en octets et non une string, d'où le **b** devant la chaine |
| msg = maConnexion.recv(tailleBuffer) | Réceptionne un message. Le message reçu est limité à la taille indiquée. |
| connexion.close() | Ferme la connexion |

## Côté client

| Instruction | Description |
|-------------|------------|
| maConnexion = socket.socket(socket.AF_INET, socket.SOCK_STREAM) | Création d'une socket |
| maConnexion.connect((adresseIp, port)) | Connexion au serveur ayant l'adresse Ip indiquée au port précisé |
| maConnexion.send(b'Message à envoyer') | Envoie le message indiqué. **important**: Le message est en octets et non une string, d'où le **b** devant la chaine |
| msg = maConnexion.recv(tailleBuffer)  | Réceptionne un message. Le message reçu est limité à la taille indiquée. |
| connexion.close()  | Ferme la connexion |

## Autres
Les méthodes accept et recv sont bloquantes. Pour éviter de bloquer le programme et permettre la gestion de plusieurs clients simultanément, on peut utiliser le module **select**
* import select
* rlist, wlist, wlist = select.select(rlist, wlist, xlist, timeout)
  * les arguments fournis à la fonction sont respectivement la liste des sockets en attente de réception, la liste des sockets en attente d'écriture et la liste des sockets en attente d'erreur.
  * La fonction parcourt chaque socket des 3 listes et regarde si l'un d'eux a des données à traiter
  * La fonction retourne au plus tard après écoulement du timeout et le programme peut se poursuivre
  * Les 3 listes en retour sont respectivement la liste des socket ayant reçu des données, la liste des sockets ayant émis des données et la liste des sockets ayant traité des erreurs. Ces 3 listes n'ont rien à voir avec les 3 listes passées en argument
* On peut ensuite parcourir chaque socket des listes de retour et traiter les données

# Threads
* from threading import Thread, RLock
* Créer une classe qui hérite Thread
* Dans le constructeur ne pas oublier d'appeler le constructeur de la classe mère: `Thread.__init__(self)`
* Redéfinir la méthode `run`
* Démarrer le Thread avec la méthode `start`
* Attendre l'arrêt d'un Thread avec la méthode `join`


Verrouiller une ressource avec RLock:
```python
verrou = RLock()
...
with verrou:
  utilisation d'une ressource protégée
```

# Tests unitaires
* Placer les TU d'une classe dans un module dédié qui doit impérativement s'appeler **test\***
* Importer le module `unittest`
* Créer une classe qui hérite de `unittest.TestCase`
* Créer une méthode par test. La méthode doit impérativement commencer par le mot test
* La méthode `setUp(self)` est appelée avant chaque test
* La méthode `tearDown(self)` est appelée après chaque test
* Les méthodes de test contiennent des assertions pour vérifier l'objet des tests

```python
import unittest

class MaClasseTest(unittest.TestCase):
  def setUp(self):
    # initialisation
  def test_cas1(self):
    assert(...)
  def test_cas2(self):
    assert(...)
  def tearDown(self):
    # remise en état
```

Les TU peuvent être appelés:
* `unittest.main()` dans le module de test
* commande `python -m inittest` dans le dossier du module

| Assertions de test |
|--------------------|
| assertEqual(a, b) |
| assertNotEqual(a, b) |
| assertTrue(a) |
| assertFalse(a) |
| assertIs(a, b) |
| assertIsNot(a, b) |
| assertIsNone(a) |
| assertIsNotNone(a) |
| assertIn(a, b) |
| assertNotIn(a, b) |
| assertIsInstance(a, b) |
| assertIsNotInstance(a, b) |
| assertRaises(exception, fonction, arguments) |

La dernière assertion vérifie que l'appel de la fonction lève l'exception attendue
