---
title: MySQL - Requêtes
layout: default
icon: mysql.png
---
# Sélection de données

* **SELECT** \* **FROM** *table*;
* **SELECT** *colonne1, colonne2* **FROM** *table*;
* **SELECT** \* **FROM** *table* **WHERE** *colonne* = *valeur*;
* **SELECT** \* **FROM** *table* **WHERE** *colonne* **IS NULL**;
* **SELECT** \* **FROM** *table* **WHERE** *colonne* **<=> NULL**;
* **SELECT** \* **FROM** *table* **WHERE** *colonne* **IS NOT NULL**;

## Les opérateurs

| Opérateur | Signification |
|-----------|---------------|
| = | égal |
| < | inférieur |
| <= | inférieur ou égal |
| > | supérieur |
| >= | supérieur ou égal |
| <> ou != | différent |
| <=> | égal (valable pour NULL aussi) |


Les conditions peuvent être combinées avec les opérateurs suivants:

| Syntaxe | Syntaxe alt | signification |
|---------|-------------|---------------|
| AND | && | ET |
| OR | \|\| | OU |
| XOR  | | OU exclusif |
| NOT | ! | NON |

## Options de mise en forme de la sortie
* **SELECT \* FROM** *table* **ORDER BY** *colonne* \[**ASC**\]; tri par ordre croissant si rien n'est précisé
* **SELECT \* FROM** *table* **ORDER BY** *colonne* **DESC**;
* **SELECT \* FROM** *table* **ORDER BY** *colonne1, colonne2*; tri sur la 1ère colonne puis sur la seconde


* **SELECT DISTINCT** *colonne* **FROM** *table*; Evite les doublons
* **SELECT \* FROM** *table* **LIMIT** *nbMaxDeLignes* [**OFFSET** *décalage*]; Limite le nb de résultats. Si offset, les premières lignes sont ignorées.
* syntaxe alternative propre à MySQL: **SELECT \* FROM** *table* **LIMIT** [*offset*,] *nbMaxDeLignes*;

