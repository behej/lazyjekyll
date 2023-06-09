---
title: HTML5
layout: default
icon: html5.png
---
# Canevas
```html
<!DOCTYPE html>
<html>
     <head>
          <meta charset="utf-8" />
          <title>titre de la page</title>
     </head>

     <body>
          ...
     </body>
</html>
```

# Balises

| Balise | Description |
|--------|-------------|
| \<!\-\- commentaire \-\-\> | Commentaire |
| <\p\> \</p\> | paragraphe (renvoi à la ligne automatique) |
| \<br/\> | Retour à la ligne |
| \<h1\> \</h1\> | Titre de niveau 1 (Les titres sont hiérarchisés de h1 à h6) |
| \<em\> \</em\> | Mise en valeur légère du texte (**emphasise**). Italique par défaut |
| \<strong\> \</strong\> | Mise en valeur marquée du texte. Gras par défaut |
| \<mark\> \</mark\> | Fait ressortir du texte. Surligné par défaut |
| \<balise id="ancre"\> | Détermination d'une ancre à l'intérieur d'une page. Une ancre peut se fixer sur tout type de balise |
| \<a href="http://www.site.com"\> \</a\> | Lien hypertexte vers une url arbitraire |
| \<a href="autrePageDuSite.html"\> \</a\> | Lien hypertexte vers une autre page ou vers un fichier |
| \<a href="#ancre"\> \</a\> | Lien hypertexte vers une ancre dans la même page |
| \<a href="autrePage#ancre"\> \</a\> | Lien hypertexte vers une ancre dans une autre page |
| \<a href="url" title="texte infobulle"\> \</a\>  | Affiche une infobulle lors du survol du lien avec la souris |
| \<a href="url" target=_blank\> \</a\> | Force l'ouverture du lien dans une nouvelle fenêtre |
| \<a href="mailto:prenom.nom@mail.com"\> \</a\> | Lien vers une adresse mail |
| \<img src="image.jpg" alt="texte alternatif" /\> | Insertion d'une image. L'attribut **alt** permet de spécifier un texte alternatif. On peut également ajouter une infobulle avec l'attribut **title**. |
| \<figure\> \</figure\> | Définit une figure (ou schéma, ou code ou autre) |
| \<figcaption\> \</figcaption\> | Légende de la figure |
| \<balise class="nomClasse"\> \</balise\> | Définir une classe. Utile lors de la mise en forme avec CSS, on pourra appliquer un style différent à la classe |
| \<balise id="nomId"\> \</balise\> | Définir un ID. Utile lors de la mise en forme avec CSS, on pourra appliquer un style différent à l'ID. **Important:** Un ID doit être unique dans un page. |
| \<span\> \</span\> | Balise sans effet particulier. Utile pour définir une classe sur du texe qui n'a pas de balise particulière. Cette balise est de type **inline** |
| \<div\> \</div\> | Balise sans effet particulier. Utile pour définir une classe sur du texe qui n'a pas de balise particulière. Cette balise est de type **block** (obligatoirement associée à un retour à la ligne). |
| \<ul\> \</ul\> | Unordered List: liste non numérotée |
| \<ol\> \</ol\> | Ordered List: liste numérotée |
| \<lh\> \</lh\> | List Header: Titre de la liste |
| \<li\> \</li\> | Elément de la liste |
| \<header\> \</header\> | Entête de la page. Il peut y avoir plusieurs entêtes si la pages contient plusieurs sections |
| \<footer\> \</footer\> | Pied de page |
| \<nav\> \</nav\> | Menu de navigation |
| \<section\> \</section\> | Section de la page |
| \<aside\> \</aside\> | Informations complémentaires |
| \<article\> \</article\> | Portion généralement autonome de la page |


## Tableaux

