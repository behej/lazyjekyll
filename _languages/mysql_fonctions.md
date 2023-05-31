---
title: MySQL - Fonctions
layout: default
icon: mysql.png
---
# Fonctions mathématiques

| Fonction | Description |
|----------|-------------|
| CEIL(*n*) | Arrondi la valeur *n* à l'entier supérieur |
| FLOOR(*n*) | Arrondi la valeur *n* à l'entier inférieur |
| ROUND(*n*, [*d*]) | Arrondi la valeur *n* à *d* décimale. Si omis, arrondi à l'entier |
| TRUNCATE(*n*, *d*) | Tronque la valeur *n* à *d* décimales |
| POW(*x, y*) | x^y |
| SQRT() | Racine carrée |
| RAND() | Génère un nombre aléatoire en 0 et 1 |
| SIGN(*n*) | Renvoie le signe de *n*. Renvoie -1, 0 ou +1 |
| MOD(x, y) | Renvoie le reste de la division x/y. Equivalent à "x MOD y" ou "x % y". |
| ABS() | Valeur absolue |

# Manipulation de chaînes de caractères

| Fonction | Description |
|----------|-------------|
| LENGTH(s) | Renvoie le nombre d'octets occupés en mémoire par la chaîne *s* |
| BIT_LENGTH(s) | Renvoie le nombre de bits occupés en mémoire par la chaîne *s*. Equivalent à LENGTH * 8 |
| CHAR_LENGTH(s) | Renvoie le nombre de caractères de la chaîne *s* |
| STRCMP(s1, s2) | Compare 2 chaînes de caractères. Renvoie -1 si s1\<s2 / renvoie 0 si s1=s2 / renvoie +1 si s1\>s2. |
| REPEAT(s, n) | Répète *n* fois la chaînes *s* |
| RPAD(s, n, c) | Ajuste la taille de la chaîne *s* à *n* caractères.
Supprime les caractères en trop à droite si besoin de réduire. Ajoute autant de caractères *c* que nécessaire à droite si besoin d'agrandir. |
| LPAD(s, n, c) | Idem RPAD mais les caractères ajoutés sont placés à gauche. Les caractères supprimés sont toujours supprimés à droite. |
| TRIM([[BOTH \| LEADING \| TRAILING] [c] FROM] texte | Supprime les caractères inutiles au début et/ou à la fin d'une chaine. LEADING: supprime au début / TRAILING: supprime à la fin / BOTH: les 2 / BOTH par défaut si omis. **c** : caractère (ou chaine) à supprimer. *espace*  par défaut si omis |
| SUBSTRING(s, pos [, long]) | Sélectionne une partie de la chaîne *s*. Sélectionne *long* caractères à partir du caractère en position *pos*. Syntaxe alternative: SUBSTRING(*s* FROM *pos* [FOR *long*]) |
| INSTR(t, s) | Renvoie la position de la 1ère occurrence de la chaine *s* dans la chaîne *t*. 0 si chaine non trouvée. |
| LOCATE(s, t [, p]) | Renvoie la position de la 1ère occurrence de la chaine *s* dans la chaîne *t* à partir de la position *p* |
| POSITION(*s* IN *t*) | Idem INSTR (syntaxe différente) |
| LOWER(s) | Met toutes les lettres en minuscules |
| LCASE(s) | Met toutes les lettres en minuscules |
| UPPER(s) | Met toutes les lettres en minuscules |
| UCASE(s) | Met toutes les lettres en minuscules |
| LEFT(s, n) | Renvoie les *n* caractères de gauche de la chaîne *s* |
| RIGHT(s, n) | Renvoie les *n* caractères de droite de la chaîne *s* |
| REVERSE(s) | Inverse la chaine de caractères *s* |
| INSERT(t, p, l, s) | Supprime *l* caractères de la chaine *t* à partir du caractère *p*. Insère la chaine *s* à la place. |
| REPLACE(t, c_old, c_new) | Remplace tous les caractères (ou chaines) *c_old* par *c_new* dans la chaine *t* |
| CONCAT(s1, s2, ... , Sn) | Concatène les chaînes s1 à Sn) |
| CONCAT_WS(sep, s1, s2, ..., Sn) | Concatène les chaînes s1 à Sn en insérant à chaque fois la chaîne *sep* |
| FIELD(rech, s1, s2, ..., Sn) | Recherche la chaine *rech* parmi les chaines s1 à Sn et renvoie la position de la chaine correspondante. Renvoi 0 si *rech* non trouvé. Utile pour trier les résultats d'un recherche |
| ASCII(c) | Renvoie le code ascii du caractère *c*. Si *c* est une chaine, renvoie le code ascii du premier caractère |
| CHAR(n) | Renvoie le caractère correspondant au code ascii *n*. Syntaxe possible: CHAR(n1, n2, ...) |

