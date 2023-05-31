---
title: QML
layout: default
icon: qt.png
---
> QML est un langage **déclaratif** qui permet de définir les IHM.

Plus d'infos et d'exemples sur mon [GitHub](https://github.com/behej/Qt-tips/tree/main/QtQml)

# Introduction - Divers
* Visualiser un fichier qml sans besoin de compiler
```
qmlscene <fichier.qml>
```

* Exécuter un fichier qml comme si c'était un exécutable: ajouter un shebang
```sh
#! env qml
```

* Il s'agit d'un langage déclaratif: l'ordre d'écriture n'a pas d'importance. On peut tout à fait lier un élément avec une propriété qui n'apparait que plus bas dans le fichier.
* Ne pas confondre property binding (avec le symbole '`:`') et assignation (avec le symbole '`=`')
  * Dans la mesure du possible, préférer les properties bindings
  * Si on affecte une valeur à une propriété qui était liée, le lien (property binding) disparait et est remplacé par la valeur affectée
* Référer à l'élément parent: mot clé '`parent`'
* Il existe 2 syntaxes équivalentes pour plusieurs propriétés d'un même groupe

```qml
                     |   anchors {
 anchors.Top: ...    |       Top: ... 
 anchors.Left: ...   |       Left: ...
                     |   }

```

# Basic Elements
## Composants graphiques

|Item name|Rôle|Propriétés notables|Evènements notables|
|---------|----|-------------------|-------------------|
|Item|Element vide. Sert uniquement de container |x, y, width, height | |
|Rectangle |Rectange | x, y, width, height, color | |
|Text | | | |
|TextInput | || |
|Image |Affiche une image issue d'un fichier | source, sourceSize |
|BorderImage |Comme image mais qui a la propriété particulière de s'étirer sans déformer les coins et les côtés | border {left, top, right, bottom}: définit les zones côtés et coins pour ne pas les déformer, horizontalTileMode/verticalTileMode: BorderImage.Stretch/Repeat/Round - politique d'étirement: étirer/répéter/répéter et étirer pour tomber sur un multiple pile | |
|AnimatedImage |Image animée (gif) | frameCount, currentFrame | |
|Gradient |Pour créer un dégradé de couleurs. Contient des balises GradientStop et une propriété orientation. | | |
|MouseArea |zone pour intéraction avec la souris. Comporte les évènement Ne pas oublier de définir une taille, voir mieux d'utiliser anchors.fill: parent |On peut aussi récupérer les propriétés de la MouseArea depuis les autres éléments en utilisant `<mouseAreaId>.pressed/released/clicked` | onClicked, onPressed, onReleased, onPressAndHold, onHovered, ...  |


## Gestures

| Composant | Description |
|-----------|-------------|
|Flickable |zone dans laquelle on peut placer un élément qu'on peut déplacer |
|PinchArea |Zone pour zommer/dézoomer en pincant les doigts |
|MultiPointTouchArea |Permet de définir ses propres gestures |

# Properties
## Basic properties

| Propriété | Description |
|-----------|-------------|
| x, y |position à l'intérieur du parent |
| z | ordre d'apparition (plus z est grand, plus l'élément est au 1er plan) |
|width, height |dimensions |
|implicitWidth, implicitHeight |Dimensions par défaut du widget si les dimensions ne sont pas explicitement définies avec les propriétés width et height. |
|color |couleur (doit être indiqué entre quotes): "green", "blue", "steelblue", "lightblue", "#00000000" (alpha, red, gree, blue), "#000000" (red, gree, blue) |
|text |Texte à afficher |
|clip |empêche les éléments enfants de dépasser du parent (false par défaut) |
|opacity |Opacité - de 0.0 (transparent) à 1.0 (opaque) |
|scale |Facteur de mise à l'echelle. Attention: Les dimensions de l'item (width & height) restent inchangées, la mise à l'échelle est uniquement pour l'affichage. |
|rotation |Angle de rotation en degré dans le sens horaire. Le centre de rotation par défaut est le centre de l'objet |
|transformOrigin |Permet de redéfinir l'origine utilisée pour les transformations: Item.TopLeft / Item.BottomRight / Item.Center / Item.Top / Item.Left / etc |
| gradient |Un élément de type Gradient |

