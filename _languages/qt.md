---
title: Qt
layout: default
icon: qt.png
---
# Projet Qt
* le fichier .pro contient la configuration du projet
* il déclare les fichiers cpp utilisés (`SOURCES += fichier.cpp`). Cette déclaration est mise à jour automatiquement par Qt
* il déclare les fichiers h utilisés (`HEADERS += fichier.h`). Cette déclaration est mise à jour automatiquement par Qt
* il déclare les modules Qt utilisés: `QT += widgets`
* il déclare le nom de l'exécutable: `TARGET = nomDeLExe` (facultatif, par défaut le nom de l'exe correspond au nom du projet)
* il déclare la version de l'exécutable: `VERSION = 1.0.0.0`
* Lorsqu'on diffusera le logiciel, il faut penser à distribuer toutes les dll utilisées. Elles ne sont pas demandées tant qu'on exécuter le programme depuis l'IDE mais sont nécessaires lorsqu'on exécuter le .exe

# Créer une application
* inclure `<QApplication>`
* Créer un objet QApplication: `QApplication a(argc, argv);`
* Exécuter l'application: `a.exec();`

# Widgets
* un widget sans widget parent est considéré comme un fenêtre
* Pour créer une fenêtre, on peut créer un objet de la classe `QWidget`
* la classe `QMainWindow` permet de créer la fenêtre principale de l'application
  * La fenêtre principale peut contenir menus, barre d'état, barre d'outils, etc.