| Balise | Description |
|--------|-------------|
| \<table\> \</table\> | tableau |
| \<caption\> \</caption\> | Titre du tableau |
| \<tr\> \</tr\> | Ligne d'un tableau (Table Row) |
| \<th\> \</th\> | Cellule d'entête d'un tableau (Table Header) |
| \<td\> \</td\> | Cellule d'un tableau. Une cellule dans être dans ligne qui est elle-même dans un tableau. |
| \<thead\> \</thead\> | Définition de la partie entête du tableau |
| \<tbody\> \</tbody\> | Définition de la partie corps du tableau |
| \<tfoot\> \</tfoot\> | Définition de la partie pied du tableau |
| \<td colspan="x"\> | Fusion de x cellules d'une même ligne. |
| \<td rowspan="x"\> | Fusion de x cellules d'une même colonne. |

## Audio & Vidéo

| Balise | Description |
|--------|-------------|
| \<audio src="musique.mp3"\>Texte de remplacement\</audio\> | Ajout d'un élément audio. N'a aucun effet car le fichier n'est pas joué. Le texte de remplacement permet d'afficher quand même quelque chose si le navigateur est incapable de charger le format utilisé |
| \<audio src="musique.mp3" controls\> | Ajoute les boutons de contrôle (play, pause, etc) |
| \<audio src="musique.mp3" width="xxx"\> | Spécifie la largeur du lecteur audio |
| \<audio src="musique.mp3" loop\> | La musique est jouée en boucle |
| \<audio src="musique.mp3" autoplay\> | La musique est lancée automatiquement au chargement de la page |
| \<audio src="musique.mp3" preload=none/metadata/auto\> | Préchargement du fichier: rien / uniquement les métadata / laisser le navigateur décider |
| \ <audio controls\> \<source src="hype_home.mp3"\> \<source src="hype_home.ogg"\> \</audio\> | La balise audio est séparée en 2, ce qui permet de spécifier plusieurs fichiers. Si le navigateur n'arrive pas à lire le 1er format, il passe au suivant et ainsi de suite. |
| \<video src="sintel.webm"\>Texte de remplacement\</video\> | Ajout d'un élément vidéo. N'a aucun effet car le fichier n'est pas joué. Le texte de remplacement permet d'afficher quand même quelque chose si le navigateur est incapable de charger le format utilisé |
| \<video src="sintel.webm" poster="image.jpg"\> \</video\> | Définit l'image qui est affichée tant que la vidéo n'est pas en lecture. Si omis, affiche la 1ère image de la vidéo |
| \<video src="sintel.webm" controls\>\</video\> | Affiche les boutons de contrôle (play, pause, etc)  |
| \<video src="sintel.webm" width="xxx" height="xxx"\> \</video\> | Spécifie les dimensions du lecteur |
| loop | idem audio |
| autoplay | idem audio |
| preload | idem audio |
| \<video\> \<source src="video.mp4"\> \<source src="video.webm"\> \</video\> | La balise vidéo est séparée en 2, ce qui permet de spécifier plusieurs fichiers. Si le navigateur n'arrive pas à lire le 1er format, il passe au suivant et ainsi de suite.  |


## Formulaires

