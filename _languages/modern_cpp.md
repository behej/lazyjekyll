---
title: Modern C++
layout: default
icon: cpp.svg
---
# 👷‍♂️ Constructors
## ⛔ Deleted constructor

Interdit l’usage d’un certain constructeur ou opérateur qui pourrait éventuellement être généré automatiquement par le compilo.

Si le code essaie d’appeler le constructeur par copie ou de faire une affectation, la compilation échouera.

```cpp
class MyClass {
public:
	// No copy constructor
	MyClass(const MyClass& obj) = delete;

	// No assignement operator
  MyClass& operator=(const MyClass& obj) = delete;
}
```

## 🌐 Default constructor

Indique explicitement que le constructeur utilisé est le constructeur par défaut généré par le compilo.

```cpp
class MyClass {
public:
	// Default constructor
	MyClass() = default;

	// Default copy constructor
	MyClass(const MyClass& obj) = default;

	// Default assignement operator
  MyClass& operator=(const MyClass& obj) = default;
}
```

## 📣 Explicit constructor

Interdit les conversions implicites de type

Dans le test dans l’exemple suivant, le membre de gauche est de type `MyClass`. Le membre de droite est un `int`, donc le programme va tenter de convertir implicitement la valeur `1` en objet de type `MyClass`. Ce serait possible puisqu’il existe un constructeur `MyClass` acceptant un seul paramètre de type `int`. Mais ce constructeur est défini comme `explicit`, il ne peut donc pas être utilisé pour une conversion implicite.

```cpp
class MyClass {
public:
	// Default constructor
	explicit MyClass(int a, int b = 0) = default;
}

if (MyClass(1) == 1)    // ERROR: implicit conversion of integer 1 to type MyClass
```

# 🐣 Initializations

## {} Braces initialization

On peut initialiser les variables à l’aide d’accolades. Cela empêche les “réductions” (*narrowing*).

Ainsi, une valeur n’est pas dégradée pour coller au type de la variable initialisée.

```cpp
int a {3};         // Value 3 matches the int type -> OK
int b = 3.5;       // Narrowing happens here: 3.5 is changed to 3 because var b is an int -> NOT GOOD
int c {3.5};       // Value 3.5 is a double and doesn't match the int type -> ERROR
```

Cela fonctionne également pour initialiser des objets

```cpp
MyClass obj1 {MyClass()};
MyClass obj2 {};
```

## 🚗 `auto` keyword

Le mot clé `auto` permet de définir automatiquement le type d’une variable. Il n’y a plus besoin de déclarer le type d’une variable, ce dernier est automatiquement déterminé par le compilateur. On va alors s’efforcer que la partie de droite de l’expression permette de définir le plus précisément le type.

```cpp
auto var1 {3};         // var1 will be of type 'integer'
auto var2 {3.};        // var2 will be of type 'double'
auto var3 {int(42)};   // var3 will be of type 'integer'
```

L’utilisation est aussi très pratique pour qu’une variable s’adapte automatiquement au type retourné par une fonction.

Dans l’exemple ci-dessous, `var4` s’adaptera nécessairement au type retourné par la fonction, quel qu’il soit.

```cpp
auto var4 {myFunction1()};
```

Le mot clé `auto` présente de nombreux **avantages**:

- La présence de variables non initialisées devient impossible
- Aucune conversion. La variable sera directement du même type que la valeur d’initialisation
- Meilleure adaptabilité aux changements futurs. Si le type retourné par une fonction évolue, la variable utilisée pour recueillir la valeur retour n’a pas besoin d’être mise à jour.
- Évite d’avoir à écrire des types compliqués (notamment les itérateurs)

L’**inconvénient** principal du mot clé `auto` est qu’il n’est pas adapté si une variable doit absolument être d’un type précis.

## 🔒 const *vs.* constexpr