## Différentes classes de widgets
* Boutons
  * QPushButton
  * QCheckBox
  * QRadioButton (mutuellement exclusif avec tous les autres radioButtons qui possèdent le même parent. Il donc utile d'utiliser une GroupBox)

* QFont
* QIcon
* QSlider
* QLCDNumber
* QProgressBar
* QLabel (peut contenir du texte ou une image)

* Champs de saisie
  * QLineEdit (champ de texte à une seule ligne)
  * QTextEdit (champ de texte multi-ligne)
  * QSpinBox
  * QDoubleSpinBox
  * QComboBox
* Conteneurs
  * QFrame
  * QGroupBox
  * QTabWidget (chaque onglet ne peut contenir qu'un seul widget, il faut donc utiliser un conteneur ou un layout. On utilise la méthode `addTab` pour créer des onglets)

## Différentes méthodes

|Méthode|Effet|
|---|---|
| show() | Affiche le widget |
| *getter* | le nom de la méthode est identique au nom de l'attribut (ex: text() ). Quelques attributs intéressants: visible, enabled, height, width, size, cursor |
| *setter* | le nom de la méthode est set + nom de l'attribut (ex: setText() ) |
| setToolTip | Définit le texte du tooltip |
| setFont | définit la police utilisée |
| setCursor | Définit l'apparence du curseur lorsque la souris passe sur ce widget. On utilise des types prédéfinis comme `Qt::PointingHandCursor` |
| setIcon | Définit une icône |
| move | Définit la position d'un widget |
| setGeometry | Définit la position et la taille d'un widget |
| setMinimum/setMaximum/setRange | Définit la plage d'une valeur |
| setValidator | Met en place un contrôle de validité de la valeur saisie |

### Attributs spécifiques aux fenêtres
Les attributs qui commencent par window sont utilisables uniquement pour les fenêtres

Une liste non exhaustive
* windowFlags: options définissant le comportement de la fenêtres. Utilisation de l'énumération Qt::WindowFlags
* windowIcon: icône de la fenêtre
* windowTitle: titre de la fenêtre

# Layouts
## Principe de fonctionnement
1. Créer les widgets
2. Créer un layout et y placer les widgets
3.  Affecter le layout à la fenêtre

```cpp
// Création des widgets
QWidget* monWidget1 = new QWidget();
QWidget* monWidget2 = new QWidget();

// Création du layout
QLayout *layout = new QLayout(...);    // QLayout est une classe abstraite, on utilisera une de ses classes filles telle que QBoxLayout ou autre

// Ajout des widget au layout
layout->addWidget(monWidget1);
layout->addWidget(monWidget2);

// Association du layout à la fenêtre
maFenetre.setLayout(layout);
```

## Layout Box
* On utilise la classe QBoxLayout
  * On peut utiliser une variante verticale *QVBoxLayout* ou horizontale *QHBoxLayout*
* les éléments sont disposés les uns à coté des autres (ou les un sous les autres)


## Grid Layout 
* on utilise la class QGridLayout
* la fenêtre est divisée par une grille

|Col1|Col2|Col3|etc|
|----|----|----|---|
| 0, 0 | 0, 1 | 0, 2 | ... |
| 1, 0 | 1, 1 | 1, 2 | ... |
| 2, 0 | 2, 1 | 2, 2 | ... |
| ...| ...| ...| ... |

* Avec un GridLayout, la méthode addWidget peut admettre 2 argument supplémentaires: position y et position x
```cpp
layout->addWidget(&monWidget, posY, posX);
```
* Un widget peut occuper plusieurs cases. On spécifie 2 arguments supplémentaires: rowSpan & columnSpan
```cpp
layout->addWidget(&monWidget, posY, posX, hauteur, largeur);
```

## Layout de formulaire
* On utilise la classe **QFormLayout**
* Utile pour les formulaires où on trouve des couples Libellé/champs de saisie
* Un layout de formulaire est analogue à un gridLayout à 2 colonnes: la 1ère colonne pour les libellés, la 2nde colonnes pour les champs
* la méthode pour ajouter un champ est **addRow**(libelle, widget);
  * Dans le libellé, on peut placer le symbole `&` devant une lettre pour définir cette lettre comme un **raccourci clavier**


## Combinaison de plusieurs layouts
* Un layout peut contenir des widget ou autre layout
* Pour ajouter un Layout à un autre layout, on utilise la méthode: **addLayout**. Elle se comporte comme addWidget

# Signaux et Slots

* 2 objets communiquent entre eux à l'aide des signaux et des slots
  * Un objet envoie un signal sur un slot d'un autre objet
  * Il faut *connecter* le signal du 1er objet au slot du 2nd objet
  * la méthode connect est une méthode statique de la classe QObject
 
**Ancienne syntaxe**
```cpp
QObject::connect(ptPremierObjet, SIGNAL(nomSignal), ptSecondObjet, SLOT(nomSlot));
```
**Nouvelle syntaxe**
```cpp
QObject::connect(ptPremierObjet, &ClasseEmettrice::nomSignal, ptSecondObjet, &ClasseReceptrice::nomSlot);
 ```

* Un signal peut être connecté à plusieurs slots
* Un signal peut être connecté à un autre signal
* Plusieurs signaux peuvent être connectés à un même slot
* Un signal peut être connecté à une lambda
* Il existe également la méthode **disconnect** pour dissocier un couple signal/slot (rarement utilisé)
* un signal peut transmettre des paramètres à un slot
  * seuls les types des paramètres sont déclarés
  * l'ordre des paramètres émis par le signal doit être le même qu   l'ordre des paramètres acceptés par le slot
  * un signal peut émettre plus de paramètres que ceux utilisés par le sl  t
* une application possède un objet global **qApp**
  * Cet objet possède (entre autres) un slot **quit()**. Ce slot termine l'application


## Slot personnalisé
* la déclaration de la classe doit commencer par le mot clé **Q_OBJECT**
  * Il faut exécuter `qmake` dès lors que ce mot clé est ajouté
* les slots sont déclarés dans la section `public slots:`
* un slot personnalisé est une méthode comme une autre

## Signal personnalisé
* un signal se déclare comme une méthode dans la section **signals:**
* Mais il ne faut pas écrire son implémentation
* Dans n'importe quelle méthode, lorsque les conditions pour générer le signal sont réunies, le signal est émis avec l'instruction **emit nomDuSignal();**

# Boites de dialogue
* une boite de dialogue possède le slot **exec()**


## Dialog Box
* Inclure la classe QMessageBox
* On utilise principalement les méthodes statiques
* Différents types de boites de dialogue:
  * QMessageBox::information
  * QMessageBox::warning
  * QMessageBox::critical
  * QMessageBox::question
* Personnalisation des boutons: on liste les boutons souhaités avec le séparateur `|`
  * QMessageBox::Yes, No, Cancel, Discard, Ok, Open, Apply, etc. (voir la doc)
* La méthode retourne le bouton appuyé

### Affichage des boutons dans la langue de l'OS
* Par défaut les boutons sont en anglais
* Il faut utiliser le code suivant dans le main
```cpp
#include <QTranslator>
#include <QLocale>
#include <QLibraryInfo>
...
QString locale = QLocale::system().name().section('_', 0, 0);
QTranslator translator;
translator.load(QString("qt_") + locale, QLibraryInfo::location(QLibraryInfo::TranslationsPath));
app.installTranslator(&translator);
```

## Input Dialog Box
* inclure la classe QInputDialog
* 4 méthodes statiques selon la valeur attendue:
  * QInputDialog::getText()
  * QInputDialog::getInteger()
  * QInputDialog::getDouble()
  * QInputDialog::getItem()

## Choisir une police
* inclure la classe QFontDialog
* on utilise la méthode statique **getFont**
* retourne un QFont, donc utilisable directement par un objet QFont

## Choisir une couleur
* inclure la classe QColorDialog
* on utilise la méthode statique **getColor**
* retourne un objet de type QColor
  * les widgets n'utilisent pas directement les QColor mais des QPalette.
  * Il faut donc passer par un objet QPalette intermédiaire sur leque   on applique la méthode setColor(QColor couleur)
  * Puis on applique la méthode setPalette sur le widget en utilisant l'objet QPalette

## Choisir un fichier/dossier
* inclure la classe QFileDialog
* on utilise les méthode statique suivantes:
  * QFileDialog::getExistingDirectory
  * QFileDialog::getOpenFileName
  * QFileDialog::getSaveFileName
* Toutes ces méthodes retournent un QString contenant le chemin complet du dossier ou du fichier

# Fenêtre principale
La fenêtre principale est un objet de la classe **QMainWindow**

## Sous-fenêtres
1. la zone centrale peut ne contenir qu'un seul document (**S**ingle **D**ocument **I**nterface)
  * La zone centrale ne peut qu'on contenir qu'un seul et unique widget (c'est lui devra ensuite contenir les layouts et autres widgets)
  * Le widget unique est ajouté à la zone centrale avec la méthode **setCentralWidget**(widget)


2. la zone centrale peut contenir plusieurs documents (**M**ultiple **D**ocument **I**nterface)
  * la fenêtre principale contient un unique objet de type **QMdiArea**
  * chaque document consiste en un widget (qui contient les layouts et autres widgets)
  * chaque document est ajouté au *QMdiArea* avec la méthode `QMdiArea::AddSubWindow(widget)`
  * la méthode **AddSubWindow** retourne un pointeur sur un **QMdiSubWindow**. Il peut être utile de conserver ce pointeur
  * on peut récupérer la liste de tous les documents avec la méthode **subWindowList**

## Menu
* La QMainWindow possède une méthode **menuBar()** qui retourne un pointeur sur un objet **QMenuBar**
* L'objet **QMenu** possède une méthode **addMenu(nomMenu)** qui ajout un nouveau menu. Elle retourne un pointeur sur le menu **QMenu** créé
  * On peut ajouter un menu à un autre menu pour créer des sous-menus
* Un élément de menu qui déclenche une action est un objet **QAction**
  * On crée une action (`new QAction("nomAction", this)` puis on l'ajout à un menu avec la méthode **QMenu::addAction**
  * On crée directement l'action sur le menu, ce qui renvoie un pointeur sur l'action nouvellement créée
* L'objet QAction peut être connecté à des slots afin de générer les actions correspondantes (on utilisera notamment le signal **triggered**)
  * On peut ajouter un raccourci avec la méthode **setShortcut**. Une méthode pour créer un raccourci clavier est d'utiliser `QKeySequence("Ctrl+Q")`
  * On peut ajouter une icône avec **setIcon**
  * On peut rendre une action cochable avec la méthode **setCheckable**

## Toolbar
* La QMainWindow possède une méthode `addToolBar(nomToolBar)` qui ajouter une toolbar et retourne un pointeur sur l'objet **QToolBar** nouvellement créé
* Il faut ajouter des actions à la toolbar pour créer des boutons avec la méthode **addAction** de l'objet **QToolBar**
* on peut également ajouter des widgets aux toolbars avec la méthode **addWidget**
* on peut ajouter un séparateur avec la méthode **addSeparator()**

# Linguist
* Indiquer à Qt quelles chaînes sont à traduire:
  * Utiliser uniquement des QString
  * utiliser la méthode **tr("chaine")** pour indiquer que la chaîne donnée est à traduire
    * la méthode *tr()* est une méthode statique de la classe QObject, donc héritée dans quasiment tous les objets. Ecrire *QObject::tr()* si nécessaire
    * tr("chaine", "contexte") : Surcharge qui fournit un commentaire destiné au traducteur
    * tr("%n chaine(s) avec gestion du pluriel", "contexte", nombre) : Surcharge qui permet la gestion des singulier/pluriel dans toutes les langues
* Paramétrer le projet pour indiquer les différentes langues
  * Dans le fichier .pro, ajouter la ligne: `TRANSLATIONS = nomFichier_<langue1>.ts nomFichier_<langue2>.ts`
    * <langue> est le code de la langue sur 2 lettres: Français (fr), Anglais (en), etc.
* Générer les fichiers dictionnaire
  * exécuter la commande `lupdate nomDuProjet.pro` (accessible également depuis le menu 'Outils/Externe/Linguist')
* Traduire les dictionnaires avec Qt Linguist
  * ouvrir les fichiers .ts avec Qt Linguist
  * Traduire chaque chaîne de caractères
  * ne pas oublier de valider la traduction
  * exporter les dictionnaires avec la commande **publier**. Un fichier .qm est alors généré
* Charger le fichier de langue dans l'application
  * QTranslator translator;
  * translator.load("nomFichier_langue");
  * app.installTranslator(&translator);
* Détecter la langue du système
  * Récupérer le code langue (sur 2 lettres) du système : `QString locale = QLocale::system().name().section('_', 0, 0);`
  * Utilisation de ce code pour charger le fichier correspondant : `translator.load(QString("nomFichier_") + locale);`
  * **NOTE:** si on veut charger plusieurs fichiers de dictionnaire (par exemple, un pour les message de l'appli et un pour les chaine standards du type Yes, No, Cancel, etc.), il faut créer autant d'objet translator que de fichiers et les installer les uns après les autres

# Divers
* `QString("attr %1 et attr %2").arg("number 1").arg(3)` ==> "attr number 1 et attr 3"
* `qDebug() << "ma chaine de débug";`    Ecrit des traces dans le log en debug
* `#ifdef QT_DEBUG` : directive de compilation en mode debug
