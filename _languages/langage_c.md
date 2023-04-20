---
title: Langage C
layout: default
icon: c.svg
---
# Commentaires
```c
// commentaire d'une ligne
/* zone de commentaire */
```

# Includes
```c
#include <stdio.h>	// déclaration des librairies '#include' puis nom de la lib entre caractères <>
#include <math.h>
#include <stdlib.h>	//lib utile pr les fcts 'rand' et 'srand'
#include <ctype.h>	//lib pr fct 'toupper'
#include <string.h>	//lib pr gestion des string
```

# Définitions de valeurs
## #Define
```c
#define	VALEUR1	3	// avant la compilation, remplace toutes les variables nommées VALEUR1 par sa valeur numérique 3. Revient à créer une sorte de variable globale mais sans utiliser d'espace mémoire comme pour une variable
```

## Enumération
```c
enum  NOM_LISTE   // enumération d'éléments
{
   item1 = 0,      // on peut forcer la valeur avec le signe =
   item2,          // si on ne force pas la valeur, on incrémente la valeur précédente
   item3,
   nb_item
};
```

# Déclaration de variables globales
Une variable globales se défini comme toute variable mais en dehors des fonctions. La variable sera alors accessible par toutes les fonctions présentes dans le fichier (ou les autres fichiers qui incluent cette déclaration).
```c
int var_glob1 = 0;
``` 

# Déclaration de fonctions
Toute fonction doit être connue avant d'être appelée (au moment de la compilation). Soit en implémentant la fonction avant son appel, soit en la déclarant en début de fichier (ou dans un header inclus): on appelle ça les *prototypes*

```c
int fonction1(int param1);
void fonction2(int param2, float param3);
```
Le prototype se différencie de l'implémentation par la présence du `;`

# Fonction principale
Déclaration de la fonction `main` de type `int`

Les accolades sont utilisées pour délimiter les portées (zone d'une fonction, d'une boucle, etc.)

les instructions doivent toujours être terminées par `;`

```c
int main()
{
    fonction1();
    fonction2();
}
```

## Zone de déclaration des variables
En général, on déclare toutes les variables utilisée par la fonction au début de celle-ci.
```c
int i;		// déclaration de la variable i qui est de type 'integer'
int j=0;	// déclaration ET intialisation de la variable j
```

Types de variables :
```c
int k=0;		// integer
float f=0;		// float
char c='E';		// caractère
```

## Fonctions utiles
### Fonctions I/O basiques
```c
puts("bonjour");	// affichage d'une chaine de caractères
getchar();		// attend l'appui sur une touche
a=getchar();		// retourne la valeur saisie ds la variable. Valable uniquement pr les caractères
printf("hello world\n");	// affiche la chaine de caratères entre "". \n = retour à la ligne
scanf("%d",&j);		// attend la saisie d'une valeur. permet également de saisir des valeurs numériques. /!\ IMPORTANT : tjs mettre & devant la variable
scanf("%s",chaine);	// attend la saisie d'une chaine de caractères
gets(chaine);		// attend la saisie d'une chaine. la touche ENTER n'est pas comptabilisée
```

### Fonctions mathématiques de base
```c
abs(i);			//valeur absolue
fabsf(f);		//valeur absolue pr un float
ceilf(f);		//arrondi supérieur d'un float
sqrt(i);		//racine carré
val1%val2;		// l'opérateur % renvoie le reste de la division euclidienne de val1 par val2
srand(time(NULL));	// initialisation du générateur aléatoire sur l'horloge
rand();		//génère un nb entier aléatoire
i++			// i=i+1
i+=2			//incrémente de 2 en 2	
i--			// i=i-1
j=i++			// j=i PUIS i=i+1  --> incrémentation post-fixée
j=++i			// i=i+1 PUIS j=i
```

### Manipulation de chaînes de caractères
```c
toupper(char);		//transforme le char en son équivalent en majuscule
strlen(chaine)		// renvoie la longueur de la chaine de caractère 'chaine' (sans le 0 de fin)	
strcpy(cible,"source")	// copie une chaine de caractères
strcat(chaine1,chaine2)	// concaténation de 2 chaines. le resultat est placé dans chaine1
strncpy(chaine1,chaine2,n);	//copie les n premiers caractères de chaine2 au début de chaine1
strncat(chaine1, chaine2, n);	//concatene les n premiers caractères de chaine2 à la suite de chaine1. le résultat est placé ds chaine1
strcmp(chaine1, chaine2);	//compare 2 chaines. 0 si chaine1=chaine2 / -1 si chaine1<chaine2 / +1 si chaine1>chaine2
ret=sprintf(chaine,"%d",i);	//convertit la variable i en chaine et la stocke dans chaine. si erreur -> ret<0, sinon ret=nb de caractères stockés
ret=sscanf(chaine,"%f%d%d",&i,&j,&k);	//convertit le tableau chaine de caractères en valeurs num (resp float,int,int) et les stocke ds les variables i,j,k. Si erreur -> ret<0, sinon ret=nb variables copiées
```	

