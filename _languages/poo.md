---
title: POO
layout: default
icon: oop.png
---
# Présentation générale
## Fichier header: NomClasse.h
```cpp
class NomClasse
{
    public:
        // Méthodes
        NomClasse();         // Constructeur
        type methode1(arguments);
        type methode2(arguments);
        ...
    protected:
        // Attributs
        // Méthodes
    private:
        // Attributs
        type attribut1;
        type attribut2;
        ...
        // Méthodes
};
```


* *public*: on peut accéder à cette zone depuis l'extérieur de l'objet. On n'y place généralement que des méthodes
* *protected*: on ne peut pas accéder à cette zone depuis l'extérieur. Seules les classes filles ont accès à cette zone.
* *private*: seule la classe elle-même peut accéder à cette zone.

## Implémentation: NomClasse.cpp
```cpp
#include "NomClasse.h"

type NomClasse::methode1(arguments)
{
    code
    ...
}

type NomClasse::methode2(arguments)
{
    ...
}
```

* Les attributs doivent toujours être privés ou protégés. On y accède uniquement par des méthodes (c'est l'encapsulation)
* Un nom de classe commence habituellement par une majuscule
* On peut remplacer le mot-clé `class` par `struct`. Dans ce cas, les méthodes et attributs sont publics par défaut.
* Les constructeur et destructeur ne doivent renvoyer aucune valeur (même pas `void`)

# Constructeur
```cpp
NomClasse::NomClass()
{
    ...
}
```

* Le constructeur est une méthode appelée lorsque l'objet est créé
* On se sert du constructeur pour initialiser les attributs de l'objet (On ne peut pas le faire dans la déclaration de la classe)
  * Allocation de la mémoire pour les pointeurs : `ptr = new type/Classe`;
* On peut également effectuer d'autres actions nécessaires lors de la création de l'objet.
* Dans le cas d'une classe dérivée (héritage), le constructeur de la classe mère est appelé en premier, puis le constructeur de la classe fille
  * en cas d'héritage multiple, on construit la classe ancêtre en 1er et la classe fille en dernier

## Constructeur avec liste d'initialisation
```cpp
NomClasse::NomClasse() : Attribut1(Valeur), Attribut2(Valeur), ...
{
    ...
}
```

* Initialise des attributs de l'objet.
* L'utilisation de la liste d'initialisation est obligatoire pour initialiser les éléments suivants:
  * Initialisation d'un membre constant (Comme il est constant, une fois créé on ne peut plus modifier sa valeur)
  * Initialisation d'un membre qui est une référence
  * Initialisation d'un objet membre: Le constructeur des objets membre est appelé avant d'exécuter le corps du constructeur
  * Appel d'un constructeur spécifique de la classe mère (dans le cas d'une classe dérivée)

## Surcharge du constructeur
```cpp
NomClasse::NomClasse(type param1, type param2, ...) [ : liste d'initialisation]
{
    ...
}
```

* Si le constructeur n'a pas d'argument, il s'agit du **constructeur sans argument**
  * Le compilateur fournit un constructeur sans argument par défaut
  * Il est conseillé de redéfinir ce constructeur sans argument
  * Si au moins un constructeur surchargé est défini, le compilateur ne fournit plus le constructeur sans argument par défaut
* Si le constructeur possède des arguments, c'est une surcharge du constructeur.
* Si l'objet est déclaré sans argument, le constructeur par défaut est utilisé `NomClasse nomObjet;`
* Si l'objet est déclaré avec des arguments, le constructeur surchargé est utilisé `NomClasse nomObjet(arg1, arg2);`

## Constructeur de copie
Le constructeur de copie est le constructeur utilisé lorsqu'on crée un objet à partir d'un autre.

Il est également utilisé
* lorsqu'on passe un objet en tant que paramètre d'une fonction sans utiliser de référence. L'objet est dupliqué (grâce au constructeur de copie) pour être utilisé à l'intérieur de la fonction.
* lorsqu'une méthode retourne un objet, une copie de l'objet est créée pour être retournée à la fonction appelante