# Fonctions sur les dates
## Date actuelle

| Fonction | Description |
|----------|-------------|
| CURDATE() | Retourne la date du jour |
|CURRENT_DATE() | Retourne la date du jour |
| CURTIME() | Retourne l'heure actuelle |
| CURRENT_TIME() | Retourne l'heure actuelle |
| NOW() | Retourne la date et l'heure actuelles |
| SYSDATE() | Retourne la date et l'heure actuelles |
| CURRENT_TIMESTAMP() | Retourne la date et l'heure actuelles |
| LOCALTIME() | Retourne la date et l'heure actuelles |
| LOCALTIMESTAMP() | Retourne la date et l'heure actuelles |
| UNIX_TIMESTAMP() | Retourne le timestamp actuel (le nombre de secondes écoulées depuis le 1er janvier 1970) |

### Extraction

| Fonction | Description |
|----------|-------------|
| DATE(datetime) | Extrait la date uniquement |
| DAYOFYEAR(date) | Retourne le jour de l'année (entier de 1 à 366) |
| DAY(datetime) | Retourne le jour du mois (entier de 1 à 31) |
| DAYOFMONTH(datetime) | Retourne le jour du mois (entier de 1 à 31) |
| DAYOFWEEK(date) | Retourne le jour de la semaine. Entier de 1 à 7 avec dimanche = 1 |
| WEEKDAY(date) | Retourne le jour de la semaine. Entier de 0 à 6 avec lundi = 0. |
| DAYNAME(date) | Retourne le nom du jour (Monday, Tuesday, ...) |
| SET lc_time_names = 'fr_FR' *puis* DAYNAME | Indique les nom des jour en français |
| WEEK() | Renvoie le numéro de la semaine (de 0 à 52) |
| WEEKOFYEAR() | Renvoie le numéro de la semaine (de 1 à 53) |
| YEARWEEK() | Renvoie l'année et le numéro de la semaine (de 0 à 52). Ex: 201349. **Attention:** les jours de la semaine 0 apparaissent comme appartenant à la semaine 53 de l'année précédente. |
| MONTH() | Renvoie le numéro du mois (de 1 à 12) |
| MONTHNAME() | Renvoie le nom du mois |
| LAST_DAY(date) | Renvoie la date du dernier jour du mois passé en paramètre |
| YEAR() | Extrait l'année d'une date |
| TIME() | Extrait l'heure complète (hh:mm:ss) |
| HOUR() | Extrait l'heure uniquement |
| MINUTE() | Extrait uniquement les minutes |
| SECOND() | Extrait uniquement les secondes |

# Opérations

| Fonction | Description |
|----------|-------------|
| DATEDIFF(date1, date2) | calcul la différence entre 2 dates. Le résultat est exprimé en jours. date1 et date2 peuvent être indifféremment de type date ou datetime. Seule la date est utilisée |
| TIMEDIFF(time1, time2) | Calcule la différence entre *time1* et *time2*. Le résultat est exprimé en hh:mm:ss. *time1* et *time2* peuvent être de type *datetime* ou *time* mais doivent être de même type.  |
| TIMESTAMPDIFF(unité, datetime1, datetime2) | Calcule la différence entre *datetime1* et *datetime2*. Le résultat est exprimé selon le paramètre *unité*. *unité* peut valoir: SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER, YEAR |
| ADDDATE(datetime, n) | Ajoute *n* jours à *datetime* |
| ADDDATE(datetime, INTERVAL qté unité) | Ajoute une durée correspondant à *qté* à *datetime*. *Unité* peut être un nombre de secondes, minutes, heures, jours, etc. (SECOND, MINUTE, HOUR, DAY, etc.). Dans ce cas, qté s'exprime avec un entier. *Unité* peut être formaté selon une chaine (ex: HOUR_SECOND - hh:mm:ss, MONTH_MINUTE - MM/DD hh:mm, etc.). Dans ce cas, qté est une chaîne de caractères. |
| DATE_ADD(datetime, INTERVAL qté unité) | idem ADDDATE mais uniquement avec l'option INTERVAL |
| TIMESTAMPADD(unité, n, datetime) | Ajoute *n unités* à *datetime* |
| ADDTIME(datetime1, time2) | Ajoute *time2* à *datetime1*. *datetime1* peut être de type *datetime* ou *time*. *time2* est de type *time*. Le résultat est du même type que *datetime1* |
| SUBDATE | idem ADDDATE mais pour la soustraction |
| DATE_SUB | idem DATE_ADD mais pour la soustraction |
| SUBTIME | idem ADDTIME mais pour la soustraction |