| Balise | Description | Exemple |
|--------|-------------|---------|
| \<form method="get/post" action="traitement.php"\> \</form\> | Balises de début et de fin d'un formulaire. L'attribut **method** permet d'indiquer la façon d'envoyer les infos du formulaire vers le serveur. On utilise généralement post car get est limité à 255 caractères. L'attribut action précise le **programme** à exécuter après envoi du formulaire. |
| \<form method="post" action="traitement.php" enctype="multipart/form-data"\> \</form\> | Idem précédent mais avec l'attribut supplémentaire **enctype** nécessaire pour l'envoi de fichiers. |
| \<input type="text" name="nomInfo" id="nomInfo"/\> | zone de texte mono-ligne. le nom est utile pour récupérer l'info (en PHP par exemple). L'id est utile pour lier un label. Autres attributs: size="30" / maxlength="50" / value="Valeur par défaut" / placeholder="Texte indicatif qui s'efface sitôt on commence à saisir qqch" |
| \<label for="nomInfo"\> \</label\> | Libellé de l'élément du formulaire. l'attribut for doit correspondre à l'id de l'élément lié. |
| \<input type="password" name="..." id="..." /\> | Saisie de type **mot de passe** | <input type="password" name="mypwd" id="mypassword" /> |
| \<textarea name="..." id="..."\>Texte par défaut affiché dans la zone\</textarea\> | Zone de texte multiligne. Autres attributs possible: rows et cols pour définir la taille par défaut. | <textarea name="txtarea" id="txtarea">Texte par défaut affiché dans la zone</textarea> |
| \<input type="email" /\> | Saisie d'une adresse e-mail | <input type="email" /> |
| \<input type="url" /\> | Saisie d'une URL | <input type="url" /> |
| \<input type="tel" /\> | Saisie d'un numéro de téléphone | <input type="tel" /> |
| \<input type="number" /\> | Saisie d'un nombre. Autres attributs: min / max / step | <input type="number" min=0 max=10 step=2 /> |
| \<input type="range" /\> | Saisie d'un nombre avec un curseur. Autres attributs: min / max / step | <input type="range" min=0 max=50 step=5 /> |
| \<input type="color" /\> | Couleur (non utilisé) | <input type="color" /> |
| \<input type="date" /\> | date (non utilisée à part opéra) | <input type="date" /> |
| \<input type="search" /\> | recherche (non utilisé) |
| \<input type="checkbox" /\> | Case à cocher. Si on ajoute l'attribut **checked** la case est cochée par défaut. | <input type="checkbox" checked/> |
| \<input type="radio" name="..." value="..." id="..." /\> | Sélection unique. L'unicité s'applique parmi toutes les inputs ayant le même attribut **name**. Les valeurs doivent par contre être uniques pour chaque élément. | <input type="radio" name="input_name" value="myvalue" id="myid" /> |
| \<select name="..." id="..."\> \<option value="valeur1"\>Choix 1\</option\> \<option value="valeur2" selected\>Choix 2\</option\> \</select\> | Liste déroulante. L'attribut **selected** indique la valeur sélectionnée par défaut. L'attribut **size** spécifie le nombre d'éléments affichés simultanément. L'attribut **multiple=multiple** autorise la sélection multiple d'éléments | <select name="select_name" id="id_select"> <option value="opt1">Option 1</option> <option value="opt2" selected>Option 2</option> </select> |
| \<input type="file" name="..." id="..."\> | Permet d'uploader un fichier (nécessite l'attribut **enctype** dans la balise **form**) | <input type="file" name="file_name" id="id_file"> |
| \<optgroup label="nomGroupe"\> \<options\> \</optgroup\> | Permet de regrouper plusieurs éléments de la liste déroulante par catégorie. |
| \<fieldset\> \</fieldset\> | Permet de regrouper et organiser des éléments d'un formulaire. Dessine un cadre autour de tous les éléments compris entre les 2 balises |
| \<legend\> \</legend\> | Donne une légende au **fieldset** |
| autofocus | Cet attribut place le focus sur l'élément qui le porte après le chargement de la page |
| required | Tous les éléments portant cet attribut sont obligatoires |
| \<input type="submit" value="texte" /\> | Bouton de soumission du formulaire. Après appui sur ce bouton, c'est l'attribut **action** du formulaire qui est appelé. | <input type="submit" value="Submit" /> |
| \<input type="reset" value="texte" /\> | Réinitialisation du formulaire | <input type="reset" value="Reset" /> |
| \<input type="image" src="image" /\> | Idem bouton submit mais sous la forme d'une image |
| \<input type="button" value="texte" /\> | Bouton générique sans action particulière. Généralement, son comportement est à coder en javascript | <input type="button" value="Generic button" /> |

# Liens utiles
* Valideur de pages html: [http://validator.w3.org/](http://validator.w3.org/)