## Options de recherche
* **SELECT \* FROM** *table* **WHERE** *colonne* **LIKE** *j%*; Recherche toutes les chaînes commencant par *j*, suivies d'une chaîne de caractères (y compris aucun caractère)
* **SELECT \* FROM** *table* **WHERE** *colonne* **LIKE** *j_*; Recherche toutes les chaînes commencant par *j*, suivies de 0 ou 1 caractère
* **SELECT \* FROM** *table* **WHERE** *colonne* **LIKE** *%\%*; Recherche les chaînes se terminant par le caractère `%` (il faut l'échapper. Idem pour le caractère `_`)
* **SELECT \* FROM** *table* **WHERE** *colonne* **NOT LIKE* *j%*; Recherche les chaînes ne commencant pas par *j*
* **SELECT \* FROM** *table* **WHERE** *colonne* **LIKE BINARY** *j%*; Sensible à la casse
  * **Spécificité MySQL:** On peut utiliser la commande LIKE sur des champs de type numérique. Ce qui n'est pas possible en SQL pur.
* **SELECT \* FROM** *table* **WHERE** *colonne* **BETWEEN** *x* **AND** *y*; Recherche les valeurs se trouvant dans l'intervalle [x ; y]
* **SELECT \* FROM** *table* **WHERE** *colonne* **NOT BETWEEN** *x* **AND** *y*;
  * valable aussi pour les chaînes de caractères (ordre alphabétique utilisé)
* **SELECT \* FROM** *table* **WHERE** *colonne* **IN** (*valeur1, valeur2, valeur3*); Recherche les valeurs égales à une des valeurs listées


# Alias
Permet de nommer un élément de la requête.

```sql
SELECT élément AS alias;
```

* Permet de nommer un élément récurrent afin de raccourcir la syntaxe
* Obligatoire lorsqu'on fait une jointure de 2 occurrences de la même table. Cela permet d'identifier clairement si on fait référence à la première occurrence ou à la seconde.


# Jointures
## Jointures internes
Sert à unir 2 ou plusieurs tables afin d'étendre les recherches.

''Interne'' car la jointure s'effectue uniquement si les données des '''deux''' côtés correspondent.

```sql
SELECT Table.colonne
FROM Table1 INNER JOIN Table2
ON Table1.colonne = Table2.colonne
WHERE Table.colonne = cirtères;
```



**Notes:**
* le critère de jointure doit correspondre dans les 2 tables
* On peut joindre 2 tables sur plusieurs critères. On utilise alors les opérateurs logiques standard (OR, AND, etc.)
* S'il n'y a pas d'ambiguité sur le nom de la colonne, on n'est pas obligé de préciser le nom de la table.
* Si les colonnes utilisées pour la jointure ont le **même nom** dans les 2 tables, on peut remplacer la ligne "**ON** *Table1.col=Table2.col*" par "**USING** *colonne*"


**Utilisation des alias:**
```sql
SELECT T1.colonne
FROM Table1 AS T1 INNER JOIN Table2 AS T2
ON T1.col = T2.col
WHERE T1.col = valeur;

SELECT Table1.colonne AS Col
FROM Table1 INNER JOIN Table2
ON T1.col = T2.col
WHERE Col = valeur;
```

## Jointures externes
Idem que les jointures internes mais la jointure est également effectuée si une donnée n'a pas de correspondance dans l'autre table.

```sql
SELECT *
FROM Table1 LEFT/RIGHT [OUTER] JOIN Table2
ON Table1.colonne = Table2.colonne
WHERE ...;
```


* Renvoie toutes les lignes où la colonne de la table1 = la colonne de la table2 et toutes les lignes où la colonne de la table 1 n'a pas été trouvée dans la colonne de la table 2.
* LEFT: renvoie les colonnes sans correspondances de la table1
* RIGHT: renvoie les colonnes sans correspondances de la table2


## Jointures naturelles
```sql
SELECT *
FROM Table1 NATURAL JOIN Table2
WHERE ...;
```


* La clause de jointure est déterminée automatiquement
* Valable uniquement si les colonnes utilisées pour la jointure ont le **même nom**
* Si plusieurs colonnes peuvent être utilisées pour la jointure, elles sont toutes utilisées avec la combinaison **AND**


# Sous-requêtes
Une requête renvoie ses résultats sous forme d'une table. Partant de là, il est tout à fait possible d'utiliser cette table au sein d'une autre requête (dans le FROM ou dans une condition par exemple). On aura ainsi 2 requêtes imbriquées.

* Une sous-requête doit impérativement être délimitée pas des paranthèses
* Un alias soit impérativement défini sur la sous-requête
* Il faut s'assurer de la cohérence des colonnes entre la requête principal et la sous-requête
* Une sous-requête renvoie les résultat sous forme de table. Plusieurs configurations possibles:
  * Plusieurs colonnes et plusieurs lignes
  * Plusieurs colonnes mais une seule ligne
  * Une seule colonne mais plusieurs lignes
  * Une seule colonne et une seule ligne --> un seule valeur


## Plusieurs colonnes, plusieurs lignes
Ces sous-requêtes peuvent uniquement s'utiliser dans un FROM.
> ✏️ Note: Ces cas incluent également les cas comprenant une ligne et/ou une colonne.


## Plusieurs colonnes, une seule ligne
Ce cas s'utilise dans les conditions WHERE mais uniquement avec les opérateurs = ou != (ou <>)
```sql
...
WHERE (colonne1, colonne2) = 
   (SELECT colonneX, colonneY
   FROM table
   WHERE conditions
   );
```

> ⚠️ **Attention:*** *colonne1* et *colonneX* ne doivent pas forcément avoir une correspondance logique. Seul le type doit concorder.

## Une seule colonne, plusieurs lignes
Ce cas s'utilise dans les conditions WHERE avec les opérateurs IN,  NOT IN, ALL, ANY et SOME


### IN & NOT IN
Toutes les lignes du résultat de la sous-requête sont utilisées comme liste de valeurs servant aux opérateurs IN et NOT IN
```sql
...
WHERE colonne1 IN
   (SELECT colonneX
   FROM table
   WHERE conditions
   )
```

### ANY/SOME & ALL 
Les lignes du résultat de la sous-requête sont utilisées comme liste de valeurs servant aux opérateurs ANY/SOME et ALL. Ces opérateurs s'utilisent avec les opérateurs mathématiques =, !=, <, <=, >, >=.
* < ANY : inférieur à au moins l'une des valeurs de la liste
* < SOME : idem ANY
* < ALL : inférieur à toutes les valeurs de la liste


**Exemple:**
```sql
...
WHERE colonne1 < ANY
   (SELECT colonneX
   FROM table
   WHERE conditions
   );
```

**Notes:**
* ANY et SOME sont identiques
* ANY, SOME et ALL ne s'utilisent que sur des sous-requêtes
* = ANY est équivalent à IN
* != ALL est équivalent à NOT IN


## Une seule valeur 
Ce cas s'utilise dans les conditions WHERE avec n'importe quel opérateur (=, !=, <, >, etc.)

# Sous-requêtes corrélées
Une sous requête corrélée est une sous-requête qui utilise une colonne de la requête principale.
```sql
SELECT *
FROM tableA
WHERE colonne1 IN
   (SELECT *
   FROM tableB''
   WHERE tableB.colonne = tableA.colonne     -- la table A est utilisée dans la sous-requête même si elle ne fait pas partie de la sous-requête
   )
```


* une sous-requête ne peut être corrélée qu'à une table d'une requête amont (ie. une sous-requête ne pourra pas faire référence à une table d'une autre sous-requête)
* une sous-requête corrélée peut s'utiliser avec les opérateurs EXISTS et NOT EXISTS

# Union
L'union permet de concaténer les résultats de plusieurs requêtes.

```sql
SELECT ...
UNION
SELECT ...
```


* Les 2 requêtes doivent impérativement renvoyer le même nom de colonnes.
* MySQL est plutôt permissif et autorise l'union même si les types renvoyés par les 2 requêtes ne sont pas identiques.
* La commande UNION supprime les doublons.
* Pour ne pas effacer les doublons, il faut utiliser la commande **UNION ALL**
* Il n'est pas possible de mixer les UNION et les UNION ALL. Si tel est le cas, toutes les unions seront considérées comme UNION simples
* L'option LIMIT peut s'appliquer soit à une seule requête particulière, soit au résultat de l'union. Utiliser des parenthèses pour affecter l'union à la requête souhaitée.
* L'option ORDER BY ne peut s'applique qu'au résultat de l'union. Le critère utilisé doit correspondre aux colonnes de la 1ère requête.
* L'option ORDER BY peut s'appliquer à une sous-requête mais doit être impérativement combinée à l'option LIMIT.