```cpp
 NomClasse objet2(objet1);
 NomClasse objet2 = objet1;
 ```

* Par défaut, le compilateur crée automatiquement un constructeur de copie. Ce constructeur se contente de copier tous les attributs
* Si l'objet copié comprend un pointeur: avec le constructeur par défaut, les pointeurs des 2 objets pointent sur les mêmes éléments.
* Dans le 2ème cas (signe **`=`**), il s'agit d'un constructeur de copie et non d'une surcharge de l'opérateur d'affectation **`=`**. Le constructeur de copie est appelé à l'initialisation de la variable lors de sa création. L'opérateur d'affectation est appelé lorsque qu'on ré-affecte l'objet en cours d'exécution du programme.
* On peut définir un constructeur de copie personnalisé `NomClasse::NomClasse(NomClasse const& source)`

## Constructeur par délégation
Pour éviter de dupliquer du code, un constructeur peut appeler un autre contructeur.
```cpp
NomClasse::NomClasse(arguments) : AutreConstructeur() {
   ...
}
```

# Destructeur
```cpp
NomClasse::~NomClass()
{
...
}
```

* Le destructeur est une méthode appelée lorsque l'objet est détruit
* On se sert du destructeur pour libérer la mémoire qui est utilisée pas les attributs de l'objet.
  * Ne pas oublier de libérer la mémoire utilisée par les pointeurs : **`delete(ptr);`**
* On peut également effectuer d'autres actions nécessaires lors de la destruction de l'objet.
* Le destructeur ne peut pas être surchargé
* Dans le cas d'une classe dérivée, le destructeur de la classe fille est appelé en 1er puis le destructeur de la classe mère

# Elements constants
## Méthodes constantes
```cpp
NomClasse::methode(arguments) const
{
...
}
```

* Une méthode constante est une méthode qui ne modifie pas les attributs de l'objet

## Argument constant
```cpp
fonction(const type arg1, type arg2) {
 ...
}
```

* L'argument `arg1` est déclaré constant, il **NE** pourra **PAS** être modifié par la fonction


## Valeur de retour constante
```cpp
const type fonction(arguments) {
...
}
```

