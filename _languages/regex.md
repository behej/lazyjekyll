---
title: Expressions régulières
layout: default
icon: regex.png
---
**grep:** commande de base qui renvoie toutes les lignes contenant la chaine recherchée
* *grep*: **G**lobally **R**egular **E**xpression **P**rint

`grep 'maChaine' fichier.txt`

Renvoie toute les lignes de **fichier.txt** qui contiennent *maChaine*

**Attention:** grep est *case sensitive* par défaut.

# Options de recherche

| Syntaxe | Comportement |
| --- |---|
|`^maChaine` |	la ligne doit COMMENCER par "maChaine" |
| `maChaine$` |	la ligne doit se TERMINER par "maChaine" |
| `chaine1\|chaine2` |	la ligne doit contenir "chaine1" OU "chaine2" --> **Attention:** nécessite l'option -E de grep |
| `gr[io]s` |	les caractères i OU o sont autorisés au milieu de la chaine. **Exemple:** "gris" et "gros" seront renvoyés mais pas "gras" |
| `gr[a-i]s` |	les caractères de 'a' à 'i' sont autorisés |
| `gr[a-iu-z]s` | les caractères de 'a' à 'i' ET de 'u' à 'z' sont autorisés |
| `gr[^aeu]s` |	les caractères 'a', 'e' et 'u' **NE SONT PAS** autorisés au milieu de la chaine |
| `e?` | le caractère avant le '?' est facultatif (0 ou 1 occurence du caractère). **Exemple:** 'chiens?' renvoit "chien" et "chiens" |
| `e+` |	le caractère avant le '+' peut apparaitre 1 ou plusieurs fois (mais pas 0). **Exemple:** 'Yahoo+' renvoit "Yahoo", "Yahooo", "Yahoooo" etc. |
| `e*` |	le caractère avant le '*' est facultatif, il peut apparaitre 0 ou *n* fois. |
| `(er)?` |	le symbole '?', '+' ou '*' s'applique aux lettres entre paranthèses |
| `[ae]?`	| le symbole '?', '+' ou '*' s'applique au [] |
| `e{3}`	| le caractère 'e' doit être présent 3 fois de suite exactement |
| `e{3,5}`	| le caractère 'e' doit être présent de 3 à 5 fois |
| `e{3,}`	| le caractère 'e' doit être présent 3 fois ou plus |
| `\` | Caractère d'échappement: permet de rechercher un caractère spécial en tant que caractère et non en tant qu'option de recherche. **Attention:** pas besoin de caractère d'échappement au sein d'une classe [] sauf pour `#`, `]` et `-`

# Classes Spéciales (ne fonctionne pas avec ttes les commandes)

|Classe|Equivalent|Description|
|---|---|---|
| \d | [0-9] | indique un chiffre |
| \D | [^0-9] | indique que ce n'est **PAS** un chiffre |
| \w | [a-zA-Z0-9_] | indique un caractère alphanumérique ou '_' |
| \W | [^a-zA-Z0-9_] | indique que ce n'est PAS un caractère alphanumérique ni '_' |
| \s | | indique un espace blanc |
| \S | | indique que ce n'est PAS un espace blanc |
|	 | . | indique n'importe quel caractère |

# Options de GREP

* grep -i : ignore la casse
* grep -E : nécessaire pour les regex étendues (notamment le 'OU')