### printf()
```c
printf("la valeur i est %d",i);	/* affiche la valeur de i. %d signifie l'affichage d'une variable, spécifiée à la fin. Le format d'affichage de la variable est défini par la lettre après le % */
```

Types de format de sortie de variable
```c
printf("%d",i);		// decimal
printf(%3d, i);		// décimal sur 3 chiffres	/!\ ecrit "  3" au lien de "003"
printf("%f",f);		// flottant
printf("%.2f",f);	// flottant avec 2 décimales
printf("%p",p);		// adresse en hexadecimal
printf("%c",c);		// caractère
printf("%s",s);		// chaine de caractères (string)

%d, %i	décimal signé	(int)
%o	octal non signé	(int)
%x, %X	héxadécimal (non précédé de 0x) en minuscules ou en MAJUSCULES	(int)
%u	décimal non signé	(int)
%e, %E	format scientifique	(double)
%g, %G	au format %e si exposant < 10^-4	au format %f sinon	(double)
```	

Affichage des caractères spéciaux
```c
printf("\'");	//caractère '
printf("\"");	//caractère "
printf("\%");	//caractère %
```

### Conditions
```c
if (condition)	//if then else : bien mettre la condition entre ()
{
   //code		// ne pas oublier les accolades {}
}   			// si une seule instruction dans la partie code, on peut se passer des accolades
else
{
   //code
}
```
Plutôt que d'imbriquer les `if` dans les `else`, on peut simplifier l'écriture en utilisant `else if`.

|Symbole|Opération|
|:---:|---|
| < | Inférieur |
| > | Supérieur |
| <= | Inférieur ou égal |
| >= | Supérieur ou égal |
| == | Egal |
| != | Différent |
| && | ET |
| \|\| | OU |
| ! | NOT |


pour les valeurs numériques, vaut `VRAI` si différent de `0`

### Boucles
#### Boucle while (condition à la fin)
 ``` c
do {			// do .. while
    //code
}
while (condition)	// /!\ condition entre ()
```

#### Boucle while (condition au début)
```c
while (condition) {
    //code
}
```

#### Boucle for
```c
for (i=0 ; i<15 ; i=i+1) {	// boucle for (initialisation ; repeter tant que ; pas)
    //Code
}
```

#### Choix multiples
```c
switch (condition) {
    case 0: {
        //code
        }
        break;
    case 1: {
        // code
        }
        break;
    default: {
        //code
        }
        break;
        }
```

### Pointeurs
Un pointeur est une variable qui contient l'adresse mémoire d'une autre variable. On dit qu'il pointe sur la variable.

```c
char c='A';
printf("%c",c);		// affiche: A
printf("%p",&c);	// affiche: 0xbfe819a2
    // c refère à la valeur de la variable
    // &c refère à l'adresse mémoire de la variable

int* p         // déclare le pointeur p qui pointe vers un entier
*p             // renvoie la variable pointée
               // modifier p revient à modifier l'adresse vers laquelle on pointe
               // modifier *p revient à modifier la valeur de la variable pointée
int* p=NULL	// déclare et initialise le pointeur avec la valeur NULL. équivaut à déclarer le pointeur comme non valide
```

**Exemple:**
```c
char car;	//on déclare une variable de type char
char* pt_car;	//on déclare un pointeur qui pointe sur un char
                //pour l'instant, pt_char n'est pas initialisé, il ne pointe sur rien
pt_car = &car;	//on affecte l'adresse de car au pointeur --> le pointeur pointe sur 'car'
*pt_car='D'	//on modifie la variable pointée (donc car) --> on modifie la valeur de 'car'
```

**Attention:** attention aux opérations mathématiques sur pointeurs
```c
*ptr++;	// incrémente l'adresse (pointe la case mémoire suivante)
(*ptr)++	// incrémente la variable pointée
```

# Fonctions
une fonction est tjs définie ainsi: 

`type_de_variable_retournée nom_de_la_fonction (type_du_paramètre nom_du_paramètre, ... )`

```c
int nom_fonction(int param1, int param2)
{
  int var_int=0;    // Définition des variables
  // code
  return var_int;   // Valeur de retour (option)
}
```

# Procédures
Une procédure est une fonction qui ne renvoie rien en sortie. Pour cela, on crée une fonction qui prend le type `void`

