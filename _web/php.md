---
title: PHP
layout: default
icon: php.png
---
Le code PHP s'écrit entre les balises `<?php` et `'?>`

Les instructions se terminent par un point-virgule.

# Instructions de base

| Instruction | Description |
|-------------|-------------|
| // commentaire | Commentaire sur une seule ligne |
| /* commentaire */ | Commentaire sur plusieurs lignes |
| echo "texte"; | Affiche du texte |
| echo 'texte'; | Affiche du texte |
| `echo "la valeur $variable est stockée dans la variable"` | Affiche du texte et des variables. Privilégier la syntaxe suivante
| `echo 'la valeur ' . $variable . ' est stockée dans la variable'` | Affiche du texte et des variables. Privilégier cette syntaxe (pour des raison de performance et de coloration syntaxique). |
| include("page.php");  | Inclut le code contenu dans un autre fichier |
| function nomFonction(paramètres) | Définition d'une fonction |
| if ... else| Conditions (idem C) |
| if ... elseif | Conditions (idem C) |
| switch, case | idem C |
| $var = (condition) ? valVrai : valFaux; | Opérateur ternaire (idem C) |
| while | idem C |
| for | idem C |
| foreach($tableau as $item) | Boucle *for* qui parcourt tous les éléments du tableau. A l'intérieur de la boucle, le i-ème élément du tableau est référence en tant que variable `$item`. |
| foreach($tableau as $cle => $item) | Boucle *for* qui parcourt tous les éléments du tableau associatif. A l'intérieur de la boucle, le i-ème élément du tableau est référence en tant que variable `$item` et sa clé `$cle`. |
| print_r($tableau); | Affiche un tableau. Fonction surtout utilisée pour le debug. Problème d'affichage --> On intégrera la fonction *print_r* entre les balises \<pre\> et \</pre\> |
| array_key_exists('cle', $tableau); | Renvoie *true* si la clé indiquée existe dans le tableau |
| in_array(valeur, $tableau); | Renvoie *true* si la valeur indiquée est présente dans le tableau |
| array_search(valeur, $tableau); | Renvoie l'indice ou la clé où se trouve la valeur indiquée dans le tableau. Renvoie *false* si la valeur n'est pas trouvée. |
| isset($var) | Renvoie *true* si la variable existe. **Note:** fonctionne aussi avec les items d'un tableau |
| try { code } catch(Exception $e) { code } | Exécute le code dans la portée du *try*. En cas d'erreur, le code de la portée *catch* est exécuté. L'objet *exception* est utilisé pour en savoir plus sur l'erreur. |
| throw new Exception('message d'erreur') | Lance une exception qui pourra être récupérée par un *catch* |
| die('message') | Arrête le chargement de la page et affiche le message. **Note:** Si un entier est passé comme argument à la fonction au lieu d'une chaine de caractères, celui-ci n'est pas affiché mais est utilisé comme valeur de retour pour une éventuelle fonction appelante. |
| header('Location: page.php') | Redirige l'utilisateur vers `page.php`. |


# Fonctions courantes
## Traitement des chaînes de caractères

| Fonction | Description |
|----------|-------------|
| strlen | Longeur d'une chaine de caractères |
| str_replace('a', 'b', 'chaine'); | Remplace toutes les occurences de *a* par *b* dans la *chaine* |
| str_shuffle(chaine); | Mélange toutes les lettres de *chaine* |
| strtolower(chaine) | Change les lettres en minuscules |


## Opération sur les dates 

| Fonction | Description |
|----------|-------------|
| date(param) | Renvoie la date ou l'heure selon la valeur du paramètre. Y: année ; m: mois ; d: jour ; i: minute ; H: heure |

## Opérations sur les fichiers 

[http://uk3.php.net/manual/fr/ref.filesystem.php](http://uk3.php.net/manual/fr/ref.filesystem.php)


| Fonction | Description |
|----------|-------------|
| pathinfo($_FILES['fichier']['name']) | Renvoi un tableau associatif contenant diverses infos à propos du fichier (dirname, basename, extension, filename) |
| basename(path) | Renvoi le nom de base du fichier (i.e. le nom du fichier sans l'arborescence) de l'argument *path* |
| move_uploaded_file(src, dst) | Déplace le fichier *src* (en général le fichier stocké temporairement par PHP après upload) à l'emplacement *dst* (*dst* doit comprendre l'arborescence, le nom du fichier et son extension) |
| $handler = fopen(fichier, mode) | Ouvre un fichier. Le mode peut être r, r+, a, a+ qui correspond respectivement à lecture seule, lecture + écriture, écriture seule (ajout), écriture + lecture. Les modes *a* crée le fichier s'il n'existe pas. Attention, en mode *append*, la fonction *fseek* n'a aucun effet |
| fgetc($handler) | Lit un seul caractère |
| fgets($handler) | Lit une ligne entière |
| fputs($handler) | Ecrit une ligne |
| fseek($handler, pos) | Déplace le curseur à la position *pos*. Si *pos* est négatif, le curseur est placé à partir de la fin du fichier. |
| fclose($handler) | Ferme le fichier |


## MySQL (extension **mysql**)
> ⚠️ **Important:** Cette extension est obsolète. On privilégiera l'extension **mysqli** ou mieux, l'extension **PDO**. Néanmoins, les pages perso Free ne gèrent que cette extension.


| Fonction | Description |
|----------|-------------|
| mysql_connect(host[:port], login, mdp) | Ouvre une connexion vers le serveur indiqué. Retourne un *handler* vers la connexion ou false en cas d'erreur. |
| mysql_close(connexion) | Ferme la connexion ouverte avec mysql_connect |
| mysql_set_charset('utf8') | Définit le jeu de caractères à utiliser avec la connexion |
| mysql_select_db(db [, connexion]) | Sélection la bdd sur laquelle travailler. Si la connexion n'est pas précisée, la dernière connexion ouverte est utilisée. |
| mysql_query(requête [, connexion]) | Exécute la requête sur la table précédemment sélectionnée. Si la connexion n'est pas précisée, la dernière connexion ouverte est utilisée. La fonction retourne le résultat de la requête (ou false en cas d'erreur). Ce résultat peut être exploité avec la fonction **mysql_fetch_array** |
| mysql_fetch_array(resultat [, result_type]) | Dépile ligne par ligne le résultat de la requête. Cette fonction retourne un tableau qui est à la fois associatif et numéroté (sauf utilisation spécifique du paramètre **result_type**. La fonction retourne *false* lorsqu'il n'y a plus de ligne à dépiler. |
| mysql_free_result(resultat) | Libère la mémoire occupée par le résultat obtenu suite à la requête **mysql_query**

### Requêtes préparées
Il est déconseillé d'insérer des variables au sein des requêtes en utilisant la concaténation (risque d'injection SQL).

Pour ce faire, on utilise les **requêtes préparées**. Une requête préparée se déroule en 2 temps:
1. Préparation de la requête avec des **?** à la place des variables.
2. Exécution de la requête avec les variables en tant que paramètres.

Cette fonctionnalité n'existe pas nativement avec l'extension **mysql**. Il faut utiliser une extension. Cf. [https://github.com/stealth35/mysql_prepare](https://github.com/stealth35/mysql_prepare)


## MySQL (extension **PDO**)

| Fonction | Description |
|----------|-------------|
| $bdd = new PDO('mysql:host=*host*; dbname=*db*; charset=utf8', *login*, *mdp*) | Ouvre une connexion vers le serveur indiqué. Retourne un objet qui gère la BDD ou jette une exception en cas d'erreur. |
| new PDO('mysql:host=*host*; dbname=*db*; charset=utf8', *login*, *mdp*, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION)); | Ouvre une connexion avec affichage des erreurs |
| $bdd->errorInfo() | Renvoie un tableau associatif qui contient les infos sur l'erreur survenue. **Ex:** `$reponse = $bdd->query(requete)` or `die(print_r($bdd->errorInfo()));` |
| $reponse = $bdd->query(requête); | Exécute la requête sur la bdd. La fonction retourne le résultat de la requête. Ce résultat peut être exploité avec la méthode **fetch** de l'objet retourné |
| $req = $bdd->prepare(requête); | Prépare une requête qui contient des variables. Les variables en question sont remplacées par des ?. **Note:** l'objet retourné par la méthode est du même type que la méthode query. On pourra donc utiliser la méthode fetch une fois la requête exécutée. |
| $req->execute(var1, var2, ...); | Exécute la requête préparée avec prepare(). Les arguments correspondent aux ? placés dans la requête. |
| $req = $bdd->prepare(requête avec marqueurs nominatifs); | Si la requête possède beaucoup de paramètres, on peut les nommer en remplacant les ? par `:nomParam` |
| $reponse->execute('param1' => $var1, 'param2' => $var2, ...) | Exécution de la requête avec les paramètres nominatifs |
| $donnees = $reponse->fetch()) | Dépile ligne par ligne le résultat de la requête. Cette fonction retourne un tableau qui est à la fois associatif et numéroté. La fonction retourne *false* lorsqu'il n'y a plus de ligne à dépiler. |
| $reponse->closeCursor() | Libère la mémoire occupée par le résultat obtenu suite à la requête |

### Requêtes préparées
Il est déconseillé d'insérer des variables au sein des requêtes en utilisant la concaténation (risque d'injection SQL).

Pour ce faire, on utilise les **requêtes préparées**. Une requête préparée se déroule en 2 temps:
1. Préparation de la requête avec des **?** à la place des variables.
2. Exécution de la requête avec les variables en tant que paramètres.

Cette fonctionnalité est portée par les 2 méthodes **prepare** et **execute**

# Variables

Le nom d'une variable doit toujours être précédé d'un dollar.
```php
$maVariable
```

Les différents types disponibles sont:
* string
* int
* float
* bool
* NULL


## Arrays
### Tableaux numérotés
```php
 $tableau = array(val1, val2, ...);     // Déclare un tableau
 $tableau[] = val;     // Ajoute une valeur à la fin du tableau
 $tableau[i]     // accède au i-ème élément du tableau
