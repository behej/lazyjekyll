---
title: MySQL - Gestion de base/table
layout: default
icon: mysql.png
---
# Connexion

mysql -u *username* -h *host_address* -p
* ne pas indiquer le password ds la ligne de commande, il sera demandé ultérieurement et masqué
Options supplémentaires:
* -P \<port_number\> ou --port=\<port_number\> : spécifie le port de connexion

# Gestion des droits
## Création/Suppression des utilisateurs
* Création d'un utilisateur
```sql
CREATE USER username@host IDENTIFIED BY password';
```

  * Les simple quotes sont obligatoires
  * host indique le PC duquel l'utilisateur peut se connecter
  * host = localhost pour un utilisateur local (ie il n'aura pas le droit de se connecter en remote)
  * host = % pour pouvoir se connecter de n'importe quel host
* Suppression d'un utilisateur
```sql
DROP USER username@host;
```

✏️ **Note:**
* Les utilisateurs sont enregistrés dans une table système : la table **mysql.user**
```sql
SELECT user, host FROM mysql.user;
```

## Attribution des droits
* Attribution des droits à un utilisateur déjà créé: `GRANT ALL PRIVILEGES ON base.table TO  username @ host`
  * ALL PRIVILEGES \| SELECT \| INSERT \| UPDATE \| DELETE \| DROP \| ALTER \| GRANT 
* Attribution des droits à un nouvel utilisateur:  `GRANT ALL PRIVILEGES ON base.table TO  username @ host IDENTIFIED BY password;`
  * L'utilisateur spécifié est automatiquement créé avec le mot de passe indiqué
* Afficher les droits d'un utilisateur: `SHOW GRANTS FOR <user>;`
* Retirer les droits d'un utilisateur: `REVOKE ALL ON <base>.<table> FOR <user>@<host>;`

# Gestion d'une base
* SHOW DATABASES : Affiche toutes les bases disponibles

* CREATE DATABASE nomDeLaBase;
  * CREATE DATABASE nomDeLaBase CHARACTER SET 'utf8';
* DROP DATABASE nomDeLaBase;	(requiert que la base existe)
* DROP DATABASE IF EXISTS nomDeLaBase;	efface la base si elle existe, rien sinon
* SHOW WARNINGS;	affiche les warnings
* USE nomDeLaBase;	définit la base à utiliser pour la suite des opérations


## Sauvegarde d'une base
* `mysqldump -u user -p --opt nomDeLaBase > fichierDeSauvegarde.sql
  * à exécuter en ligne de commande standard (ie. hors de MySQL)

## Restaurer la base
* Créer la base en 1er (CREATE DATABASE ...)
* mysql nomDeLaBase < fichierDeSauvegarde.sql
  * à exécuter en ligne de commande standard (ie. hors de MySQL)
* On peut aussi utiliser la commande `SOURCE` depuis MySQL.

# Gestion des tables
## Création/Modification/suppression
```sql
CREATE TABLE nomDeLaTable (
nomDeLaColonne1 type [UNSIGNED] [NOT NULL] [AUTO_INCREMENT] [PRIMARY KEY] [DEFAULT valeurParDéfaut],
nomDeLaColonne2 type [UNSIGNED] [NOT NULL] [AUTO_INCREMENT] [PRIMARY KEY] [DEFAULT valeurParDéfaut],
...
)

ENGINE = INNODB (ou MYISAM); le moteur de la table est une spécificité MySQL
```

* SHOW TABLES;
* DESCRIBE nomDeLaTable;
* DROP TABLE nomDeLaTable;
* ALTER TABLE nomDeLaTable ADD [COLUMN] nomDeLaColonne type [options]; Si COLUMN n'est pas précisé, MySQL ajouter une colonne par défaut
* ALTER TABLE nomDeLaTable DROP [COLUMN] nomDeLaColonne;
* ALTER TABLE nomDeLaTable CHANGE AncienNom nouveauNom type [options];
  * Permet de renommer une colonne et/ou de changer le type et/ou les options. Le type et les options indiqués sont appliqués, donc même si on ne veut pas changer, il faut les ré-indiquer.

* ALTER TABLE nomDeLaTable MODIFY nom type [options];
  * Permet de changer uniquement le type et/ou les options.

## Index
### Description
Permet de trier une colonne dans l'ordre croissant afin d'accélérer les recherches. MySQL conserve le lien avec la table de base.
* Avantages:
  * Accélère les requêtes sur les colonnes indexées
* Inconvénients:
  * Occupe plus de mémoire
  * les requêtes d'insertion, de modification et de suppression sont plus longues


### Notes ✏️
* On peut indexer plusieurs colonnes simultanément
* Si on indexe *n* colonnes, cet index inclue les sous-index constitués des colonnes de gauches de cette index (index par la gauche)
* Lorsqu'on indexe une colonne de type CHAR, VARCHAR, TEXT, BLOB: on peut indexer seulement *x* octets
  * Permet d'économiser de la mémoire en n'indexant pas l'intégralité de la colonne
  * obligatoire pour les types TEXT et BLOB

* index UNIQUE: empêche de créer une donnée dont l'index existe déjà.
* index FULLTEXT (moteur MYISAM uniquement): crée un index particulièrement efficace sur les données de type CHAR, VARCHAR et TEXT.
  * cet index ne permet pas l'index par la gauche
* index SPATIAL: permet de créer un index sur des données contenant des coordonnées spatiales


### Syntaxe
A la création de la table:
```sql
CREATE TABLE table (
colonne1 type [options] KEY,
colonne2 type [options] UNIQUE
);
```

**Remarques:**
* pas d'index composite
* pas d'index par la gauche (ou partiel sur les strings)

```sql
CREATE TABLE table (
colonne1 type [options],
colonne2 type [options],
INDEX [nomIndex] colonne1 [,colonne2]
UNIQUE [INDEX] [nomIndex] colonne1(x)
);
```


Après la création de la table:
```sql
ALTER TABLE table
ADD INDEX [nomIndex] colonne1 [, colonne2];
```

```sql
ALTER TABLE table
ADD PRIMARY KEY colonne1;
```

```sql
CREATE [UNIQUE, FULLTEXT, SPATIAL] INDEX nomIndex
ON table (colonne1 [, colonne2] );
```

### Suppression d'un index
```sql
ATLER TABLE table
DROP INDEX nomIndex;
 
ATLER TABLE table
DROP PRIMARY KEY;
```


## Clés étrangères
### Description
Une clé étrangère permet de s'assurer qu'une donnée d'une nouvelle entrée d'une table est bel et bien existant dans une autre table avant d'autoriser l'insertion. Cela évite qu'une ligne d'une table fasse référence à une ligne inexistante dans une autre table.


### Notes ✏️
* Possibilité de créer des clés étrangères composites (plusieurs colonnes)
* Création d'un index sur la(les) colonne(s) contenant la clé étrangère
* La colonne qui sert de référence doit être indexée
* La colonne contenant la clé étrangère doit être de même type que la colonne référencée (idem pour clés composites)
* Fonctionne avec INNODB uniquement

### Syntaxe
A la création de la table:
```sql
CREATE TABLE table (
colonne1,
CONSTRAINT [nomDeLaContrainte] FOREIGN KEY (colonneCléEtrangère) REFERENCES tableRéférencée(ColonneRéférencée)
[ON UPDATE {RESTRICT | NO ACTION | SET NULL | CASCADE} ]
[ON DELETE {RESTRICT | NO ACTION | SET NULL | CASCADE} ]
);
```

Après la création de la table:
```sql
ALTER TABLE table
ADD CONSTRAINT nomContrainte FOREIGN KEY (colonneCléEtrangère) REFERENCES tableRéférencée(ColonneRéférencée)
[ON UPDATE {RESTRICT | NO ACTION | SET NULL | CASCADE} ]
[ON DELETE {RESTRICT | NO ACTION | SET NULL | CASCADE} ];
```

Suppression:
```sql
ALTER TABLE table
DROP FOREIGN KEY nomContrainte;
```

### Modification/Suppression
Le comportement en cas de modification ou de suppression d'une valeur appartenant à la clé étrangère est défini par les options ON UPDATE et ON DELETE spécifiées lors de la création de la clé.


| Option | Description |
|--------|-------------|
| RESTRICT | La modification/suppression de la valeur est interdite si elle est utilisée dans une autre table |
| NO ACTION | idem RESTRICT (pour MySQL. Peut différer dans d'autres SGBD) |
| SET NULL | Toute référence à la valeur que l'on modifie/supprime sera remplacée par NULL |
| CASCADE | Les lignes des autres tables qui font référence à la valeur modifiée/supprimée seront modifiées/supprimées elles aussi. Si modification, seule la valeur concernée sera changée. Si suppression, la ligne entière sera supprimée. **Attention:** Dans le cas de la modification, on prendra garde à ce que cela n'engendre pas une modification d'une valeur appartenant à une clé primaire. |


# Gestion des données
## Création
* INSERT INTO NomDeLaTable VALUES (valeur1 , valeur2 , valeur3, etc.);
* INSERT INTO NomDeLaTable VALUES (valeur1 , NULL , valeur3, etc.);
* INSERT INTO NomDeLaTable (colonne1, colonne3) VALUES (valeur1 , valeur3);
* INSERT INTO NomDeLaTable (colonne1, colonne3) VALUES (valeur1_1 , valeur1_3), (valeur2_1 , valeur2_3);


Syntaxe spécifique MySQL:

* INSERT INTO NomDeLaTable SET colonne1=valeur1 , colonne3=valeur3;
  * Insertion multiple impossible


Notes:
* si on donne NULL pour un champ NOT NULL & AUTO INCREMENT, la valeur est déterminée automatiquement
* ne pas oublier de saisir les données de type string avec les quotes
* les valeurs à insérer peuvent provenir de requêtes (utile quand la valeur à insérer correspond à un index dans une table tierce). Attention, on ne peut pas utiliser dans la requête la table que l'on veut modifier.


## Violation de contrainte d'unicité
Lors de la création de la table, des contraintes d'unicité sont définies sur certaines colonnes.


Les options suivantes permettent de contourner les erreurs retournées.

| Option | Description | Syntaxe |
|--------|-------------|---------|
| IGNORE | L'erreur existe quand même mais elle n'est pas retournée à l'utilisateur. | INSERT IGNORE INTO |
| REPLACE | Les lignes remplissants le critère d'unicité que l'on essaie de violer sont supprimées et la nouvelle ligne est ajoutée. **Attention:** plusieurs contraintes d'unicité peuvent affecter plusieurs lignes. Dans ce cas, toutes les lignes seront supprimées avant d'ajouter la nouvelle ligne. | REPLACE INTO |
| ON DUPLICATE | La ligne remplissant le critère d'unicité que l'on essaie de violer est modifiée: la modification effectuée est décrite par la commande UPDATE. **Attention:** Cette commande ne doit être utilisée que si une seule ligne viole la contrainte d'unicité. Sinon, le remplacement effectuée n'est pas maitrisé. | INSERT INTO ... VALUES ... ON DUPLICATE KEY UPDATE colonne1=valeur1 [,colonne2=valeur2]; |


## Modification
* UPDATE [IGNORE] table SET colonne1 = valeur1 [, colonne2 = valeur2] WHERE condition;
* UPDATE [IGNORE] table SET colonne1 = valeur1 [, colonne2 = valeur2]; Modification de toutes les lignes


> **Note:** On peut utiliser des sous-requêtes dans la commande UPDATE. Seule limitation, on ne peut pas utiliser la table que l'on veut modifier.



## Suppression
* DELETE FROM table WHERE condition;
* DELETE FROM table; Efface toutes les lignes de la table


> **Note:** On peut utiliser des sous-requêtes dans la commande DELETE. Seule limitation, on ne peut pas utiliser la table que l'on veut modifier.

# Utilisation de fichiers
On peut stocker les requêtes dans un fichier .sql. Les requêtes sont écrites comme elles le seraient en ligne de commande.

On exécute le fichier avec la commande:
```sql
SOURCE chemin/nomDuFichier.sql;
```


On peut également importer des données depuis un fichiers .csv (ou autre)
```sql
LOAD DATA [LOCAL] INFILE  'nomDuFichier.csv' [ {IGNORE | REPLACE} ]
INTO TABLE 'nomDeLaTable'
[FIELDS
 [TERMINATED BY '\t']
 [ENCLOSED BY ' ']
 [ESCAPED BY '\\']
]
[LINES
 [STARTED BY ' ']
 [TERMINATED BY '\n']
]
[IGNORE 'nombre' LINES]
[('nom_colonne', ...)];
```

* IGNORE ou REPLACE: Spécifie le comportement à adopter en cas de violation de contrainte d'unicité (cf. [Violation de contrainte d'unicité](#violation-de-contrainte-dunicité))
* LOCAL: Indique que le fichier se trouve côté client.
* FIELDS: Permet de déterminer le format du fichier pour les colonnes. Si l'option est utilisée, il faut au moins définir une des 3 options suivantes
  * TERMINATED: Définit le caractère qui délimite les colonnes (Valeur par défaut: \t = TAB ; Valeur pour CSV: ';')
  * ENCLOSED: Définit le caractère qui entoure les valeurs
  * ESCAPED: Définit le caractère d'échappement (lui-même échappé)
* LINES: Permet de déterminer le format du fichier pour les lignes. Si l'option est utilisée, il faut au moins définir une des 2 options suivantes
  * STARTED: Définit le caractère qui identifie un début de ligne
  * TERMINATED: Définit le caractère qui identifie une fin de ligne
* IGNORE: ignore les *x* premières lignes du fichier
* '*nom de colonne*': indique quelles colonnes sont présentes dans le fichier (si le fichier contient seulement certaines colonnes). Attention: avec cette option, les colonnes non renseignées doivent accepter NULL ou permettre l'AUTO INCREMENT
