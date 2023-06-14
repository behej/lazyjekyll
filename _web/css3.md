---
title: CSS3
layout: default
icon: css3.png
---
# Où écrire le code CSS
## Dans un fichier séparé .css (recommandé)
* Créer un fichier .css qui contient le code CSS. Toutes les pages web pourront faire référence à cet unique fichier.
* Dans le head, ajouter le lien vers la feuille de style

```html
<head>
     <link rel="stylesheet" href="style.css" />
</head>
```

## Dans la section head du .html
* Dans la section head, ajouter le code CSS dans une balise `<style>`

```html
<head>
     <style>
          Code CSS
     </style>
</head>
```

## Dans les balises (déconseillé)
* Intégrer directement le code CSS dans chaque balise

```html
<p style="Code CSS"> Texte </p>
```

# Structure d'un fichier CSS
```css
balise1
{
     propriété1: valeur1;     /* Commentaire */
     propriété2: valeur2;
     ...
}

balise2, balise3
{
     ...
}
``` 

* **balise** (ou sélecteur): indique la balise (ou classe ou id) sur laquelle s'applique le style: body, p, em, strong, mark, .nomClasse, etc.
* **propriété**: indique la propriété que l'on souhaite modifier: color, font-size
* **valeur**: valeur à appliquer à la propriété
* Si plusieurs balises sont indiquées, le style indiqué s'applique à toutes ces balises.
* Un style indiqué pour une balise s'applique pour toutes les autres balises contenues dans cette dernière sauf si un autre style est défini plus localement.

# Balises modifiables
## Balises standard
* body
* p
* h1
* em
* etc ...

## Classes et Ids
Une classe commence par un point et un ID par un dièse :
* .nomClasse
* #nomId


## Combinaison de balises
* `*` : sélecteur universel, concerne toutes les balises
* *balise1 balise2* : concerne toutes les balises de type 2 situées à l'intérieur de balises de type 1
* *balise1 + balise2* : Concerne toutes les balises de type 2 qui suivent immédiatement une balise de type 1
* *balise1[attribut]*: Concerne toute les balise de type 1 qui possèdent l'attribut indiqué
* *balise1[attribut="valeur"]*: Concerne toute les balise de type 1 qui possèdent l'attribut indiqué à la valeur indiquée


## Pseudo-classes
Style à appliquer à une balise lorsque l'action correspondante se produite. Applicable à toutes les balises (même si appliqué dans la pratique plutôt aux liens)

| Pseudo-classe | Description |
|-----------|------------|
| balise:hover | Apparence lors du survol avec la souris |
| balise:active | Apparence au moment du clic (moment très furtif) |
| balise:focus | Apparence lorsque l'élément est sélectionné |
| balise:visited | Apparence d'un lien lorsqu'il a déjà été consulté |
| :required | Eléménts de formulaire obligatoires |
| :invalid | Eléments de formulaire invalides (ie mal remplis) |

## Pseudo-éléments
Crée un pseudo-élément juste avant ou après l'élément HTML associé. Permet notamment d'ajouter un contenu cosmétique grâce au CSS juste avant ou après un élément HTML.


| Pseudo-élément | Description |
|-----------|------------|
| balise::before | Crée un pseudo-élément juste avant l'élément HTML associé | 
| balise::after  | Crée un pseudo-élément juste après l'élément HTML associé | 

> Généralement utilisé avec la propriété `content` afin de spécifier le contenu à afficher dans cet élément

**Exemple:**
```css
a::before {
    content: '🔗';
}
``` 

# Propriétés