### Interractions avec le clavier


| Propriété | Description |
|-----------|-------------|
|focus |true/false: active le focus sur l'élément concerné quand l'élément parent prend le focus. La propriété activeFocus permet de savoir si l'élément a le focus (pour changer d'autres propriétés - couleur, etc). A combiner avec un item 'FocusScope' pour que le comportement soit correct lorsqu'on crée des composants réutilisables. |
|activeFocusOnTab |true/false: Accepte de prendre le focus lors d'un appui sur TAB |
| KeyNavigation.right: \<widgetID\> |Indique quel élément doit prendre le focus si la touche 'droite' est appuyée |
|Keys.onLeftPressed |Signal lorsque la touche 'gauche' est appuyée. N'existe que pour une sélection de touches. Pour toutes les touches, utiliser Keys.onPressed. **Note:** ce n'est pas une propriété d'un Item, mais une '*attached property*' |
|Keys.onPressed(KeyEvent event) |Signal lorsqu'une touche (n'importe laquelle) est appuyée. le signal fournit un objet event dans lequel l'id de la touche est donné |

## Property binding
Il est possible de définir la valeur d'une propriété en fonction d'une autre propriété (soit directement, soit avec des calculs)

```qml
width = height    // la largeur est égale à la hauteur
width = height * 2   // La largeur est égale au double de la hauteur
```
On peut également faire référence à d'autres éléments
```qml
width = parent.width / 2    // Largeur est égale à la moitié de la argeur du parent
width = <otherItemId>.width   // Largeur identique à celle d'un autre élément
```

## Positionnement
Plusieurs façons de positionner les widgets
* Manuellement avec les positions x et y - déconseillé
* anchors layout
* Row, Column & Grid
* RowLayout, ColumnLayout & GridLayout

### Anchors layout
On peut ancrer chacun des 4 côtés d'un objet par rapport à d'autres (parent inclus)
```qml
anchors.left: <widgetId>.right   // Le bord gauche de l'objet est aligné avec le bord gauche d'un autre objet (fonctionne également avec 'parent')
```


**Note:**
* les ancrages existant sont : left, right, top, bottom
* l'ancrage est prioritaire par rapport aux positions x et y (et également les dimensions width et height si l'ancrage à un rôle sur la taille)

On peut spécifier des marges en plus de l'ancrage
```qml
anchors.left: <widgetId>.right
anchors.leftMargin: 10    // Un ancrage est présent à gauche mais avec une marge de 10 pixels
```

On peut aussi définir un ancrage pour centrer un objet
```qml
anchors.verticalCenter: <itemId>.verticalCenter   // notre item est centré verticalement sur un autre
anchors.horizontalCenter: 20   // centrage horizontale sur une valeur particulière
anchors.baseline: <value>   // la baseline est utile pour le text. il correspond à la ligne de base de caractères (sous le 'a'. Le 'g' dépasse sous la baseline)
```

On peut centrer un objet dans un autre
```qml
anchors.centerIn: <itemId>
```

On peut définir un objet qui doit remplir un autre
```qml
anchors.fill: <itemId>
```

**Note:**
* peut être combiné avec les margins
* la propriété anchors.margins est équivalent à spécifier les 4 marges avec la même valeur en une seule instruction

### Row, Column, Grid
* Les éléments sont disposés en ligne, colonne ou grille
* Ces éléments doivent également être ancrés à leur parent
* la propriété *margin* permet de définir l'espace entre les éléments