## Conversion

| Fonction | Description |
|----------|-------------|
| UNIX_TIMESTAMP(datetime) | Convertit la donnée datetime en timestamp Unix |
| DATE_FORMAT(date, format) | Convertit la date selon le format désiré. *format* est la chaîne de caractères que l'on souhaite afficher avec des spécificateurs pour indiquer les éléments issus de la date. cf. [Spécificateurs](#spécificateurs-de-date). Pour le paramètre *format*, on peut également utiliser des formats pré-définis avec la fonction GET_FORMAT |
| TIME_FORMAT() | idem DATE_FORMAT mais uniquement pour les heures. Le paramètre donné doit donc être de type datetime ou time) |
| GET_FORMAT(type, standard) | Retourne des chaînes pré-formatées à utiliser avec les fonctions DATE_FORMAT et TIME_FORMAT. type = DATE, TIME ou DATETIME. standard = 'EUR', 'USA', 'JIS', 'ISO' ou 'INTERNAL' |
| STR_TO_DATE(str, format) | Extrait les éléments de date et d'heure de la chaîne *str* selon la description effectuée dans *format*. |
| FROM_UNIXTIME(ts) | Convertit le timestamp Unix *ts* en format *datetime* |
| MAKEDATE(année, n) | Crée une date correspondant au n-ième jour de l'année |
| MAKETIME(h, m, s) | Crée une heure à partir des nombres *h*, *m* et *s* correspondant respectivement aux heures, minutes et secondes. |
| SEC_TO_TIME(n) | Convertit un nombre de secondes en format *time* |
| TIME_TO_SEC(time) | Convertit une heure en nombre de secondes |

### Spécificateurs de date

| Spécificateur | Signification |
|---------------|---------------|
| %d | Jour du mois (nombre à deux chiffres, de 00 à 31) |
| %e | Jour du mois (nombre à un ou deux chiffres, de 0 à 31) |
| %D | Jour du mois, avec suffixe (1rst, 2nd,…, 31th) en anglais |
| %w | Numéro du jour de la semaine (dimanche = 0,…, samedi = 6) |
| %W | Nom du jour de la semaine |
| %a | Nom du jour de la semaine en abrégé |
| %m | Mois (nombre de deux chiffres, de 00 à 12) |
| %c | Mois (nombre de un ou deux chiffres, de 0 à 12) |
| %M | Nom du mois |
| %b | Nom du mois en abrégé |
| %y | Année, sur deux chiffres |
| %Y | Année, sur quatre chiffres |
| %r | Heure complète, format 12h (hh:mm:ss AM/PM) |
| %T | Heure complète, format 24h (hh:mm:ss) |
| %h | Heure sur deux chiffres et sur 12 heures (de 00 à 12) |
| %H | Heure sur deux chiffres et sur 24 heures (de 00 à 23) |
| %l | Heure sur un ou deux chiffres et sur 12 heures (de 0 à 12) |
| %k | Heure sur un ou deux chiffres et sur 24 heures (de 0 à 23) |
| %i | Minutes (de 00 à 59) |
| %s ou %S | Secondes (de 00 à 59) |
| %p | AM/PM |


# Fonctions d'agrégation