| Propriété | Description |
|-----------|-------------|
| color | Couleur prédéfinie: white, silver, grey, black, red, maroon, lime, green, yellow, olive, blue, navy, fuchsia, purple, aqua, teal. Couleur code hexa: #FFFFFF. Couleur RGB: rgb(255, 255, 255). Couleur RGBa: rgba(255, 255, 255, 0.5) -- *le dernier paramètre précise l'opacité (entre 0 et 1)*
| background-color | Couleur de fond |
| background-image: url("image.jpg") | Image de fond |
| background-attachement: fixed / scroll | L'image de fond est fixe ou défile avec la page. *scroll* par défaut. |
| background-repeat: no-repeat / repeat-x / repeat-y / repeat | Répétition de l'image de fond: pas de répétition / répétition horizontale / répétition verticale / répétition horizontale & verticale (mosaïque). *repeat* par défaut. |
| background-position: 10px 20px | Positionnement de l'image de fond (10 pixels de gauche et 20 pixels du haut). |
| background-position: top / bottom / left / center / right / top right / ... | Positionnement de l'image de fond: en haut / en bas / gauche / centré / droite / combinaison |
| *background* | Meta-propriété qui regroupe toutes les propriétés de background. **Exemple:** background: url("image.jpg") fixed no-repeat top; **Note:** il est possible de combiner plusieurs images de fond. La première est au-dessus, la dernière en dessous. Les autres options d'une image sont juste derrière son url. **Exemple:** background: url("image1.jpg") top left url("image2") repeat; |
| font-size: 10px | Taille de police en pixels |
| font-size: 1cm | Taille de police en centimètres |
| font-size: 10mm | Taille de police en millimètres |
| font-size: xx-small / x-small / small / medium / large / x-large / xx-large | Taille de police en qualitatif |
| font-size: 1.1em | Taille de police en relatif par rapport à la taille de base (1em). Existe une variante **ex** |
| font-family: police1, police2, police3 | Police utilisée pour le texte. Si le navigateur n'a pas la police1, alors il essaiera avec police2 puis police3 et ainsi de suite. Ajouter la police **serif** ou **sans-serif** à la fin comme police par défaut si toutes les autres échouent. / Si un police comporte 2 ou plusieurs mots, mettre des guillemets (exemple: **"Arial Black"**). |
| font-style: normal / oblique / italic | Texte en italique. Note: oblique légèrement différent de italic |
| font-weight: normal / bold | Texte en gras |
| text-decoration: none / underline / line-through / overline / blink | Texte normal / souligné / barré / ligne au-dessus / clignotant |
| text-transform: uppercase | Force la casse du texte en majuscules |
| text-align: left / center / right / justify | Justification du texte |
| float: left / right | Permet de faire *flotter* une image (ou autre) sur du texte. i.e. le texte va joliment encadrer l'image. **Note:** Le texte doit impérativement être placé **après** l'élément qui flotte. |
| clear: left / right / both | Permet d'annuler l'effet d'un float. i.e. le texte sera placé sous l'élément qui flotte et non autour. Valable si l'élément flottant était placé à gauche / à droite / les deux. |
| opacity: 0. | Opacité d'un élément (entre 0 et 1) |
| border-width: 3px | Largeur de la bordure en pixels |
| border-color: red / #FFFFFF / rgb(x,x,x) | couleur de la bordure. On peut indiquer le nom de la couleur / le code hexa / les composantes rgb |
| border-style: none / solid / dotted / dashed / double / groove / ridge / inset / outset  | style de bordure |
| *border* | méta-propriété pour les bordures |
| border-top / border-bottom / border-left / border-right | Méta-propriété de bordure mais qui ne concerne que la bordure d'un côté spécifique |
| border-radius: 5px | Bordure arrondies: rayon de courbure en pixels. |
| border-radius: 5px 10px 5px 10px | Bordure arrondies: rayons de courbure des coins haut gauche, haut droit, bas droit, bas gauche dans l'ordre |
| border-radius: 5px / 10px | Bordure arrondies elliptiques: rayon de courbure de départ puis d'arrivée. |
| box-shadow: 10px 5px 2px black [inset] | Donne un effet d'ombre à un cadre. Les paramètres sont dans l'ordre: décalage horizontal / décalage vertical / dégradé (\<décalage: faible ; \=décalage: normal ; \>décalage: élevé) / couleur / effet enfoncé (facultatif) |
| text-shadow: 10px 5px 2px black | Effet d'ombre appliqué au texte (paramètres idem box-shadow) |
| width: 400px / width: 100% | Largeur d'un bloc (hors marge). Exprimée en pixels ou en % |
| height: 400px / height: 100% | Hauteur d'un bloc (hors marge). Exprimée en pixels ou en % |
| min-width / max-width / min-height / max-height | Dimensions mini et maxi d'un bloc |
| margin: 10px | Marge extérieure d'un bloc (généralement exprimée en pixels, peut aussi s'exprimer en %) |
| padding: 10px | Marge intérieure d'un bloc (généralement exprimée en pixels, peut aussi s'exprimer en %) |
| margin-top / margin-right / margin-bottom / margin-left | Indication des dimensions des marges en précisant chaque côté. **Note:** Egalement valable pour le padding |
| margin: 5px 10px 5px 10px | Indication des dimensions des marges, dans l'ordre, haute, droite, bas, gauche. **Important:** Notation courte: `margin: 5px 10px`: indication des marges haut/bas et gauche/droite |
| margin: auto | Adaptation automatique des marges en fonction de la largeur de la page et de la largeur du bloc. Le bloc sera centré. Valable uniquement pour un centrage horizontal. |
| overflow: visible / hidden / scroll / auto | Comportement à adopter si le texte d'un bloc dépasse les dimensions fixées pour ce bloc: le texte dépasse du bloc / le texte dépassant est caché / barre de défilement / auto. Valeur préconisée: auto |
| word-wrap: break-word | Permet de "casser" sur plusieurs lignes des mots très longs qui dépasseraient du bloc. |
| display: inline / block / inline-block / none | Transforme le type d'un élément: **inline**: l'élément sera aligné / **block**: l'élément sera de type block, on pourra préciser ses dimensions / **inline-block**: l'élément sera aligné mais on pourra préciser ses dimensions / **none**: l'élément sera masqué |
| vertical-align: top / middle / bottom / baseline | Alignement vertical des élements: alignés en haut, au milieu, en bas, sur la ligne de base (en bas) |
| vertical-align: 10px / 5% | Alignement vertical à 10px / 5% de la baseline |
| position: absolute / fixed / relative | Positionnement d'un élément: **absolu**: L'élément est positionné n'importe où sur la page (il se positionne par dessus les autres éléments) / **fixed**: Idem absolu mais l'élément reste à sa position lorsqu'on scrolle dans la page / **relatif**: L'élément est re-positionné par rapport à sa propre position d'origine |
| left: 10px / 5% ; right ; top ; bottom | Indication de positionnement: 10px / 5% en partant de la gauche (ou droite, ou haut, ou bas) de la page ou du bloc parent. |
| list-style-image: url("image") | Charge une image pré-définie à la place des puces standard pour les listes |
| z-position: 1 | Priorité d'affichage des couches (plus le chiffre est élevé, plus l'élément sera au-dessus) |
| border-collapse: collapse / separate | Les bordures des différentes cases d'un tableau sont confondues / dissociées. Propriété applicable à un tableau. |
| caption-side: top / bottom | Position de la légende de tableaux ou figures. |
| content | Remplace le contenu de la balise HTML concernée par le contenu défini dans le CSS. Le contenu peut etre une image, une url, un texte, un emoji, etc. | 