### Layouts
* RowLayout, ColumnLayout, GridLayout
* Généralement, le layout est positionné pour occuper tout le parent (`anchors.fill: parent`)
* Les layout possèdent quelques propriétés (telle que *margin*)
* Les items sont arrangés selon le layout choisi. c'est le layout qui redimensionne les items
* chaque item peut positionner des propriétés liées au layout
* `Layout.fillWidth / Layout.fillHeight`: l'item utilise toute la largeur/hauteur du layout
* `Layout.minimumWidth / Layout.minimumHeight / Layout.maximumWidth, Layout.maximumHeight`: spécifie les dimensions min/max de l'item
* `Layout.preferredWidth / Layout.preferredHeight`: Dimensions préférée
* `Layout.alignment: Qt.AlignTop | Qt.AlignRight` (etc.): positionne l'item dans le layout
* `GridLayout` possède quelques propriétés supplémentaires
  * rowSpan et columnSpan: pour étendre un item sur plusieurs lignes/colonnes
  * Les items sont placés selon l'ordre de déclaration. Mais on peut forcer un item à une place particulière avec les propriétés Layout.row et Layout.column

## Transformations
* On peut soit utiliser les propriétés rotation, scale, opacity pour les transformations simple
* Ou on peut utiliser la propriété tranform pour une ou plusieurs transformations plus complexes

```qml
transform : [
    Rotation {
        origin.x: <val>; origin.y: <val>
        angle: <angle>
    },
    Scale {
    },
    Translate {
    },
    Matrix4x4 {     // Permet des transformations plus poussées
    }
]
```

## Animations
* Plusieurs syntaxes existantes pour les animations
  * Animation on `<property>`
  * Animation en spécifiant la cible
  * Utilisation des Behavior
* Il existe plusieurs types d'animations
  * NumberAnimation
  * ColorAnimation
  * SpringAnimation
  * RotationAnimation
  * PauseAnimation
  * PathAnimation: pour qu'un élément se déplace selon un parcours prédéfini
  * Flippable: Pas réellement une animation, mais un objet qui a 2 faces différentes et qu'on peut retourner comme une carte (Animation rotation selon l'axe z)
  * SequentialAnimation: contient plusieurs animations et les exécute l'une après l'autre)
  * ParallelAnimation: contient plusieurs animations et le exécute en même temps
  * ...


### Syntaxes
**Animation on *\<property\>***
```qml
NumberAnimation on width {
    from: 10; to: 100
    duration: 1000
}
```

**Animation**
```qml
RotationAnimation {
    target: myItem
    property: rotation  // variante: ''properties'' suivi d'une liste de plusieurs propriétés
    from: 0; to: 180
    duration: 2000
    running: true    // propriété accessible par les autres widgets pour démarrer/arrêter l'animation à la demande
}
```

**Behavior**
Le comportement à adopter dès que la propriété x change: La transition de la valeur se fait selon une *SpringAnimation*
```qml
Behavior on x { SpringAnimation {} }
```


## States & Transitions
* Les states permettent de définir une sortie de machine d'état. Dans chaque état, on peut spécifier des propriétés particulière pour chaque élément.
* Les transitions (optionnelles) permettent de définir les animations à appliquer lors d'un changement d'état.

### States
* On peut définir autant d'état que l'on souhaite
* dans chaque état, on peut appliquer des propriétés spécifiques. Si une propriété n'est pas spécifié, c'est la valeur par défaut qui s'applique (valeur spécifiée dans l'élément hors des states
* Si aucun state actif, les propriétés par défaut s'appliquent
* 2 façons d'activer les états
  * avec la propriété `state`. Il faut affecter le nom de l'état souhaité. Cela impose d'avoir une mécanique qui positionne la propriété `state` avec la valeur souhaitée
  * avec la propriété `when` de chaque state. Lorsque la condition devient vraie, le state est activé. Il ne doit y avoir qu'un seul state actif à la fois

```qml
state: "initialState"   // définit le state actif au démarrage. Si omis, aucun state actif. Les propriétés par défaut sont appliquées
states: [      // Liste de tous les state
    State {
        name: "stateA"        // Aucune condition d'activation. L'état doit être activé en gérant manuellement la propriété state="StateA"
        PropertyChanges { target: <elementId>; <property>: <value> }   // 
        PropertyChanges { ... }
    },
    State {
        name: "stateB"
        when: <condition to activate>    // l'état devient actif lorsque la condition est vérifiée
        PropertyChanges { ... }
    }
]
```