| Fonction | Description |
|----------|-------------|
| COUNT() | Compte le nombre de lignes renvoyées par la requête. `COUNT(*)`: Renvoi le nombre total de lignes. `COUNT(colonne)`: Renvoi le nom de lignes dont la colonne spécifiée est non nulle. `COUNT(DISTINCT colonne)`: Sans les doublons |
| MIN(col) | Renvoi la valeur minimum d'une colonne  |
| MAX(col) | Renvoi la valeur maximum d'une colonne |
| SUM(col) | Renvoi la somme des valeurs d'une colonne |
| AVG(col) | Renvoi la moyenne des valeurs d'une colonne |
| GROUP_CONCAT([DISTINCT] *col1* [, *col2*, ...][ORDER BY *col* [ASC\|DESC]] [SEPARATOR c]) | Concatène toutes les valeurs d'une colonne. DISCTINCT: supprime les doublons. ORDER BY: ordre dans lequel concaténer les données. SEPARATOR: indique la chaîne à inséré entre chaque valeur. caractère virgule par défaut. |

# Regroupements
## Regroupement simple
```sql
SELECT [COUNT()]
FROM ... WHERE ...
GROUP BY critère [ASC|DESC]
```

Cette fonction regroupe toutes les lignes ayant le même critère ensemble. L'instruction COUNT renvoi le nom de lignes regroupées pour chaque valeur du critère

> ⚠️ **Attention:** la clause SELECT ne peut afficher que le critère ou une fonction d'agrégation. Si on veut afficher une autre colonne, ajouter les colonnes dans le **GROUP BY** (il faut quand même que les colonnes aient du sens).



Par défaut, les données sont triées selon le critère de regroupement. On peut préciser le sens du tri avec les options ASC et DESC.

Si l'option ORDER BY est utilisée, celle-ci est prioritaire sur le tri du critère de regroupement.

> ✏️ **Note:** Si utilisation d'une jointure externe (pour obtenir une jointure avec des champs NULL), le comptage réalisé avec COUNT(\*) renverra au moins une ligne même en cas de NULL. Penser à regrouper sur un critère et non sur \*.

## Regroupement multiple
Lors d'un regroupement, on peut spécifier plusieurs critères.
* Soit les critères supplémentaires sont équivalents au premier et ne servent qu'à permettre d'afficher ces colonnes.
* Soit les critères supplémentaires sont totalement différents et ajoutent autant de regroupements. Dans ce cas, toutes les combinaisons possibles sont affichées.

```sql
SELECT ...
FROM ... WHERE ...
GROUP BY col1, col2 ...;
```

L'ordre de définition des critères est important.


## Super-Agrégats
```sql
SELECT COUNT()
FROM ... WHERE ...
GROUP BY col1, col2 ... WITH ROLLUP;
```


L'option `WITH ROLLUP` ajoute une ligne à la fin de chaque regroupement qui contient le nombre total de chaque regroupement.

| | |
|-|-|
| ligne1 | 10 |
| ligne2 | 9  |
| NULL   | 19 |



Pour éviter l'affichage de `NULL`, on peut utiliser la commande `COALESCE` (voir [Fonctions diverses](#fonctions-diverses).
```sql
SELECT COALESCE(col1, Total), COUNT(*)
FROM ... WHERE ...
GROUP BY col1 ... WITH ROLLUP;
```

# Conditions sur les regroupements 
La clause `WHERE` ne peut pas être utilisée sur une fonction d'agrégation. Il faut utiliser la clause `HAVING`.
```sql
SELECT ...
FROM ... WHERE ...
GROUP BY col1, col2 ... 
HAVING condition;
```

**Exemple:** N'afficher que les groupes qui contiennent au moins *n* éléments.
```sql
SELECT COUNT(*) AS nombre
FROM ... WHERE ...
GROUP BY col1, col2 ... 
HAVING nombre>n;
```

> ✏️ **Note:** il est possible de cumuler les clauses `WHERE` et `HAVING`.

# Fonctions diverses

| Fonction | Description |
|----------|-------------|
| VERSION() | Renvoie la version de MySQL |
| USER() | Renvoie l’utilisateur connecté |
| CURRENT_USER() | Renvoie l’utilisateur connecté (un peu différent de USER() |
| LAST_INSERT_ID() | Renvoie l'id utilisé par auto-incrémentation lors de la dernière requête d'insertion |
| FOUND_ROWS() | Nombre de lignes retournées par la dernière requête. Si l'option SQL_CALC_FOUND_ROWS est ajouté juste après le SELECT, cette fonction renvoie le nombre total de lignes retournées même en cas de LIMIT |
| CAST() | Convertit une donnée. **CAST**(*valeur* **AS** *type*) |
| COALESCE(val1, val2, ...) | Renvoie la première valeur non nulle |
