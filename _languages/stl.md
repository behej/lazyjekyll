---
title: STL
layout: default
icon: cpp.svg
---

Plus d'exemples et mises en application sur [Github](https://github.com/behej/modernCpp/blob/main/containers.cpp)


# Liste des principaux headers

| Lib | Fonctionnalités |
|--|--|
| cmath | Fonctions mathématiques |
| cctype | Types de caractères (isdigit, isalpha, tolower, toupper, etc.) |
| ctime | Manipulation du temps |
| cstdlib | Library standard. Mieux vaut utiliser d'autres libs plus efficaces. Ne sert plus que pour la fonction rand() |
| cassert |  |

# STL
## Conteneurs
### Les différents conteneurs
#### Séquences

|Conteneur |Description |
|--|--|
| vector | Eléments stockés de manière contigüe. Eléments indexés par des entiers Insertion/suppression au milieu coûteuse
| deque (Double Ended QUEue) | Eléments stockés de manière contigüe. Eléments indexés par des entiers. Insertion/suppression au milieu coûteuse. Accès direct à la fin de la liste |
| list | Liste chaînée. Ne se parcourt qu'avec des itérateurs. Optimisée pour des ajout/suppression au milieu |
| stack | Accès uniquement au dessus de la pile |
| queue | Accès uniquement au premier élément de la file |
| priority_queue | Permet de classer les élément d'une file par ordre d'importance. Suppose que l'opérateur < soit définit |

#### Conteneurs associatifs