### Transitions
* On peut ajouter des transitions entre les states
* les transitions servent à ajouter des animations pour que la transition d'un état à l'autre soit moins abrupte
* On peut utiliser n'importe quelle animation
* Particularités sur les animations
  * le plus logique est que l'animation porte sur une propriété qui change d'un state à l'autre (même si ce n'est pas obligatoire, on est libre de faire ce qu'on veut)
  * on peut spéficier une target ou plusieurs avec la propriété `targets: [...]`
  * si la propriété *from* est omise, on utilise les valeurs actuelles de l'élément (ex: un déplacement depuis la position où se trouve actuellement l'élément)
  * la propriété *to* peut être omise si la valeur finale est définie dans l'état d'arrivée

```qml
transitions: [
    Transition {
        from: "stateA"; to: "stateB"
        reversible: true      // transition de stateA vers stateB, et inversement
        PropertyAnimation { ... }    // N'importe quel animation avec les propriétés sur lequelles appliquer l'anim
    },
    Transition {
        from: "*"; to: "*"    // transition de n'importe quel état, vers n'importe quel état. Cette ligne peut être omise
        PropertyAnimation { ... }
    }
]
```


# Composants spéciaux
## Loader
* Charge dynamiquement un composant lorsque c'est utile (sur propriété `active: true`). Lorsque **active** devient faux, le composant est déchargé de la mémoire.
* Charge soit un composant avec **sourceComponent** ou un fichier qml avec **source**
* A utiliser avec **Binding** et **Connections**, surtout dans le cas où on charge des fichiers qml.

## Repeater
* Instancie le **delegate** selon un **model**
* Plutôt utile si le Repeater est placé dans un Layout
* Use case le plus simple: model est défini par une valeur numérique -> le délégate est répété autant de fois qu'indiqué
* numéro d'instance du delegate accessible via `model.index`
```qml
Repeater {
    model: <n>
    delegate : <Element> {
        <propriété>: model.index
    }
}
```


* Alternative use case: **model** est une liste d'éléments -> le délégate est répété autant de fois qu'il y a d'éléments dans la liste
```qml
Repeater {
    model: ["red", "blue", "green", "yellow"]
    delegate: Rectangle {
        color: model.modelData    // la valeur de chaque élément de la liste
    }
}
```

* utilisation avec une liste

```qml
ListModel {
    id: nameModel
    ListElement { name: "foo"; age: 42}     // Chaque élément de la liste est une sorte de dictionnaire
    ListElement { name: "bar"; age: 33}
}
 
Component {
    id: nameDelegate
    Text: model.name + "/" + model.age            // on accède aux données du model. Selon les clé du dictionnaire qu'on a choisi
}

Column {
    Repeater {
        model: nameModel
        delegate: nameDelegate
    }
}
```

## ListView
* Le **Repeater** ne fait qu'instancier plusieurs éléments. Certains éléments peuvent être en dehors de la fenêtre. La **ListView** est un élément qui affiche une liste.
* Le principe de fonctionnement est similaire au Repeater: un model et un delegate
* La ListView peut afficher soit un model défini directement dans le qml (ListModel) ou un model défini dans le code C++ (QAbstractItemModel or QAbstractListModel et fonctionne également avec les proxyModel)
* La ListView peut être scrollée pour afficher la suite ou le début de la liste
* Les éléments sont instanciés/détruits s'ils doivent être affichés ou non (uniquement si clip: true)
* Pour créer un delegate qui soit aussi réutilisable que possible, il faut référer à la listView (pour accéder au currentIndex par ex) en utilisant la propriété attachée `ListView.view`. Créer une propriété au niveau top level qui réfère ListView.view
```qml
ListView {
    model: <model>
    delegate: <delegate>
    clip: true        // n'instancie que les éléments devant être affichés
    cacheBuffer: <n>   // (optionnel) taille en pixel de la zone non visible avant et après qui doit être chargée en cache même si non affichée
    onCurrentIndexChanged: ...    // signal émis lorsque l'index courant ''currentIndex'' est modifié. Le currentIndex peut être modifié par le delegate, lors d'un clic souris par ex
    orientation: Qt.Horizontal
    layoutDirection: Qt.LeftToRight  / verticalLayoutDirection: Qt.TopToBottom
    highlight: <Element>  // permet de crééer un élément affiché sur l'élément courant (position z=0 par défaut -> en arrière plan)
}
```