▶️ Le mot clé `const` permet de définir une variable comme étant *constante*. Cela signifie qu’une fois initialisée, il ne sera plus possible d’en changer sa valeur.

▶️ Le mot clé `constexpr` est assez similaire, à la différence que la valeur d’initialisation peut être déterminée au moment de la compilation.

## 📢 decltype

Le mot clé `decltype` permet de déduire le type d’une constante, d’une variable ou encore d’une expression.

```cpp
decltype(3)                // -> 'int'
decltype(myFunction2())    // -> the type returned by the function
```

Cette instruction prend tout son sens dans l’utilisation des *template*.

Dans des templates, on manipule un ou plusieurs types inconnus au moment de l’écriture du code. Si on a besoin de connaitre le type résultant de la combinaison de plusieurs type du template, seule l’utilisation de `decltype` nous permet de le déterminer.

```cpp
template<typename T1, typename T2>
auto function(T1 x, T2 y) {
    decltype(x * y) localVar {x * y};
}
```

## 🅿️ Placement new (new positionnel)

**L’opérateur placement new permet de construire un objet à un emplacement mémoire connu et déjà alloué.**

Une zone mémoire est allouée dans la stack de manière classique (variable simple ou tableau d’une certaine taille).

L’opérateur new positionnel est appelé pour créer des objets dans cette même zone mémoire. Il n’y a pas d’allocation mémoire dans le heap comme pour un new classique, l’objet est directement créé à l’adresse indiquée.

Pas besoin de destructeur puisque la zone mémoire sera automatiquement libérée lors du *unstack*. Si besoin, on peut appeler explicitement le destructeur, le code correspondant sera exécuté mais la zone mémoire ne sera pas désallouée.

```cpp
{
    unsigned char buffer[sizeof(MyObj) * 10];     // Allocation sur la stack d'une zone correspondant à la taille de 10 objets
    
    MyObj* obj1 = new(buffer)MyObj();             // Création d'un objet au début de la zone allouée
	  MyObj* obj2 = new(buffer + sizeof(MyObj))MyObj();  // Création d'un second objet dans la zone allouée (on se décale de la taille de l'objet)

    // utilisation des objets
}   // Fin du scope, la zone 'buffer' est libérée
```

👍 **pros**

- Utile pour construire une pool
- Élimine les risque d’erreur d’allocation mémoire
- Temps d’exécution réduit (car par besoin d’allouer la mémoire)
- Utile en environnement avec ressources limitées
- peut également trouver une utilité si un objet à besoin d’être souvent recréé (l’objet est recréé, mais on économise l’allocation mémoire à chaque fois)