|Conteneur |Description |
|--|--|
| set & multiset | Eléments triés. Ne se parcourt qu'avec des itérateurs |
| map & multimap | Table associative: les éléments sont référencés par une clé (qui peut être de n'importe quel type). Ne se parcourt qu'avec des itérateurs. Eléments triés par les clés (ceci implique une définition d'un critère de tri des clés) |

### Fonctions communes

|Méthode|Description |
|--|--|
| size() | Renvoie le nombre d'éléments contenurs |
| empty() | Renvoie TRUE si le conteneur est vide |
| clear() | Vide le conteneur |
| swap(*cont*) | Echange le contenu avec le conteneur *cont* |
| push_back(e) | Ajoute l'élément e à la suite de la séquence | Uniquement pour les séquences |
| pop_back() | Supprime le dernier élément de la séquence | Uniquement pour les séquences |
| front() | Renvoie le premier élément de la séquence | Uniquement pour les séquences |
| back() | Renvoie le dernier élément de la séquence | Uniquement pour les séquences |
| assign(e) | Renseigne tous les éléments de la séquence avec les valeur e | Uniquement pour les séquences |


### Deque

|Méthode|Description |
|--|--|
| push_back(e) | Ajoute l'élément e à la fin de la séquence |
| pop_back() | Supprime le dernier élément de la séquence |
| push_front(e) | Ajoute l'élément e au début de la séquence |
| pop_front() | Supprime le premier élément de la séquence |


### Stack
Seules ces 3 méthodes sont autorisées

|Méthode|Description |
|--|--|
| push(e) | Ajoute l'élément e sur la pile |
| pop() | Supprime l'élément du dessus de la pile |
| top() | Renvoie l'élément sur la pile |


### Queue
Seules ces 3 méthodes sont autorisées

|Méthode|Description |
|--|--|
| push(e) | Ajoute l'élément e à la file |
| pop() | Supprime le 1er élément de la file |
| front() | Renvoie le 1er élément de la file |


### Priority_queue
* Idem que la séquence **`queue`**
* La méthode **`top`** renvoie la plus grande valeur de la file au lieu de la première
* Ceci implique que l'opérateur **`<`** soit surchargé afin de permettre la comparaison de 2 éléments


### List
> **`TODO`**

### Map
* Une map est une table associative. L'index des éléments peuvent être de n'importe quel type
* La déclaration est: **`map<typeCle, typeValeur> nomTable;`**
  * Dans ce cas, le type utilisé pour la clé doit impérativement contenir une définition de l'opérateur **`<`**
* Autre déclaration: **`map<typeCle, typeValeur, classePourTri> nomTable;`**
  * avec `classePourTri` une classe qui définit un foncteur prenant 2 arguments de type `typeCle` et retournant un bool. Ce foncteur sert à définir une nouvelle méthodologie de classement des objets de type `typeCle`
* On accède à une élément avec les crochets []: **`nomTable[ValeurCle]`**
  * Si l'élément accédé n'existe pas, il est créé (même en cas de lecture de l'élément)
* Un élément du conteneur est en réalité une paire `clé/valeur`. La clé est stockée dans l'attribut `first` et la valeur dans l'attribut `second`. Ces deux attributs sont notamment utiles avec les itérateurs.
* Possède une méthode **`find(Cle);`** qui renvoie un itérateur sur l'élément cherché. Renvoie un itérateur sur `table.end()` sur l'élément n'est pas trouvé.


## Itérateurs
Un itérateur est une sorte de pointeur permettant de parcourir les conteneurs et de manipuler ses éléments.


|Instruction|Description|
|--|--|
| `nomConteneur\<type\>::iterator nomIterateur;` | Déclaration d'un itérateur sur un conteneur particulier |
| `nomIterateur.begin()` | Retourne le 1er élément du conteneur |
| `nomIterateur.end()` | Retourne la fin du conteneur. **Attention:** cette méthode pointe sur la fin du conteneur et non sur le dernier élément. |
| `nomIterateur++` | Déplace l'itérateur sur le prochain élément |
| `nomIterateur--` | Déplace l'itérateur sur l'élément précédent |
| `nomIterateur + n` | Fait référence au *n*-ième élément après l'itérateur. **Attention:** Ne fonctionne qu'avec les `vector` et les `deque`
| `*nomIterateur` | Accède à l'élément pointé par l'itérateur |
| `nomConteneur.insert(iterateur, element)` | Insère `element` dans le conteneur juste avant la position repérée par l'itérateur |
| `nomConteneur.erase(iterateur)` | Supprime l'élément repéré par l'itérateur de la séquence |


## Foncteurs
* Un foncteur est une classe dédiée à la réalisation d'une fonction précise
* Cette classe comporte une surchage de l'opérateur **`()`**
* Puis on l'appelle en utilisant l'opérateur **`()`** directement sur un objet de la classe

```cpp
class nomClasse {
public:
    type operator()(paramètres) {
        code
    }
};

nomClasse nomObjet;
 
nomObjet(paramètres);
```


## Prédicats
* Les prédicats sont des foncteurs particuliers qui renvoient nécessairement un `bool`
* Il servent à tester une assertion (ex: estPair, estPlusPetit, contientUneVoyelle, etc.)


## Algorithmes
* Les algorithmes sont un ensemble de fonctions existantes dans la STL permettant d'agir (chercher, compter, trier, etc sur des conteneurs
* il est nécessaire d'inclure le header **`<algorithm>`**

|Fonction|Description|
|---|---|
| `generate(iterateurDebut, iterateurFin, foncteur);` | Affecte la valeur retour du foncteur à chaque élément du conteneur entre `iterateurDebut` et `iterateurFin` |
| `count(iterateurDebut, iterateurFin, valeur);` | Compte tous les éléments du conteneur entre `iterateurDebut` et `iterateurFin` qui valent `valeur` |
| `count_if(iterateurDebut, iterateurFin, predicat);` | Compte tous les éléments du conteneur entre `iterateurDebut` et `iterateurFin` dont le prédicat retourne TRUE |
| `find(iterateurDebut, iterateurFin, valeur);` | Retourne un itérateur sur le premier élément du conteneur qui vaut `valeur` |
| `find_if(iterateurDebut, iterateurFin, predicat);` | Retourne un itérateur sur le premier élément du conteneur dont le prédicat vaut TRUE |
| `min_element(iterateurDebut, iterateurFin);` | Retourne un itérateur sur l'élément le plus petit |
| `max_element(iterateurDebut, iterateurFin);` | Retourne un itérateur sur l'élément le plus grand |
| `sort(iterateurDebut, iterateurFin);` | Trie les éléments du conteneur entre début et fin par ordre croissant. Le tri est effectué à l'aide de l'opérateur **`<`**. **Attention:** ne s'applique que pour les vector et le deque |
| `sort(iterateurDebut, iterateurFin, foncteur);` | Trie les éléments du conteneur entre début et fin par ordre croissant selon la définition de comparaison effectuée par le foncteur. |
| `for_each(iterateurDebut, iterateurFin, foncteur);` | Appelle le foncteur sur chaque élément du conteneur entre début et fin |
| `transform` | Permet d'itérer simultanément sur 2 conteneurs, d'effectuer des opérations sur les éléments et stocker les résultats dans un 3ème conteneur |