# Créer des composants personnalisés
* Soit avec le type 'Component'
* Soit en créant un fichier par composant
  * le nom du fichier est le nom du composant
  * le fichier doit commencer par une majuscule
* Le composant doit contenir un seul élément racine (autant d'éléments enfants qu'on souhaite)
* On ne peut accéder qu'aux propriétés du composant racine. On ne peut pas accéder aux propriétés des éléments enfants
* Pour que le composant soit standard et puisse être réutiliser, ne pas oublier de spécifier les propriétés ''implicitWidth'' et ''implicitHeight'' pour éviter que le composant ait une taille nulle si les dimensions ne sont pas explicitement spécifiées.
* On peut définir des propriétés pour notre composant
  * Ces propriétés peuvent également servir de variables locales
  * l'attribut 'readonly' permet d'éviter d'écraser malencontreusement la propriété par une assignation
```qml
[readonly] property <type> <nom> [: <value>]
```
* Si on veut rendre accésssible une propriété d'un élément enfant à l'extérieur du composant, il faut créer un ***alias***
```qml
property alias <nom>: <childItemId>.<property>
```
* Ajouter une fonction au composant
  * pas forcément la meilleure conception d'utiliser des fonction
  * s'ajoute dans l'élément racine du composant
  * se code en javascript
  
```java
function <doSomething>() {
    code
    ...
}

// Appel de la fonction sur le composant
<myItem>.<doSomething>()
```


* Ajouter des signaux au composant
  * `signal <nomDuSignal>`
  * l'action à réaliser sur réception du signal dans le handler `onNomDuSignal`
  * on peut passer une ou plusieurs variables

```qml
signal <name> [(<type> <name>), ...]

signal checked(bool checkValue)

// handler
onChecked:
```


# Interaction C++/QML
## Affichage dans le QML des données C++
* Ajouter l'objet au contexte

## Instanciation d'un objet C++ dans le QML
* la classe doit dériver de QObjet ou QQuickItem
  * macro Q_OBJECT
* enregistrement de la classe avec qmlRegisterType
  * `qmlRegisterType<NomClasse>("NomComposant", 1, 0, "NomObjet")`
  * NomComposant est utilisé pour l'import dans QML avec la version indiquée (ici 1.0)
  * Dans QML, on instancie un objet avec le nom indiqué NomObjet. Généralement NomComposant = NomOBjet (mais pas obligé)
* Import dans QML
  * import NomComposant 1.0
* Utilisation
  * Utilisation de NomObjet comme n'importe quel élément QML
  * On accède aux propriétés: attributs de la classe C++ déclarés avec Q_PROPERTY
  * On peut accéder/utiliser les signaux et slots de la classe C++
  * On peut appeler des méthodes sur la classe: méthodes déclarées avec Q_INVOKABLE

### Objet C++ capable de s'afficher à l'écran
* Même principe que ci-dessus
* La classe doit dériver de QQuickPaintedItem
  * La classe peut dériver de QQuickItem: plus performant mais bcp plus compliqué à implémenter (peut prendre plusieurs semaines vs. 1-2 jours)
* La classe doit ré-implémenter la méthode **paint** pour spécifier comment s'afficher à l'écran
* Gestion des évènements via la méthode `event(QEvent* ev)` ou par une des méthodes spécialisée pour chaque type d'event (mousePressEvent, mouseReleaseEvent, touchEvent, scrollEvent, etc.)