```


### Tableaux associatifs
```php
$tableau = array(     // Déclare et initialise un tableau
     'attr1' => val1,
     'attr2' => val2);

$tableau['attr']     // Accède à un attribut donné du tableau
```

## Variables superglobales

| Variable | Description |
|----------|-------------|
| $_SERVER | Valeurs renvoyées par le serveur |
| $_ENV | Variables d'environnement du serveur |
| $_SESSION | Variables de session. Elles restent stockées le temps de la session. |
| $_COOKIE | Valeurs des cookies. Les cookies peuvent rester plusieurs mois sur l'ordinateur client. |
| $_GET | Valeurs des paramètres envoyés par l'URL |
| $_POST | Valeurs des paramètres envoyés par formulaire |
| $_FILES | Fichiers envoyés |


### Sessions
* Pour activer les sessions, il faut appeler la fonction **session_start()** au tout début de chaque page PHP (avant même la balise `<!DOCTYPE html>`)
* La session est fermée soit avec la fonction **session_destroy()**, soit au bout d'un **timeout** d'inactivité
* Une fois les sessions activées, le tableau associatif **$_SESSION** est créé et est accessible depuis n'importe quelle page.
* Chez Free, pour activer les sessions, il faut en plus créer un répertoire `sessions/` à la racine du site.



### Cookies
* Pour créer un cookie, il faut appeler la fonction **setcookie** au tout début de chaque page PHP (avant même la balise `<!DOCTYPE html>`)
  * setcookie(nom, valeur, timestamp d'expiration) - le timestamp d'expiration est généralement déterminé avec `time()` + durée de validité en secondes
  * setcookie(nom, valeur, timestamp d'expiration, null, null, false, true) - le paramètre **httponly** (le dernier) positionné à *true* permet de limiter la lecture du cookie à HTTP (evite les accès javascript)
* les cookies sont accessibles par le tableau associatif `$_COOKIE` (en lecture comme en écriture)

# Transmission de données
## Transmission par l'URL
www.site.com/page.php?param1=valeur1&param2=valeur2

* Dans la balise `<a>` de la page qui contient un tel lien, il faut impérativement remplacer **&** par **& amp;**
* Dans la page, les paramètres transmis sont accessibles par le tableau associatif **$_GET** (le nom de l'attribut du tableau correspond au nom du paramètre dans l'URL)
* **Important**: ne jamais faire confiance aux données transmises et vérifier leur existence, leur type, leur valeur, etc.
  * Vérifier l'existence: fonction isset()
  * Vérifier le type: effectuer un cast
  * Vérifier la valeur: imposer des bornes min/max


## Transmission par formulaire
* Les paramètres transmis avec la méthode **get** sont stockés dans le tableau associatif **$_GET** (le nom de l'attribut du tableau correspond au nom du champ du formulaire)
* Les paramètres transmis avec la méthode **post** sont stockés dans le tableau associatif **$_POST** (le nom de l'attribut du tableau correspond au nom du champ du formulaire)


> ⚠️ ***NEVER TRUST USER INPUT*** ⚠️
* Vérifier l'existence des données
* vérifier le type
* Vérifier la valeur
* Empêcher l'injection de code



Fonctions utiles pour empêcher l'injection de code


| Fonction | Description |
|---|---|
| htmlspecialchars(texte) | Echappe les balises HTML (remplace les signes **<** et **>** par **&lt** et **&gt**). Le code HTML est ainsi affiché et non interprété par le navigateur |
| strip_tags(texte) | Supprime les balises HTML éventuellement contenues dans le texte. |



## Envoi de fichier
* L'envoi de fichier est réalisé à l'aide de l'élément du formulaire **file**
* Le fichier est stocké temporairement avant traitement (géré par PHP)
* Les informations sur le fichier sont stockées dans un tableau associatif $_FILES['nom'] (*nom* correspondant au nom du champ du formulaire)
* Les différentes informations sont stockées dans ce tableau
  * $_FILES['nom']['name'] : nom du fichier (Contient le chemin absolu de l'ordinateur client. Utiliser la fonction **basename**)
  * $_FILES['nom']['type'] : type du fichier
  * $_FILES['nom']['size'] : taille du fichier (en octet, limité à 8Mo)
  * $_FILES['nom']['tmp_name'] : nom temporaire du fichier affecté par PHP
  * $_FILES['nom']['error'] : code d'erreur de la réception du fichier (0 = pas d'erreur)


Contrôles et actions à effectuer à la réception du fichier
1. Vérifier si la variable existe (fonction **isset**)
2. Vérifier si pas d'erreur à la réception
3. Vérifier la taille du fichier (si < à la taille limite fixée par l'utilisateur)
4. Vérifier l'extension du fichier (à l'aide de la fonction **pathinfo**)
5. Valider l'upload (avec la fonction **move_uploaded_file**)

# POO
## Définition d'une classe
* Généralement dans un fichier nommé NomClasse.class.php
* la balise fermante ?> peut être supprimée pour éviter le message d'erreur *Headers already sent by*

```php
<?php
class NomClasse
{
     private $attribut1;
     private $attribut2;
     protected $attribut3;

     public function nomMethode1([$paramètres])
     {
          $this->attribut1 = ...
          code
     } 
}
```

## Constructeur et destructeur
* Constructeur: `public function __construct([paramètres])`
* Destructeur: `public function __destruct()`

## Héritage
* Définition d'une classe fille:

```php
class NomClasse extends ClasseMere
```

## Utilisation 
* Le fichier de définition de la classe est à inclure dans les sources avec l'instruction `include_once(NomClasse.class.php);`
* Création d'un objet : `$objet1 = new $MaClasse();`
* Destruction d'un objet
  * Automatiquement à la fin du fichier .php qui contient le **new**
  * Manuellement avec la fonction `unset($objet1);`



# Liens utiles
* Documentation des fonctions PHP: [http://fr.php.net/manual/fr/funcref.php](http://fr.php.net/manual/fr/funcref.php)