* La valeur (ou l'objet) de retour ne pourra pas être modifié
  * Utilisé en général conjointement avec le retour par référence

# Eléments statiques
**IMPORTANT:** Les éléments statiques sont des spécificités du langage C++.

## Méthodes statiques
* Méthode définie dans une classe qui peut être appelée sans que la classe ne soit instanciée (i.e. La méthode est exécutée sans être liée à un objet)

Déclaration:
```cpp
class ''nomClasse''
{
    public:
        static type nomMethode;
}
```

Utilisation:
```cpp
nomClasse::nomMethode();
```

## Attributs statiques
* attribut appartenant à la classe et non à l'objet
* Déclaré avec les autres attributs de la classe avec le mot clé **`static`**
* La variable est rattachée à la classe mais est accessible depuis tous les objets créés
* Doit être initialisé en dehors de toute fonction (à la manière d'une variable globale). Généralement, est initialisée dans le fichier cpp de la classe correspondante.  `type nomClasse::nomAttribut = valeur;`

# Amitié {#friendship}
**IMPORTANT:** L'amitié est une spécificité du langage C++.

Une méthode ***amie*** d'une classe a le droit d'accéder à tous les membres de la classe, même les éléments `private` ou `protected`.
* Dans la classe, on déclare toutes les fonctions amies. Pour cela, on réécrit le propotype de la fonction amie, précédé du mot clé **`friend`**
* on peut déclarer comme amis une fonction, une méthode, une classe entière ou des templates
* La déclaration des amis peut se faire dans n'importe quelle section: public, protected ou private

```cpp
class nomClasse
{
private:
    '''friend''' ''type'' autreClasse::methode(nomClasse obj);
    '''friend''' class autreClasse;
}
```

**Règles générales de l'amitié**
* une fonction amie ne doit pas modifier ni supprimer l'instance de la classe
* l'amitié ne doit être utilisée qu'en dernier recours

**Observations**

En C++, l'amitié ne s'hérite pas. Si une classe B est déclarée en tant qu'amie de la classe A, alors la classe B peut accéder aux membres privés de la classe A. En revanche, une classe C déclarée comme classe fille de la classe B, n'aura pas accès aux membres privés de la classe A. La classe C n'est pas amie de la classe A, sauf à la déclarer explicitement.

# Accesseurs : Getter & Setter
* Getter : Méthode renvoyant la valeur d'un attribut
* Setter : Méthode modifiant la valeur d'un attribut

# Surcharge d'opérateur
## Surcharge de l'opérateur +
* Surcharger l'opérateur + revient à créer la fonction **`operator+`**
* 2 options (mutuellement exclusives):
  * On surcharge la fonction `operator+` : Ce n'est pas une méthode de la classe mais une fonction (ne pas oublier son prototype)
  * On définit la méthode `operator+` de la classe
* On écrit cette fonction de telle façon à faire référence à la surcharge de l'opérateur **`+=`** (qui lui est une méthode de la la classe)
* Valable pour les opérateurs, +, -, *, / et %

```cpp
NomClasse operator+ (NomClasse const& a, NomClasse const& b)   // Surcharge de la fonction
{
    Duree copie(a);
    copie += b;
    return copie;
}
```

ou

```cpp
NomClasse NomClasse::operator+ (NomClasse const& b)   // Définition de la méthode
{
    Duree copie(*this);
    copie += b;
    return copie;
}
```

### Surcharge de l'opérateur "moins unaire"
* L'opérateur moins unaire renvoie l'opposé d'un nombre (-a)
* Son prototype est différent car il n'admet qu'un seul argument

```cpp
NomClasse operator-(NomClasse const& a);
```

## Surcharge de l'opérateur +=
* La surcharge de l'opérateur **`+=`** est une méthode de la classe
* Cette méthode sert à définir comment réaliser l'opération désirée avec des objets de la classe
* Valable pour les opérateurs, +, -, *, / et %

```cpp
NomClasse& NomClasse::operator+=(NomClasse const& a)
{
    ...
    return *this;
}
```

## Mélange de types
* On peut surcharger encore plus les opérateurs pour effectuer une opération sur des types différents
* Il suffit de surcharger l'opérateur avec les arguments adéquats

Surcharge de la fonction de l'opérateur:
```cpp
NomClasse operator+(NomClasse const& a, ''type'' b)
```

Surcharge de la méthode
```cpp
NomClasse& NomClasse::operator+=(''type'' a)
```

## Surcharge de l'opérateur d'affectation:=
* La surcharge de l'opérateur **`=`** est une méthode de la classe
* Il faut vérifier qu'on ne tente pas de copier l'objet lui-même `(nomObjet = nomObjet;)`
* la méthode doit retourner **`*this`**
* Si l'objet contient des pointeurs, il faut penser à libérer la mémoire avant de la ré-allouer avec une copie de l'objet source
* Lors de la copie des pointeurs, on alloue la mémoire en copiant l'objet pointé. Attention à ne pas copier le pointeur mais bien l'objet pointé.

```cpp
NomClasse& NomClasse::operator=(NomClasse const& source)
{
    if (this != &source)     // on vérifie qu'on ne tente pas de copier un objet dans lui-même)
    {
        m_attribut = source.m_attribut;
        delete m_ptr;     // On libère la mémoire avant de changer la valeur du pointeur
        m_ptr = new NomClasse2(*(source.m_ptr));     // on alloue la mémoire pour le pointeur et on l'initialise en copiant l'objet pointé par le pointeur de l'objet source
    }
}
```

## Surcharge des opérateurs de flux: `<<` et `>>`
* Lorsqu'on inclue la librairie **`iostream`**, un objet **`cout`** de type `ostream` est automatiquement créé.
* Ecrire `cout << texte;` revient à manipuler un objet de type `ostream`.
* Pour surcharger les opérateurs de flux avec une classe, il suffit de définir la fonction suivante:

```cpp
ostream& operator<<(ostream &flux, NomClasse const& nomObjet)
{
    ...
    return flux;
}
```

* Il se peut que l'on ait besoin d'accéder aux attributs de l'objet à l'intérieur de la fonction surchargée (ce qui n'est pas possible car les attributs sont privés)
  * On utiliser les *getter*
  * On utilise le [concept d'amitié](#friendship)
  * On ajoute une méthode à notre classe. Cette méthode renvoie les attributs dans flux.

```cpp
void NomClasse::methodeAffiche(std::ostream& flux) const        // Le const est nécessaire pour éviter des erreurs de compilation
{
    flux << ''attribut1'' << ''texte'' << ''attribut2'' << endl;
}
```

## Surcharge des opérateurs de comparaison: ==, !=, <, >, <= et >=
### option 1 : méthode membre de la classe 
* Créer une méthode **`operator==`** dans la classe

```cpp
bool NomClasse::operator==(NomClasse const& obj)
```

La méthode faisant partie intégrante de la classe, elle a accès à tous les membres (yc ceux privés) pour effectuer la comparaison.

### option 2 : fonction indépendante
* Surcharger l'opérateur **`==`** revient à créer la fonction **`operator==`**
* La surcharge de l'opérateur **`==`** n'est pas une méthode de la classe mais une fonction (ne pas oublier son prototype)
* Valable pour les opérateurs !=, <, <=, > et >=

```cpp
bool operator==(NomClasse const& a, NomClasse const& b)
```

* Pour comparer les 2 objets, on peut avoir besoin de comparer les attributs. Or les attributs sont privés. Il faut donc écrire une méthode qui réalise cette comparaison

```cpp
return a.estEgalA(b);        // La méthode appelée sur ''a'' compare l'objet lui-même avec ''b''
```


```cpp
bool NomClasse::estEgal(NomClasse const& obj)
{
    return (''attribut'' ==  obj.''attribut'');
}
```

**Important:** Au sein de l'objet, on a accès à ses attributs mais on a aussi accès aux attributs d'un autre objet de la même classe.

**Astuce:** Seules 2 méthodes sont importantes: == et <. Tous les autres opérateurs en découlent.
* a != b : !(a.estEgalA(b))
* a > b : b.estPlusPetitQue(a)
* a <= b : !(b.estPlusPetitQue(a))
* a >= b : !(a.estPlusPetitQue(b))

# Héritage
* Une *classe fille* hérite d'une *classe mère*
* La classe fille hérite de toutes les méthodes et tous les attributs de la classe mère
* Une classe fille peut hériter d'une classe mère quand elle correspond à un cas particulier de la classe mère (par exemple *voiture* peut hériter de la classe *véhicule* car une voiture est un véhicule)
* Penser à inclure le header de la classe mère dans le header de la classe fille

```cpp
#include "NomClasseMere.h"
 
classe NomClasseFille : public NomClasseMere
{
    public:
        methodes
    private:
        methodes
        attributs
};
```

Le type d'héritage peut être:
* *public*: les attributs private de la classe mère ne sont pas accessible, Les attributs public et protected de la classe mère restent tel quel
* *protected*: les attributs private de la classe mère ne sont pas accessible, Les attributs public et protected de la classe mère deviennent protected
* *private*: les attributs private de la classe mère ne sont pas accessible, Les attributs public et protected de la classe mère deviennent private



## Héritage multiple
* Une classe peut être dérivée de plusieurs classes mères
* Elle hérite des membres de chacune des classes mères
  * Attention aux doublons, surtout dans le cas d'un héritage en losange
* Les constructeurs sont appelés dans l'ordre de la liste de déclaration. Les destructeurs dans l'ordre inverse.

```cpp
class ClasseDerive : public ClasseMere1, public ClasseMere2 {
 ...
}
```

* Pour spécifier la classe mère dans laquelle se trouve l'attribut mentionné, on utilise la syntaxe `ClasseMere1::membre` (avec membre un attribut ou une méthode)
* En ajoutant le mot clé **`virtual`** devant le type d'héritage, on évite les problèmes de doublon



## Dérivation de type
* Dans toutes les méthodes où un objet de la classe mère est attendu, on peut le substituer par un objet de la classe fille.
  * **Attention:** Le contraire n'est pas possible.
* On peut écrire: `ptrClasseMere = ptrClasseFille;`
  * Dans ce cas `ptrClasseMere` pointe sur un objet de la classe fille.
  * La classe fille possède plus d'attributs et de méthodes que la classe mère.
  * En utilisant `ptrClasseMere`, on ne peut accéder qu'aux attributs et méthodes définies dans la classe mère. Même si l'objet pointé possède des attributs et des méthodes supplémentaires, on n'y accède pas par le pointeur de type classe mère.

## Constructeurs de classe héritée
* Lors de la déclaration d'un objet, le constructeur de la classe mère est appelé en premier, puis le constructeur de la classe fille
* On peut appeler *manuellement* le constructeur de la classe mère. Ceci est utile pour lui passer des paramètres.

```cpp
NomClasseFille::NomClasseFille(arguments) : NomClasseMere(arguments), attribut(valInit)
```

**Note:** les méthodes de la classe fille n'ont pas le droit d'accéder aux attributs **`private`** de la classe mère mais uniquement à ceux **`protected`**.

## Masquage
* Toutes les méthodes de la classe mère sont héritées dans la classe fille
* Si on redéfinit une méthode dans la classe fille (même nom, arguments identiques ou différents), celle-ci masque la méthode de la classe mère. La méthode de la classe fille sera appelée au lieu de la méthode la classe mère.
* On peut appeler la méthode de la classe mère depuis la classe fille (on parle de démasquage). Pour cela, on précise la portée à utiliser.

```cpp
typeRetour NomClasseFille::nomMethode1(arguments)
{
    NomClasseMere::nomMethode2(arguments);     // On appelle explicitement la méthode de la classe mère, même si elle est masquée
    code
}
```


## Fonctions virtuelles & Polymorphisme
Lorsqu'une fonction manipule un objet, pour être générique cette fonction manipule un objet de la classe mère même si l'objet lui-même est d'une classe fille. Par conséquent toutes les méthodes appelées de l'objet sont celles implémentées dans la classe mère. On peut souhaiter que ce soit les méthodes redéfinies dans la classe fille qui soient exécutées au lieu de méthodes de la classe mère. C'est le **polymorphisme**

* Une fonction peut appeler une méthode d'un objet passé en paramètre. Pour être générique, la fonction admet en paramètre un objet de type *classe mère*. Du coup, la méthode appelée est toujours celle définie dans la classe mère (même si l'objet est de type *classe fille*). Or on peut vouloir que la méthode appelée soit celle de la classe fille. Pour cela, on utilise les fonctions virtuelles.
* Une fonction virtuelle ne fonctionne qu'avec des références ou des pointeurs.
* Une fonction virtuelle se définit dans le prototype uniquement.
* Une fonction virtuelle pour la classe mère est également virtuelle pour la classe fille par héritage. Il n'est donc pas nécessaire de la re-déclarer virtuelle dans le prototype de la classe fille. On va néanmoins le faire afin de garder à l'esprit qu'il s'agit d'une méthode virtuelle.

```cpp
public:
    virtual typeRetour nomMethode(arguments);
```

* Un constructeur ne peut pas être virtuel
* Un destructeur doit être virtuel si on utilise le polymorphisme.


### Fonctions virtuelles pures
* Une fonction virtuelle pure est une méthode virtuelle héritée de la classe mère mais implémentée uniquement dans les classes filles.
* Une classe qui contient au moins une méthode virtuelle pure est une **classe abstraite**.
  * Une classe abstraite ne peut pas être instanciée.
* Les fonctions virtuelles pures doivent impérativement être redéfinies dans toutes les classes filles.
  * Sinon, elle sera également virtuelle pure par héritage et la classe fille sera donc abstraite.
* Il n'y a pas d'implémentation d'une méthode virtuelle pure
* Le prototype de la méthode virtuelle pure doit obligatoirement être défini (pour pouvoir être hérité). Sa définition est la suivante:

```cpp
virtual typeRetour nomMethode(arguments) = 0;
```