# Police
Définir une nouvelle police qui sera téléchargée si non présente sur l'ordinateur cible.
```css
@font-face {
     font-family: 'nomPolice';
     src: url('nomFichierPolice.ttf');
}
```

Il existe différents formats de police pris en charge ou non par les différents navigateurs. Il est possible d'utiliser plusieurs formats pour une même police. Le navigateur utilisera le format qu'il sait gérer.
```css
@font-face {
     font-family: 'nomPolice';
     src: url('nomFichierPolice.ttf') format('truetype'),
          url('nomFichierPolice.eot') format('eot'),
          url('nomFichierPolice.svg') format('svg'),
          url('nomFichierPolice.woff') format('woff'),
          url('nomFichierPolice.otf') format('embedded-opentype');
}
```


# Flexbox
> **TODO**: principe des conteneurs et éléments


| Propriété | S'applique à | Description |
|-----------|--------------|-------------|
| display: flex | conteneur | Les éléments à l'intérieur de cette balise sont positionnés à l'aide de flexbox |
| flex-direction: row / column / row-reverse / column-reverse | conteneur | Les éléments sont placés sur une ligne, une colonne, une ligne mais de droite à gauche, une colonne mais de bas en haut |
| flex-wrap: nowrap / wrap / wrap-reverse | conteneur | Retour à la ligne en cas de dépassement des dimensions de la page: pas de retour à la ligne / retour à la ligne / nouvelle ligne créée au-dessus |
| justify-content : flex-start / flex-end / center / space-between / space-around | conteneur | Justification des éléments: **flex-start**: alignés au début (à gauche ou en haut, dans la plupart des cas) / **flex-end**: alignés à la fin (à droite ou en bas dans la plupart des cas) / **center**: centré (tout regroupé) / **space-between**: étalé sur tout l'espace (les 1er et dernier éléments sont placés aux extrémités) / **space-around**: étalé sur tout l'espace mais les 1er et dernier éléments ne sont pas collés aux extrémités (un espace un laissé entre les éléments et le bord) |
| align-items: flex-start / flex-end / center / space-between / space-around | conteneur | idem justify-content mais dans l'axe secondaire (perpendiculaire à l'alignement des éléments |
| display: flex *pour le conteneur ET* margin: auto *pour les éléments* | conteneur et élément | Les éléments sont centrés et répartis de manière homogène dans le conteneur |
| align-self: flex-start / ... | élément | Définit l'alignement d'un seul élément indépendamment de l'alignement paramétré pour le conteneur |
| align-content: flex-start / flex-end / center / space-between / space-around / stretch  | conteneur | Dans le cas où les conteneurs sont répartis sur plusieurs lignes (ou colonnes) avec flex-wrap, définit comment sont réparties les différentes lignes (ou colonnes) |
| order: *n* | élément | Définit l'ordre d'affichage des différents éléments. Les éléments sont affichés dans l'ordre croissant des numéros assignés |
| *balise*:nth-child(*n*)  | élément  | Définit les propriétés du *n*-ème élément du type *balise*. **ex:** `.classe:nth-child(2) { color: blue; }`  --> la 2ème occurrence de la balise *classe* sera bleue |
| *balise*:last-child | élément | Définit les propriétés du derniers élément du type *balise* |
| flex: *n* | élément | Les éléments sont étirés selon l'attribut *n*. Un élément avec n=2 sera 2 fois plus large qu'un élément avec n=1 |

