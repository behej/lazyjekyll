---
title: Langage C++
layout: default
icon: cpp.svg
---
# Les Types
* `bool`: *true* ou *false*
* `char`: caractère (1 octet)
* `int`: entier
* `double`: nombre à virgule
* `string`: chaîne de caractères. Nécessite la directire #include <string>

## Déclaration et initialisation d'une variable
```cpp
type nomVariable (valeurInit);
type nomVariable = valeurInit;
```

Déclaration d'une constante:
```cpp
type const nomConstante = valeurInit;
const type nomConstante = valeurInit;
```

## Références
Une référence consiste à définir un nom supplémentaire qui désigne une variable déjà existante.
```cpp
int variable1(12);
int& variable2(variable1);
```

La *variable2* référence la *variable1*. Accéder à *variable2* revient strictement au même qu'accéder à *variable1*.
* la déclaration d'un référence se fait pas l'ajout du symbole `&` après le type.
* la référence doit avoir le même type que la variable référencée.

## Pointeurs
* `&var`: adresse de la variable
* `type* ptr_var`: pointeur sur une variable de type *type*
* `*ptr`: valeur de la variable pointée

```cpp
ptr = new type;     // Allocation de mémoire
delete ptr;         // Libération de la mémoire. Il est d'usage d'affecter 0 au pointeur après l'instruction 'delete' pour bien indiquer que le pointeur ne pointe plus sur rien.
```

On peut également définir un pointeur sur un objet
```cpp
ptr = new NomClasse();     // Constructeur par défaut
ptr = new NomClasse(attributs);     // Constructeur surchargé
```

On accède ensuite aux attributs et aux méthodes avec l'opérateur flèche
```cpp
ptr->attribut1;
ptr->methode(arguments);
```

A l'intérieur d'un objet, on accès à l'objet lui-même avec le pointeur `this`

# Fonctions
## Passage d'arguments
### Passage par valeur
```cpp
void fonction(type var)
```
Utilisation classique identique au C

### Passage par référence
```cpp
void fonction(type& var)
```

La variable crée à l'intérieur de la fonction est une référence à la variable de l'appel de la fonction. Toute modification effectuée à l'intérieur de la fonction porte sur la variable passée en paramètre.

### Passage par référence constante
```cpp
void fonction(type const& var)
```

Idem passage par référence mais la variable n'est pas modifiable à l'intérieur de la fonction. Intérêt: évite la duplication de la mémoire et donc gain de temps d'exécution.

## Arguments facultatifs
Pour rendre un paramètre facultatif, il faut lui définir une valeur par défaut dans le prototype.
```cpp
void fonction(type1 param1, type2 param2 = val);
```

Lors de l'appel, on pourra alors omettre le 2ème paramètre.
```cpp
fonction(val1);
```
* la définition des valeurs par défaut se fait uniquement dans le prototype. Et non dans la définition de la fonction.
* les paramètres obligatoires à gauche, les paramètres facultatifs à droite.
* on ne peut pas omettre un premier paramètre facultatif puis renseigner le suivant. La lecture des paramètres se fait de gauche à droite.
* on peut déclarer tous les paramètres comme facultatifs.

## Retour par référence
Une fonction peut retourner une référence
```cpp
type& fonction(arguments)
```

* La fonction peut être membre gauche d'une affectation
```cpp
fonction() = valeur;
```

## Fonctions lambda
* Une lambda est une fonction anonyme. Utile pour mettre un peu de code (dans une boucle, un itérateur, une callback) sans avoir besoin de créer une fonction dédiée accessible par tous.
* Syntaxe de base: le code renvoie un pointeur sur une fonction pour être utilisé.
  * `[]` capture
  * `()` paramètres
  * `{}` code

```cpp
[](){ ... }
```

* Syntaxe avec valeur de retour

```cpp
[]() -> T { ... }   // T: type de la valeur de retour
```

* La partie code est du code C++ classique
* Les paramètres, sont des paramètres d'appel de la fonction lambda

```cpp
auto square = [](int a){ return a*a; };
```

* La zone de capture permet de définir comment la lambda *capture* les éléments externes
  * Une lambda a accès à tous les objets accessibles dans la portée où la lambda est déclarée
  * Ces éléments peuvent être accédés soit par copie (symbole =)
  * soit par référence (symbole &)

```cpp
// La lambda accède à toutes les variables par copie
[=](){ ... }:
// La lambda accès à toutes les var par référence
[&](){ ... };
// La lambda spécifie explicitement comment accéder aux variables
[foo, &bar](){ ... };   // foo par copie et bar par référence
// La lambda spécifie un mode général et des exceptions
[=,&foo](){ ... };     // accès par copie, sauf pour foo par ref
[&,bar](){ ... };      // accès par ref, sauf pour bar par copie
```

# Tableaux
## Tableaux statiques
Identique au langage C
```cpp
int tableau[taille];
```

## Tableaux dynamiques
### Déclaration
Nécessite l'utilisation de la library `<vector>`
```cpp
#include <vector>

vector<''type''> nomTableau(taille);     // Déclaration du tableau mais non initialisé
vector<''type''> nomTableau(taille, valInit);     // Toutes les cellules du tableau sont initialisées à ''valInit''
```

### Gestion de la taille
* Ajouter une valeur: `nomTableau.push_back(valeur);`
* Supprimer une valeur: `nomTableau.pop_back();`
* Récupérer la taille: `nomTableau.size();`

### Tableaux dynamiques & fonctions
```cpp
void fonction(vector<type> nomParam);
```

