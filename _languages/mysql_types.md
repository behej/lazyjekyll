---
title: MySQL - Types
layout: default
icon: mysql.png
---
# Numériques
## INT

| Type | Nombre de valeurs | Nombre de valeurs |
|-----|-----------------|----------------|
|TINYINT |2^8 |256 |
|SMALLINT |2^16 |65536 |
|MEDIUMINT |2^24 |16 777 216 |
|INT |2^32 |4 294 967 296 |
|BIGINT |2^64 |18 446 744 073 709 551 616 |

### Options
* UNSIGNED
* INT(x) ZEROFILL: si le chiffre fait moins de *x* digits, l'affichage est complété avec des 0. Pas d'impact si le nombre fait *x* digits ou plus.


## NUMERIC & DECIMAL
Les formats NUMERIC et DECIMAL stockent des nombres sous forme de chaîne de caractères.
* NUMERIC(x, y): **x** nombre total de chiffres et **y** chiffres après la virgule.
* DECIMAL: *idem*

### Exemple

|Déclaration | valeur mini | valeur maxi |
|------------|-------------|-------------|
| NUMERIC(5,3) | -99.999 | 99.999 |

### Spécificité MySQL
L'octet utilisé pour le signe, peut être utilisé pour stocker un digit supplémentaire dans le cas des nombres positifs.

|Déclaration | valeur mini | valeur maxi |
|------------|-------------|-------------|
| NUMERIC(5,3) | -99.999 | **9**99.999 |

## FLOAT, DOUBLE & REAL

| Type | Nombre d'octets | Commentaire |
|------|------------------|------------|
| FLOAT | 4 | Accepte des paramètres de précision |
| DOUBLE | 8 | |
| REAL | 4 | Spécificité MySQL: 8 octets sont utilisés |

> ⚠️ **Attention:** Etant donné que ce sont des valeurs numériques réelles, il peux y avoir des problèmes d'imprécision. En cas de besoin accru de précision on utilisera les formats DECIMAL et NUMERIC


# Alphanumériques
## CHAR & VARCHAR

Pour les chaînes de caractères de maximum 255 caractères:

| Type | Description | Mémoire utilisée |
|------|-------------|------------------|
| CHAR(*x*) | Stocke **x** caractères | **x** octets |
| VARCHAR(*x*) | Stocke jusqu'à **x** caractères | 1 octet par caractère de la chaîne (maxi **x**) + 1 octet utilisé pour mémorisé la taille de la chaîne |

> ✏️ **Note:** Si on stocke uniquement des chaînes de **x** caractères, il est plus intéressant d'utiliser le type CHAR (on économise l'octet qui sert à mémoriser la taille). Au contraire, si on stocke des chaînes de taille variable, il est plus intéressant d'utiliser VARCHAR (on n'utilise pas systématiquement les **x** octets)

## TEXT
Plus de 255 caractères

| Type | Nombre de caractères |
|------|----------------------|
| TINYTEXT | 2^8 |
| TEXT | 2^16 |
| MEDIUMTEXT | 2^24 |
| LONGTEXT | 2^32 |

## BINARY
Similaire aux types CHAR et TEXT mais permet de traiter des octets bruts (ie. sans interprétation en tant que caractère). Utile pour stocker des données brutes, comme des fichiers.

| Type| Nombre d'octets stockés| Type référent |
|-----|------------------------|---------------|
| BINARY(x) | x octets (maxi 255) | CHAR(x) |
| VARBINARY(x) | x octets (maxi 255) | VARCHAR(x) |
| TINYBLOB | 2^8 | TINYTEXT |
| BLOB | 2^16 | TEXT |
| MEDIUMBLOB | 2^24 | MEDIUMTEXT |
| LONGBLOB | 2^32 | LONGTEXT |

## SET & ENUM
> ⚠️ **Important:** SET et ENUM sont des types propres à MySQL.

### ENUM
```sql
ENUM('valeur1' , 'valeur2' , 'valeur3' , ...)
```

* la cellule peut prendre soit directement une valeur énumérée (ex: 'valeur1')
* soit l'index de la valeur (0="" ; 1="valeur1" ; ...)
* maxi 65535 valeurs

### SET
```sql
SET('valeur1' , 'valeur2' , 'valeur3' , ...)
```

* la cellule peut accepter 0 ou **n** valeurs ("valeur1" et "valeur3")
* la valeur numérique stockées comprend 1 bit par valeur énumérée
* chaque bit est positionné selon la présence de la valeur dans la cellule
* exemple: "valeur1" ; "valeur2" --> 011


# Temporel
## DATE
```sql
[YY]YY MM DD
```

* [YY]YY : l'année: sur 2 ou 4 chiffres
  * sur 2 chiffres: de 1970 à 2069
  * sur 4 chiffres: de 1001 à 9999
* MM : le mois
* DD : le jour
* caractère de séparation: ***rien***, ***espace*** ou n'importe quel caractère

### Exemples
* 1982-09-07 : format standard
* 82-09-07
* 1982.09.07
* 82%09%07
* '19820907'
* 19820907 (⚠️ attention, ce format est stocké sous forme de nombre et non sous forme de chaîne de caractères)

## TIME
Permet de stocker une heure mais également un intervalle de temps.

Peut aussi être négatif.

```sql
[D] HH:MM:SS
```

* [D] : nombres de jours (facultatif). Doit impérativement être suivi d'un espace.
* HH : heure (peut être supérieur à 24 dans le cas d'un intervalle de temps)
* MM : minutes
* SS : secondes
* heures, minutes et secondes doivent être séparés par `:`
* de -838:59:59 à 838:59:59

## DATETIME
```sql
[YY]YY MM DD HH mm ss
```

* [YY]YY : l'année: sur 2 ou 4 chiffres
  * sur 2 chiffres: de 1970 à 2069
  * sur 4 chiffres: de 1001 à 9999
* MM : le mois
* DD : le jour
* HH : l'heure
* mm : les minutes
* ss : les secondes
* caractère de séparation entre la date et l'heure: ***espace*** obligatoire
* caractère de séparation: ***rien***, ***espace*** ou n'importe quel caractère

### Exemples
* 1982-09-07 01-50-25: format standard
* 82-09-07 01:50:25
* 1982.09.07 01*50*25
* 19820907015025 (attention, ce format est stocké sous forme de nombre et non sous forme de chaîne de caractères)
  * dans ce cas particulier, il ne faut pas mettre d'espace entre la date et l'heure

## YEAR
Permet de stocker uniquement une année.

* 2 ou 4 chiffres
  * 2 chiffres: de 1970 à 2069
  * 4 chiffres: de 1901 à 9999
* format numérique ou chaîne de caractères


## TIMESTAMP
* Nombre de secondes écoulées depuis le 1er janvier 1970 à 00h00min00s
* stocké sur 4 octets
* valeur maxi : 2^32, soit le 19 janvier 2038 à 3h14min7s

### ⚠️ **ATTENTION** : SPECIFICITE MySQL

MySQL stocke les timestamps à la manières de datetime au format numérique.

Ainsi, le 09/07/1982 à 1h50min25s sera stocké : 19820907015025

Mais MySQL conserve les mêmes valeurs mini/maxi que le timestamp officiel.