# Calculs
Le CSS permet aussi de déterminer les valeurs numériques de certaines propriétés par la réalisation de calculs.
**Exemple:
```css
width: calc(100px - {$variable})
```


| Instruction | Description |
|-------------|-------------|
| calc        | Réalise une opération mathématique |
| min         | Retourne la valeur mini parmi les 2 paramètres |
| max         | Retourne la valeur maxi parmi les 2 paramètres |

# Media Queries
Les media queries sont des requêtes permettant d'obtenir des infos sur le média afin d'adapter le style.

## Dans le HTML
```html
<link rel="stylesheet" media=media query href="style.css" />
```

La feuille feuille de style est appliquée si la query est satisfaite. On peut placer plusieurs balises link pour différentes requêtes

## Dans le CSS 
```css
@media query
```
la section qui suit cette instruction est prise en compte uniquement si la query est satisfaite


## Requêtes
Les requêtes sont construites à partir des mots clés suivants. Ils peuvent être combinés avec les mots de liaison suivants: **and**, **only** et **not**

Exemples:
```html
<link rel="stylesheet" media="screen and (max-width: 1280px)" href="petite_resolution.css" />

@media all and (orientation: portrait)
```

> **Note:** Sur les devices mobiles, l'appareil crée un viewport qui correspond à la zone affichable (ce qui est différent des dimensions de l'écran). Ca peut être sympa de définir la largeur de ce viewport de la même taille que la largeur de l'écran (pour éviter de zoomer/dézoomer

```html
<meta name="viewport" content="width=device-width" />
```


| Propriété | Description |
|-----------|-------------|
| color | gestion de la couleur (en bits/pixel). |
| height / max-height / min-height | hauteur de la zone d'affichage (fenêtre) |
| width / max-width / min-width | largeur de la zone d'affichage (fenêtre) |
| device-height / max-device-height / min-device-height | hauteur du périphérique |
| device-width / max-device-width / min-device-width | largeur du périphérique |
| orientation | orientation du périphérique (portrait ou paysage) |
| media screen/handeld/print/tv/projection/all  | type d'écran de sortie **screen**: écran «classique» / **handheld** : périphérique mobile. *Les mobiles ne renvoient pas handheld mais screen*. Donc pour savoir si on est sur mobile, utiliser plutôt max-device-width:480px / **print**: impression / **tv**: télévision / **projection**: projecteur / **all**: tous |


# Liens utiles
* Designs de sites web libres: [http://www.freehtml5templates.com](http://www.freehtml5templates.com)
* Polices libres: [http://www.dafont.com](http://www.dafont.com)
* Polices libres: [http://www.fontsquirrel.com/](http://www.fontsquirrel.com/   )