[Placement new operator in C++ - GeeksforGeeks](https://www.geeksforgeeks.org/placement-new-operator-cpp/)

# 📦 Move semantics
## 📔 Définitions

- `lvalue`: opérande de gauche - une variable avec un nom et un emplacement mémoire associé
- `rvalue`: opérande de droite - un littéral, une valeur temporaire, non nommé

## Sur-définition des fonctions

- `foo(int)` : Une fonction “standard” prend comme paramètre une variable ou un littéral qui va être copié dans une variable local, interne à la fonction. Toute modification sur cette variable n’a pas d’effet sur la variable originelle.
- `foo(int&)` : La fonction peut utiliser comme paramètre une référence. Dans ce cas, la fonction travaille directement sur la variable originelle. Cette dernière doit être modifiable
- `foo(const int&)` : La fonction peut utiliser comme paramètre une référence à une variable non modifiable ou à une `rvalue` (après copie)
- `foo(int&&)` : La fonction peut utiliser comme paramètre une `rvalue`

Dans la dernière forme, la variable peut être modifiée à l’intérieur de la fonction, ce qui était impossible avant C++11 car l’utilisation d’un `rvalue` utilisait nécessairement la version `foo(const int&)`.

```cpp
int a {5};
constexpr int b {6};
foo(a);     // use of foo(int&)
foo(b);     // use of foo(const int&)
foo(5);     // use of foo(int&&)
foo(a+b);   // use of foo(int&&)
```

## 📝 Faits notables

- définir à la fois `foo(int)` et `foo(const int)` engendrera des appels ambigus
- définir à la fois `foo(int)` et `foo(int&)` engendrera des appels ambigus
- définir `foo(const int&&)` est légal mais n’a pas vraiment d’utilité car la modification de la variable est interdite. Autant utiliser `foo(const int&)`.

## 🚛 Déplacement

L’instruction `move` permet de transformer une `lvalue` en `rvalue`.

Grâce à cette instruction `move`, le compilateur est forcé d’utiliser le constructeur de déplacement (move contructor) ou l’opérateur d’affectation par déplacement (move assignment operator).

```cpp
foo(move(a));     // 'a' is changed to rvalue -> use of foo(int&&)
```

La philosophie de cette instruction `move` est de transférer la variable utilisée. A partir de ce moment, sa responsabilité est déléguée à la fonction appelée. La variable ne devrait plus être utilisée en dehors de cette fonction.

Les cas d’utilisation n’apparaissent pas évidents pour des variables simples. Elle prend son sens avec des objets.

## Application aux objets

Le principe est le même que pour les variables basiques.

La différence réside dans le fait qu’il est possible, voir recommandé, de définir:

- un constructeur de déplacement
- un opérateur d’affectation par déplacement

```cpp
class MyClass
{
    MyClass();                       // Default CTor
    MyClass(const MyClass& other);   // Copy CTor
    MyClass(MyClass&& other);        // Move CTor

    MyClass& operator=(const MyClass& a);    // Assignment operator
    MyClass& operator=(MyClass&& a);         // Move asignment operator
};
```

> ⚠️ Si un membre de la classe est un **pointeur**, il est également important de transférer le pointeur de la classe *source* vers la classe *destination*. Dans le cas de l’opérateur d’affectation par déplacement, on prendra également soin de libérer l’adresse pointée initialement avant de réaliser le déplacement.
L’objet déplacé, s’il contient un pointeur sur une zone allouée dynamiquement, ne devra plus référencer cette zone après déplacement.

> ⚠️ Les opérateurs de déplacement (constructeur et affectation) doivent être marqué `noexcept` si possible, surtout si les objets sont utilisés par des algorithmes de la STL. Cela afin d’optimiser le temps d’exécution en utilisant le déplacement plutôt que de réaliser des copies. En effet, certains algos de la STL ne vont privilégier le copie plutôt que le déplacement si constructeur de déplacement et opérateur d’affection par déplacement ne sont pas marqué `noexcept`.

# 🧠 Smart pointers

Le but des smart pointers est de mieux gérer l’allocation et la libération de la mémoire en supprimant les appels aux fonctions `new` et `delete`. La libération de la mémoire est gérée automatiquement lors de la suppression du pointeur (plus de risque de fuite mémoire).

Les smart pointers permettent également de mieux définir le propriétaire d’un pointeur (et donc qui en a la responsabilité)

## 1️⃣ Unique pointer

Déclaration d’un pointeur qui ne peut pas être copié.

L’emplacement mémoire est automatiquement libéré lors de la suppression du pointeur.

```cpp
#include <memory>

unique_ptr<T> pointer {make_unique<T>(value)};
*pointer          // dereferencement 
pointer.get();    // retourne l'adresse du pointeur
```

```cpp
auto pointer2 = pointer;    // Forbidden
f(pointer);                 // Forbidden
```

```cpp
{
	auto pointer {make_unique<T>(value);
}     // -> variable gets out of scope, memory is automaticall freed
```

### Déplacement d’un unique_ptr

Un `unique_ptr` ne peut pas être copié. Pour le transférer, il faut le déplacer explicitement avec l’instruction `move`.

Le pointeur est alors déplacé, sa propriété est transférée.

```cpp
auto pointer2 = move(pointer1);
```

A partir de cette instruction, `pointer1` initial n’est plus valide. Il ne doit plus être utilisé. C’est dorénavant `pointer2` qui est propriétaire et responsable de la zone mémoire référencée.

Après exécution de l’instruction `move`, `pointer2` référence l’adresse mémoire précédemment référencée par `pointer1`, tandis que `pointer1` est positionné à `0` pour être sûr de ne plus accéder une zone mémoire existante s’il était encore utilisé par erreur.

## ➕ Shared pointer

Déclaration d’un pointeur qui peut être copié.

Maintient d’un compteur qui recense le nombre de pointeurs référençant cette zone.

Lorsque plus aucun pointeur ne référence la zone, l’emplacement mémoire est libéré.

```cpp
#include <memory>

shared_ptr<T> var {make_shared<T>(value)} ;
*pointer                // dereferencement 
pointer.get();          // retourne l'adresse du pointeur
pointer.use_count();    // nombre de pointeurs sur cette adresse
```

## 💪 Weak pointer

**Les weak pointers sont à utiliser dans le cas de dépendances circulaires.**

En cas de dépendance circulaire entre plusieurs objets, ceux-ci ne seront jamais automatiquement détruits car il y a aura toujours une référence vers chacun de ces objets: les objets de la boucle se référencent entre eux mais aucune référence externe n’existe encore. Tous les objets de la boucle de dépendance pourraient être supprimés, mais le programme ne sait pas par quel objet commencer.

L’utilisation d’un weak pointer dans cette boucle permet de résoudre ce problème. Le weak pointer n’est pas comptabilisé dans les références vers un objet. Ainsi, le programme sera capable de détecter qu’un objet n’est plus référencé par le reste du programme et la boucle sera supprimée.

# 📦 Containers

## Type de containers

### Vectors

Un vecteur est une collection d’éléments stockés dans un espace mémoire contigu. Un vector est nécessairement alloué sur le tas.

**👍 Pros**

- possibilité d’accéder directement à n’importe quel élément
- pas d’utilisation de mémoire supplémentaire pour la gestion du vecteur

👎 **Cons**

- Ajouter des éléments dans le vecteur peut engendrer une relocalisation complète de tout le vecteur (opération longue)
- Insérer un élément est une opération lourde (nécessité de décaler tous les éléments après celui inséré)
- toute la mémoire est pré-allouée (potentiellement trop de mémoire et donc du gaspillage)

### List

Les listes sont similaires aux vecteurs à la différence que la mémoire n’est pas contigue

**👍 Pros**

- Ajouter ou supprimer un élément est rapide, même en plein milieu de la liste
- seule la mémoire nécessaire est allouée

👎 **Cons**

- Accéder à un élément donné au milieu de la liste est long (nécessité de parcourir l’intégralité de la liste du début jusqu’à l’élément recherché)
- utilisation supplémentaire de mémoire pour la gestion de la liste (pointeurs sur les éléments suivants/précédents)

### Array

Similaire à un vector à la différence que la taille est statique et peut être allouée sur la pile.

Les array sont plus limités que les vector mais peuvent s’avérer plus efficace, notamment pour les collections de petite taille.

### Stack

Last in / First out

### Queue

First in / First out

### Deque

Idem que la queue, mais qu’on peut accéder depuis les deux extrémités.

### Set

Un set est une collection qui ne peut pas contenir deux fois le même élément.

### Map

Collection dont chaque élément est indexé non pas par sa position mais par une clé.

Grâce aux ***structured bindings*** (C++17), on peut récupérer le couple clé/valeur d’un seul coup et même les nommer pour y référer plus facilement.

```cpp
std::map<std::string name, double value> myMap;

// Ancienne syntaxe
for (auto & entry : myMap) {
	name = myMap.first;
  value = myMap.second;
  // use name and value
}

// Nouvelle syntaxe
for (auto & [name, value] : myMap) {
  // use name and value
}
```

## Itérateurs

Les itérateurs sont des patrons comportementaux permettant de parcourir facilement une structure de données telle que les containers.

L’itérateur est dépendant de la structure à parcourir.

```cpp
vector<double>::iterator it;
vector<double>::const_iterator it;
vector<double>::reverse_iterator it;
```

On peut récupérer un itérateur à partir de la structure directement

```cpp
vector<double>::iterator it {myVector.begin()};
vector<double>::iterator it {std::begin(myVector)};
vector<double>::const_iterator it {myVector.cbegin()};
vector<double>::reverse_iterator it {myVector.rend()};

// Mais plus simple d'écrire
auto it {myVector.begin()};
```

On peut se déplacer sur la structure

```cpp
it++;    // élément suivant
it+=2    // déplacement de 2
advance(it, 2)   // avance de 2
new_it = next(it, 2)   // retourne un nouvel itérateur 2 élements plus loin que 'it'
```

- iterator: Itérateur classique. Permet d’accéder et modifier les éléments de la structure
- const_iterator: Itérateur constant. Interdit la modification des éléments.
- reverse_iterator: Itérateur permettant de parcourir les éléments dans le sens inverse par rapport à l’itérateur classique
- begin/end: retourne un itérateur classique sur le début ou la fin de la structure
- cbegin/cend: retourne un const_iterator sur le début ou la fin de la structure
- rbegin/rend: retourne un reverse_iterator sur le début ou la fin de la structure
- rcbegin/rcend: retourne un reverse_const_iterator sur le début ou la fin de la structure
- back_inserter: Itérateur à utiliser lorsqu’on veut rajouter des éléments à la fin d’un container (là où l’utilisation de ***end*** donnera des résultats erronés)

## Parcourir des containers

### Range-based for loop

Permet d’itérer sur chaque élément contenu dans le container, dans l’ordre de présence dans le container.

```cpp
for (auto item : container) {
    // do something
}
```

> 💡 Note: pour les map, on peut donner un nom à chaque élément de la map (clé et valeur) pour y référer directement plutôt que d’y accéder avec `first` et `second`

```cpp
for (auto & [name, value] : map_container) {
    // do something directly with 'name' and 'value'
}
```

### std::for_each / std::for_each_n

Applique une fonction donnée sur chaque élément entre les itérateurs de début et de fin.

```cpp
std::for_each(it1, it2, f)
```

- assez similaire à la boucle range-based for loop mais offre plus de souplesse
- accepte les instruction `break` et `continue`
- séparation de l’implémentation de la boucle et du code à exécuter
- utilise des itérateurs plutôt que de parcourir chaque élément un par un. Avec un itérateur bien choisi, on peut parcourir seulement certains éléments de la liste. Possibilités encore plus avancées si on utilise la lib **ranges**

[Why You Should Use std::for_each over Range-based For Loops](https://www.fluentcpp.com/2019/02/07/why-you-should-use-stdfor_each-over-range-based-for-loops/)

## Operations sur les collections

La STL regorge de fonctions permettant d’effectuer toute sorte d’opérations sur les collections.

Voici un aperçu non exhaustif:

- **accumulate**
    - Par défaut, réalise la somme de tous les éléments de la collection
    - possibilité de spécifier une opération particuilière au lieu de l’addition
    - possibilité d’utiliser une méthode ou une lambda pour étendre encore plus les possibilités
- **reduce** (C++17)
    - Fonctionnement assez similaire à `accumulate` à la différence que l’opération réalisée doit retourner le même type que la collection et que les opérations sur la collection peuvent être réalisées dans n’importe quelle ordre et pas nécessaire du 1er au dernier.
    - possibilité de spécifier l’opération à réaliser ou d’utiliser une lambda
- **max_element**: Fonction de la STL qui cherche l’élément max de la collection
- **sort**: trie une liste
- **reverse**: inverse une liste
- **rotate**: Effectue une rotation vers la gauche
- **swap**: Intervertit 2 éléments. Les éléments peuvent être soit des objets basiques, soit des containers
- **random_shuffle**: Réarrange aléatoirement les éléments d’un container
- **transform**: effectue une opération quelconque sur tous les éléments d’une liste. L’opération peut être spécifiée avec une lambda
- **fill**: remplit tous les éléments d’une liste avec une valeur donnée
- **fill_n**: remplit n éléments d’une liste avec une valeur donnée
- **generate**: Remplit tous les éléments d’une liste avec les valeurs retournées par le générateur
- **generate_n**: Remplit n éléments d’une liste avec les valeurs retournées par le générateur
- **iota**: Remplit les éléments d’une liste à partir d’une valeur de départ en incrémentant à chaque fois cette valeur.
- **find**: cherche le premier élément de la liste égal à la valeur recherchée
- **find_if**: cherche le premier élément de la liste correspondant au critère de recherche. Le critère de recherche peut être une lambda
- **count_if**: compte le nombre d’éléments correspondant au critère. Le critère peut être une lambda.
- **partition**: réorganise les éléments d’un container de façon à ce que tous les éléments qui satisfont le critère soient regroupés au début du container, puis les éléments qui ne satisfont pas le critère. **L’ordre initial n’est pas conservé**
- **is_partitioned**: Renvoie true si tous les éléments qui satisfont le critère sont regroupés au début du container
- **stable_partition**: idem partition mais l’ordre initial des éléments est conservé
- **partition_point**: Retourne un itérateur sur le premier élément de la seconde partie (ie le premier élément qui ne satisfait pas le critère)
- **partition_copy**: copie les 2 parties séparées par partition dans 2 vecteurs destinations disctincts
- **distance**: retourne la distance (nombre d’éléments) entre 2 éléments d’un container pointés par 2 itérateurs. La valeur retournée est signée selon l’ordre des éléments
- **all_of**: Renvoie true si tous les éléments d’un container satisfont un critère donné
- **any_of**: renvoie true si au moins un des éléments d’un container satisfait un critère donné
- **none_of**: renvoie true si au aucun un des éléments d’un container ne satisfait un critère donné

# ⚡ Threading

## Généralités

- Créer un thread va démarrer l’exécution de la callback associée dans un thread différent du thread principal
- On peut attendre la fin de l’exécution d’un thread avec la méthode `thread::join`
- Lorsque plusieurs threads s’exécutent en parallèle, il est impossible de déterminer l’ordre d’exécution, ni même la préemption d’un thread sur un autre
- Si un même objet est accédé par plusieurs threads, il est primordial de protéger l’accès à cet objet par un **Mutex** (Mutual exclusion)
    - Tous les threads souhaitant accéder à un objet partagé doivent verrouiller le mutex avant de pouvoir continuer
    - Si le mutex n’est pas encore verrouillé, le premier thread va le verrouiller jusqu’à ce qu’il ait terminé les opérations nécessaires sur cet objet
    - Si le mutex est déjà verrouillé par un autre thread, le thread est bloqué jusqu’à ce que le mutex soit libéré
- Il est possible de synchroniser plusieurs threads grâce à l’utilisation de `semaphore`
    - un `semaphore` est une sorte de compteur pouvant être incrémentée/décrémentée par les threads
    - un thread incrémente le semaphore pour se signaler ou signaler la disponibilité de données à destination d’un autre thread
    - un autre thread surveille ce semaphore et peut réagir si le semaphore est non nul.
    - cas d’utilisation types:
        - un thread bloque tant que le semaphore n’a pas été incrémenté par tous le/les autres threads → Synchronisation de plusieurs threads
        - un thread attend la disponibilité de données publiées par un autre thread → Compteur de données dispos

## Thread et Async

- un thread est généralement utilisé pour exécuter du code manière asynchrone par rapport à la boucle principale. Typiquement un tâche périodique à effectuer en arrière plan, du code en écoute d’évènement externes, etc.
- les fonctions asynchrones sont généralement utilisées pour effectuer des traitements long en arrière plan.
    - Note: il n’y a aucune garantie que la méthode async soit réalisée dans un thread séparé, cela va dépendre de la compilation
    - les fonctions asynchrones fonctionnent avec le mécanisme des promesses (voir plus bas)

```cpp
std::thread t1(callback, <parameters of the callback>);   // Le thread démarre immédiatement et exécute la callback
t1.join();   // attent la fin d'exécution du thread.
```

```cpp
std::async(longComputationMethod);   // la méthode est exécutée en arrière plan pour effectuer des traitements longs
```

## Mutex et Sémaphores

Le mutex est utilisé pour interdire l’accès à une variable ou à une portion de code à 2 threads simultanément.

Avant d’accéder à la section à protéger (variable, portion de code), il faut acquérir le mutex. Si le mutex est déjà pris, le code va bloquer jusqu’à ce que le mutex soit libéré.

On peut soit manipuler directement le mutex avec les méthode `lock` ou `try_lock`

On peut également utiliser des wrappers tel que `lock_guard`

```cpp
std::mutex myMutex;
...
{
    std::lock_guard<std::mutex> myLock(myMutex);
    // section à protéger
}  // Le lock est détruit, le mutex est libéré et un autre thread peut accéder à cette section
```

Un sémaphore fonctionne comme un système avec des jetons. La méthode `release` incrémente le nombre de jetons tandis que que la méthode `acquire` décrémente le nombre de jetons.

On peut ensuite s’en service de plusieurs façons:

- Les jetons sont utilisés pour autoriser un maximum d’utilisation. Tant qu’il y a des jetons, on peut lancer une nouvelle utilisation
- les jetons sont utilisés pour surveiller la présence d’éléments. Tant qu’il y a des jetons, il reste des éléments à traiter

## Promesses

Les promesses permettent de synchroniser et transférer des données entre 2 threads. La donnée à échanger est scindée en deux éléments: la promesse (`promise`) et le futur (`future`).

Le futur est obtenu à partir de la promesse.

- Un thread possède la promesse et devra la remplir, i.e. affecter une valeur à la promesse
- Un autre thread possède le futur. Il attend que le futur soit réalisé afin de récupérer la valeur (la valeur est celle affectée à la promesse)

> 💡 il est possible de transférer une exception à travers ce mécanisme. L’exception sera notifiée à la promesse grâce à la méthode `promise::set_exception`

> 💡 si une promesse est détruite avant d’avoir été satisfaire, une exception `future_error` sera levée au niveau du futur

# 📦 Classes

## 👨‍👦 Héritage

- une méthode est déclarée `virtual` lorsqu’elle est destinée à être réimplémentée par les classes dérivées
- le mot-clé `override` permet d’explicitement déclarer qu’une méthode réimplémente une méthode de la classe de base (permet de lever une erreur de compilation si ce n’est pas le cas - faute de frappe par exemple)
- le mot-clé `final` permet de déclarer qu’aucune classe dérivée n’a le droit de réimplementer cette méthode

## 🔢 Enums

```cpp
enum class Color {
	Red,
  Green,
  Blue,
  Yellow
};

Color myColor = Color::Blue;
```

> **Notes:**
> - Il est également possible de forcer le type sous-jacent de l’enum
> - Il est possible de forcer une valeur particulière (comme pour les enum classiques)
> - Il est possible de définir des caractères plutôt que des entier (un caractère étant codé sous forme de int)

```cpp
enum class Color : char {
	Red = 'r',
  Green = 'g',
  Blue = 'b',
  Yellow = 'y'
};
```

👍 **Pros**

- Fortement typé. Ne peut pas être casté depuis ou vers un integer ou un autre enum. Le cast vers un int est possible mais explicitement.
- Une variable de même nom qu’une des valeurs de l’enum peut être créée (ex: `Color Green = Color::Green`)

👎 **Cons**

- Ne peut pas être dérivé pour être étendu avec de nouvelles valeurs

## Using

> ⚠️ TODO

# 🇬🇷 Lambda

Les ***lambdas*** permettent de représenter une expression. Elles permettent de définir des fonctions génériques, dans un style plus fonctionnel. Elles améliorent la lisibilité du code en évitant de devoir écrire des très petites fonctions et de devoir utiliser des pointeurs de fonction.

## Analyse d’une lambda

```cpp
[](){}
[]() -> int {}     // Le type de retour est explicitement indiqué. Si omis comme à la ligne précédente, le type est automatiquement déduit à partir de l'instruction 'return'
```

- `[]` : la clause de capture. Permet de définir quels éléments du scope appelant sont disponibles à l’intérieur de la lambda et comment ces éléments sont accessibles (par copie, par référence)
- `()` : Les paramètres de la lambda. Idem pour les paramètres d’une méthode.
- `{}` : Corps de la lambda, les instructions à exécuter

Il est également possible de nommer des lambdas, pour par exemple identifier clairement son rôle encore de l’utiliser à plusieurs endroits du code sans la redéfinir à chaque fois.

```cpp
auto myLambda = [](){ // code here };
```

## Capture

### Capture par valeur

Les variables du scope de l’appelant sont copiées dans les variables internes à la lambda. Modifier ces valeurs dans la lambda n’aura pas d’effet sur les variables du scope externe.

```cpp
[var](){}     // Seule la variable 'var' est capturée par valeur
[=](){}       // Toutes les variables utilisées par la lambdas sont capturées par valeur
```

> 📝 Les variables capturées par valeur sont `const` par défaut. Si le corps de la lambda tente de les modifier, cela résultera en une erreur de compil. Pour autoriser la modification des variables capturées par valeur, la lambda doit être déclarée `mutable` : `[]() mutable {}`

### Capture par référence

La lambda possède une référence vers la variable du scope externe. Modifier cette variable dans la lambda affecte réellement la variable.

```cpp
[&var](){}     // Seule la variable 'var' est capturée par référence
[&](){}        // Toutes les variables utilisées par la lambdas sont capturées par référence
[&,var]()[]    // Toutes les variables sont capturées par référence SAUF la variable 'var' qui est capturée par valeur.
```

> ⚠️ Attention à la durée de vie des variables. Si la lambda est utilisée pour du traitement asynchrone et que la variable dans le scope appelant est détruite (sortie de scope, etc.), cela générera des erreurs à l’exécution.

### Capture par alias ou par déplacement (C++14)

Mode de capture assez spécifiques et utilisés seulement dans certains cas précis.

```cpp
[x=var](){}               // capture par alias
[x=var+1](){}
[x=std::move(var)](){}    // capture par déplacement
```

> 📝 La capture par déplacement est surtout utile pour les `unique_ptr`. Attention cependant, la lambda prend possession du pointeur et le libérera lorsque l’exécution de la lambda sera terminée. Le pointeur n’est plus accessible depuis le scope appelant (après l’exécution de la lambda mais aussi pendant).

## Lambdas templatisées (C++20)

Depuis C++20, il est possible d’écrire des lambda génériques utilisant le même principe que les template.

```cpp
[]<typename T>(T myParam){}
[]<typename T>(std::vector<T> & myParam){}
```

Il était déjà possible d’écrire les lambdas génériques en utilisant le type `auto`. Mais les templates permettent d’aller plus loin. Dans l’exemple ci-dessus, la 2ème ligne montre l’avantage des templates car on peut ainsi imposer un vector en paramètre. Ce qui n’était pas possible avec auto. On aurait dû écrire `[](auto myParam){}` , ce qui n’aurait pas empêché d’appeler la lambda avec un littéral.