* peut s'utiliser avec le passage par référence
* peut s'utiliser avec le passage par référence constante

## Tableaux multidimensionnels
**Statique:**
```cpp
type nomTableau[dim1][dim2]...;
```

**Dynamique:**
```cpp
vector< vector<int> > nomTableau;
```

# IO Stream
## Affichage
```cpp
#include <iostream>

cout << "Mon texte";
cout << "Mon texte suivi d'un retour à la ligne" << endl;
cout << maVariable;
cout << "la variable vaut: " << maVariable << endl;
```

## Saisie
```cpp
#include <iostream>

cin >> maVariable;
```

Cette fonction récupère la saisie utilisateur mais s'arrête dès qu'elle rencontre un retour à la ligne ou un espace. Embêtant pour les strings.

```cpp
#include <iostream>

getline(cin , maVariable);
```

* Si utilisation simultanée de `cin >>` et de `getline` (cin puis getline), il faut impérativement utiliser `cin.ignore();` après les chevrons.

```cpp
cin >> variable1;
cin.ignore();
...
getline(cin, variable2);
```

# Libraries
## Fonctions mathématiques
```cpp
#include <cmath>
```


|Fonction|Description|
|---|---|
| sqrt(x) | racine carée |
| sin(x) | sinus (en radians) |
| cos(x) | cosinus |
| tan(x) | tangente |
| exp(x) | exponentielle |
| log(x) | logarithme népérien |
| log10(x) | logarithme décimal |
| fabs(x) | valeur absolue |
| floor(x) | arrondi vers le bas |
| ceil(x) | arrondi vers le haut |
| pow(a,b) | a *puissance* b |

```cpp
#include <cstdlib>
```

```cpp
#include <ctime>
```

|Fonction|Description|
|---|---|
| srand(time(0)) | Nécessaire pour initialiser le générateur aléatoire |
| rand() | Génération d'un nombre aléatoire |
| rand() % x | Génération d'un nombre aléatoire entre 0 et x-1 |

## Strings
```cpp
#include <string>
```
Une string se comporte comme un tableau dynamique.
```cpp
nomString.push_back(lettre);
nomString.erase(position, nbre);     // efface 'nbre' caractères à partir de la 'position'
nomString.size();
```

Pour concaténer 2 chaines:
```cpp
chaine1 += chaine2;
```

|Instruction|Description|
|---|---|
| `string obj;` | Déclaration d'un objet *obj* appartenant à la classe *string* |
| `string obj("chaine");` | Déclaration et initialisation d'un objet de type *string* |
|`string obj = "chaine";` | Déclaration et initialisation d'un objet de type *string* |
| `obj.size()` | Renvoie la taille de la chaine |
| `obj.erase()` | Efface entièrement la chaine |
| `obj.substr(debut [, longueur]);` | Renvoie un extrait de la chaine: *longueur* caractères à partir de *debut*. Si *longueur* est omis, renvoie tous les caractères jusqu'à la fin de la chaine.
| `obj.c_str()` | Renvoie un pointeur sur le tableau qui contient la chaine de caractères. Utilisé avec les *ofstream* et *ifstream* |

## Fichiers
```cpp
#include <fstream>
```

|Instruction|Description|
|---|---|
| `ofstream nomFlux("fichier");` | Crée et ouvre le fichier en écriture. Le crée si inexistant. *fichier* peut être un chemin absolu ou relatif |
| `ofstream nomFlux("fichier", ios::app);` | Ouvre le fichier et écrit à la suite de ce qui existe déjà |
| `ofstream nomFlux(stringNomFichier.c_str());` | Si utilisation d'une variable pour stocker le nom du fichier, il faut utiliser la méthode *c_str()* |
| `ifstream nomFlux("fichier");` | Ouvre le fichier en lecture. |
| `if (nomFlux)` | renvoie TRUE si l'ouverture du fichier s'est bien passée. |
| `nomFlux.open("fichier");` | ouvre explicitement le fichier si cela n'a pas été fait lors de la déclaration de la variable |
| `nomFlux << "chaine de caractères" << variable;` | écriture d'une chaine de caractères ou d'une variable dans le fichier |
| `getline(nomFlux, nomString);` | Lit une ligne entière du fichier pointé par le flux et la stocke dans la string ''nomString''. Renvoie TRUE si effectué avec succès. Renvoie FALSE si erreur ou si fin de fichier. |
| `nomFlux >> nomVar;` | Lit un mot et le stocke dans la variable. Un cast est effectué selon le type de la variable de destination |
| `nomFlux.get(caractere);` | Lit le fichier caractère par caractère. |
| `nomFlux.close();` | Ferme explicitement de le fichier. Note: le fichier est automatiquement fermer lors de la destruction de la variable flux. |
| `nomFlux.tellp();` | retourne la position actuelle du curseur. Valable uniquement pour les ofstream |
| `nomFlux.tellg();` | retourne la position actuelle du curseur. Valable uniquement pour les ifstream |
| `nomFlux.seekp(nbCar, posRef);` | Déplace le curseur *nbCar* par rapport à *posRef*. Valable uniquement pour les ofstream. *posRef* peut valoir: `ios::beg`=début du fichier / `ios::end`=fin du fichier / `ios::cur`=position courante |
| `nomFlux.seekg(nbCar, posRef);` | Déplace le curseur *nbCar* par rapport à *posRef*. Valable uniquement pour les ifstream. |
| taille du fichier | Il faut se placer à la fin du fichier en utilisant *seek* puis on récupère la position du curseur avec *tell*. |
