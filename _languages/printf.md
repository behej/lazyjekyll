---
title: printf()
layout: default
icon: c.svg
---
# Syntaxe
```c
#include <stdio.h>

int printf(const char *format [, arg [, arg]...]);
```

# Description
Elle permet l'écriture formatée sur le flux standard de sortie stdout (l'écran par défaut).

La chaîne de caractères format peut contenir à la fois :
1. Des caractères à afficher,
2. Des spécifications de format.

Il devra y avoir autant d'arguments à la fonction `printf` qu'il y a de spécifications de format.

* Valeur retournée :
le nombre d'octets effectivement écrits ou la constante `EOF` (-1) en cas d'erreur.

# Spécificateurs de format
Ils sont introduites par le caractère % et se terminent par le caractère de type de conversion suivant la syntaxe suivante :
`% [drapeaux] [largeur] [.precision] [modificateur] type`

## Drapeaux

* *rien* : justifié à droite et complété à gauche par des espaces
* `-` : justifié à gauche et complété à droite par des espaces
* `+` : les résultats commencent toujours par le signe + ou -
* *espace* : le signe n'est affiché que pour les valeurs négatives. Un espace est affiché à la place du +
* `#` : Forme alternative. Si le *type* de conversion est :
  * c,s,d,i,u : sans effet
  * o : un 0 sera placé devant la valeur
  * x, X : 0x ou 0X sera placé devant la valeur
  * e, E, f : le point décimal sera toujours affiché
  * g, G : même chose que e ou E, mais sans supprimer les zéros à droite 

## Largeur

Elle précise la nombre de caractères n qui seront affichés.

Si la valeur à afficher dépasse la taille de la fenêtre ainsi définie, C utilise quand même la place nécessaire.

|Largeur|Effet sur l'affichage|
|---|---|
|n |affiche n caractères, complété éventuellement par des espaces |
|0n|affiche n caractères, complété éventuellement à gauche par des 0|
|* |l'argument suivant de la liste fournit la largeur|

## Précision

Elle précise pour :
* un entier: le nombre de chiffres à afficher
* un réel: le nombre de chiffres de la partie décimale à afficher (avec arrondi)
* les chaînes: le nombre maximum de caractères à afficher

|Précision|Effet sur l'affichage|
|---|---|

|*rien*|précision par défaut: d,i,o,u,x = 1 chiffre ; e, E, f = 6 chiffres pour la partie décimale. |
| .0 | d,i,o,u,x = précision par défaut ; e, E, f = pas de point décimal |
| .n | n caractères au plus|
| * | l'argument suivant de la liste contient la précision | 

## Modificateur

Il précise comment sera interprété l'argument.

| Modificateur | Interprétation comme |
|---|---|
| h | un entier de type short (d,i,o,u,x,X) |
| l | un entier de type long (d,i,o,u,x,X) |
| L | un réel de type long double (e,E,f,g,G) |

## Type

Type de conversion de l'argument.

| Type | Format de la sortie |
|---|---|
| d ou i | entier décimal signé |
| o | entier octal non signé |
| u | entier décimal non signé |
| x | entier hexadécimal non signé |
| X | entier hexadécimal non signé en majuscules |
| f | réel de la forme [-]dddd.ddd |
| e | réel de la forme [-]d.ddd e [+/-]ddd |
| E | comme e mais l'exposant est la lettre E |
| g | format e ou f suivant la précision |
| G | comme g mais l'exposant est la lettre E |
| c | caractère |
| s | affiche les caractères jusqu'au caractère nul '\0' ou jusqu'à ce que la précision soit atteinte |
| p | pointeur |

# Exemple
```c
#include <stdio.h>

main() {
    int nbre = 5;
    char *chaine = "Le langage C";
    long prix = 12.0L;
    long double result = prix * nbre;

    printf("Bonjour\n");
    printf("Nombre %d prix %ld Total %9ld\n",nbre, prix, prix * nbre);
    printf("%s est facile\n", chaine);
    printf("%8.2Lf \n", result);
    printf("%*.*Lf \n", 8, 2, result);  /* equivalent a   %8.2Lf    */
    printf("\n");                       /* affichage du caractère % */
    return 0;
}

/*-- résultat de l'exécution ------------------------------------
Bonjour
Nombre 5 prix 12 Total        60
Le langage C est facile
   60.00 
   60.00 

-----------------------------------------------------------------*/
```

**Exemple d'utilisation des formats numériques**
```c
printf("|%d|\n",12345);
>> |12345|
printf("|%+d|\n",12345);
>> |+12345|
printf("|%8d|\n",12345);
>> | 12345|
printf("|%8.6d|\n",12345);
>> | 012345|
printf("|%x|\n",255);
>> |ff|
printf("|%X|\n",255);
>> |FF|
printf("|%#x|\n",255);
>> |0xff|
printf("|%f|\n",1.23456789012345);
>> |1.234568|
printf("|%10.4f|\n",1.23456789);
>> | 1.2346|
```

```c
printf("|%d|\n",1234)
>> |1234|
printf("|%d|\n",-1234)
>> |-1234|
printf("|%+d|\n",1234)
>> |+1234|
printf("|%+d|\n",-1234)
>> |-1234|
printf("|% d|\n",1234)
>> | 1234|
printf("|% d|\n",-1234)
>> |-1234|
printf("|%x|\n",0x56ab)
>> |56ab|
printf("|%X|\n",0x56ab)
>> |56AB|
printf("|%#x|\n",0x56ab)
>> |0x56ab|
printf("|%#X|\n",0x56ab)
>> |0X56AB|
printf("|%o|\n",1234)
>> |2322|
printf("|%#o|\n",1234)
>> |02322|
                                             	
printf("|%10d|\n",1234)
>> |      1234|
printf("|%10.6d|\n",1234)
>> |    001234|
printf("|%.6d|\n",1234)
>> |001234|
printf("|%*.6d|\n",10,1234)
>> |    001234|
printf("|%*.*d|\n",10,6,1234)
>> |    001234|
                                             	
printf("|%f|\n",1.234567890123456789e5)
>> |123456.789012|
printf("|%.4f|\n",1.234567890123456789e5)
>> |123456.7890|
printf("|%.20f|\n",1.234567890123456789e5)
>> |123456.78901234567456413060|
printf("|%20.4f|\n",1.234567890123456789e5)
>> |         123456.7890|
                                             	
printf("|%e|\n",1.234567890123456789e5)
>> |1.234568e+05|
printf("|%.4e|\n",1.234567890123456789e5)
>> |1.2346e+05|
printf("|%.20e|\n",1.234567890123456789e5)
>> |1.23456789012345674564e+05|
printf("|%20.4e|\n",1.234567890123456789e5)
>> |          1.2346e+05|
                                             	
printf("|%.4g|\n",1.234567890123456789e-5)
>> |1.235e-05|
printf("|%.4g|\n",1.234567890123456789e5)
>> |1.235e+05|
printf("|%.4g|\n",1.234567890123456789e-3)
>> |0.001235|
printf("|%.8g|\n",1.234567890123456789e5)
>> |123456.79|


```