```c
void nom_procedure(int param1, int param2)
{
 	//code
 	//noter l'absence de 'return'
}
```

# Passage de paramètres
## Copie des paramètres dans des variables locales
```c
int main() {
    int a=2
    fonction1(a)		//appelle la fonction1 avec passage du paramètre a
 			//après l'appel de fonction1, a n'est pas modifié et vaut toujours 2
    return 0
}

void fonction1(int var) {	//la fonction effectue une COPIE du paramètre ds sa variable local 'var'.
    var=3			//cette variable locale est détruite à la sortie de la fonction
 				//toute modification effectuée sur la variable local 'var', n'affecte pas la variable passée en paramètre (variable 'a')
}
```

## Modification des variables à l'intérieur de la fonction
```c
int main() {
    int a=2
    fonction1(&a)	//appelle la fonction1 avec passage en paramètre de l'adresse de la variable a
 			//après l'appel de fonction1, a est modifié et vaut 3
    return 0
}	

void fonction1(int* p) {	//la fonction recoit en paramètre un pointeur (i.e. une adresse)
    *p=3				//en travaillant sur la variable pointée, on ne modifie pas la variable locale mais la variable de la fonction principale
 				//à la sortie de la fonction, la var locale (i.e. le pointeur) est détruite. Ce n'est pas grave puisque la cible du pointeur a été modifiée
}
```


# Tableaux
```c
int tab[10];	// déclaration d'un tableau de 10 cases contenant des integer
char tab2[5]	// déclaration d'un tableau de 5 cases contenant des caractères
int tab3[] = {0, 5, 10, 4}  // déclaration et affectation d'un tableau (le tableau fera dc 4 cases)

tab[0]		// 1ère case du tableau
tab[9]		// 10è et dernière case du tableau
tab[10]		// 11è case du tableau --> ERREUR
```

Une chaine de caractère se compose d'un tableau de char terminé par `0` (caractère `NULL` (code ascii `0x00`) à ne pas confondre avec le caractère `'0'` (code ascii `0x60`))
la chaine `'strg'` est stockée dans un tableau de 5 cases : `'s'` `'t'` `'r'` `'g'` `0`

```c
tab[0];		// 1ère case du tableau
&tab[0];	// adresse de la 1ère case du tableau
tab		// adresse de la 1ère case du tableau
```

## Tableaux à 2 dimensions
```c
int tab[3][2];		//déclaration d'un tableau de 3 lignes et 2 colonnes
```



# Structures
## Typedef
```c
typedef int entier;    // définit un nouveau type. Ce type s'appelera 'entier' et sera de type 'int'
                        // on a donc les types 'int' et 'entier' qui sont rigoureusement identiques
```

## Structures
```c
struct nom_struct{     // défini une structure
                        //définition de la structure
} nom_type
 
struct nom_type nom_var;	//la variable nom_var possède la structure 'nom_type'. obligation de préciser que c'est une structure
```

En règle générale, les instructions `typedef` et `struct` sont combinées:
```c
typedef struct {	// definition d'une structure directement affectée en tant que type
      //définition de la structure
} nom_type
 
nom_type nom_var;	//l a variable nom_var possède la structure nom_type/
```

## Exemple 
Variable de type structure
```c
typedef struct {		// Définition d'une structure 'personne'
    char nom[40];
    char prenom[40];
    int age;
} personne;
 
personne p;	// création d'une variable p qui est du type de la struture 'personne'
 
p.nom		// accès aux différents champs de la structure
p.prenom
p.age
```

Pointeur sur une structure
```c
personne *p1;     // création du pointeur sur une variable de type 'personne'
personne* p2;
 
(*p1).nom     // accès à un membre de la variable pointée (syntaxe à éviter)
p1->nom       // syntaxe à privilégier
```

# Manipulation de fichiers
```c
FILE* p_fichier;		// création d'un pointeur qui pointe sur un objet de type fichier
 
p_fichier = fopen(nom_fichier, "w");	//ouverture du fichier en ecriture ("w"). lecture = "r". append = "a" (ajout)
 					// w : crée un nouveau fichier (écrase si déjà existant)
 					// r : ouvre un fichier. renvoie NULL si inexistant
 					// a : se place à la suite d'un fichier. crée un nouveau si inexistant
 					// b : ouverture du fichier en mode binaire, doit être conjugué avec une des 3 autres options: "wb", "ab", "rb"
fclose(p_fichier);
 
fprintf(p_fichier, "%s", chaine_a_ajouter);
feof(p_fichier);		// renvoie TRUE si on a atteint la fin du fichier
```
