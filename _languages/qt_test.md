---
title: QTest
layout: default
icon: qt.png
---
> 📝 Issu du [tutoriel Qt](http://doc.qt.io/qt-5/qttestlib-tutorial1-example.html)

# Préparation
* Dans le fichier .pro :
  * ajouter la ligne `QT += testlib`
  * Si tests unitaires du GUI, ajouter `QT += widgets`

* Ajouter les includes
  * `#include <QtTest>`
* Créer une classe de test
  * héritée de QObject
  * avec la macro Q_OBJECT
  * chaque méthode de test doit être définie en tant que *private slot*
* remplace le *main* par `QTEST_MAIN(nom_classe_test)`
  * ou QTEST_APPLESS_MAIN si pas besoin de l'IHM

* Si la déclaration et la définition sont rassemblées dans un fichier cpp unique, ajouter la ligne `#include "nomFichierClasse.moc"`

# Tests unitaires non graphiques
## Tests simples
* Vérifier une assertion: `QVERIFY(assertion);`
  * exemple: `QVERIFY(maChaine.length() == 3);`
* Comparer 2 objets: `QCOMPARE(obj1, obj2);`
  * exemple: `QCOMPARE(maChaine.length(), 3);`

## Tests en lot
* une méthode qui réalise le test et une qui initialise les data utilisées pour le test
  * test: `MaClasse::nomTestCase()`
  * data: `MaClasse::nomTestCase_data()`
* Dans la méthode *_data*:
  * Initialiser un tableau qui contient toutes les données utiles pour le test. Créer toutes les colonnes nécessaire. Par exemple, 2 attributs et 1 résultat attendu.
    * `QTest::addColumn<type1>(nomAttribut1);`
    * `QTest::addColumn<type2>(nomAttribut2);`
    * `QTest::addColumn<typeResult>(nomResultat);`
  * Remplir ce tableau. 1 ligne par cas de test. Chaque ligne est identifiée par le nom du cas de test
    * `QTest::newRow("nomCasTest") << attribut1 << attribut2 << resultat;`
    * Le nombre d'éléments doit correspondre au nombre de colonnes déclarées
* Dans la méthode de test:
  * Récupérer les éléments nécessaires avec la directive QFETCH
    * `QFETCH(type, nomColonne);`
  * Exécuter les comparaisons pour le test
    * `QCOMPARE(objet.methodeATester(nomAttribut1, nomAttribut2), nomResultat);`
  * Qt exécute la comparaison pour toutes les lignes du tableau

### Exemple
```cpp
void Test::testCase_data()
{
    QTest::addColumn<QString>("chaine");        // Déclaration des colonnes du tableau
    QTest::addColumn<int>("longueur");

    QTest::addRow("longueur 5") << "Hello" << 5;        // Ajout d'un 1er cas
    QTest::addRow("longueur 13") << "Hello World !" << 13;       // Ajout d'un 2nd cas
}

void Test::testCase()
{
    QFETCH(QString, chaine);      // récupération des colonnes du tableau
    QFETCH(int, longueur);

    QCOMPARE(chaine.length(), longueur);      // le test est effectué pour toutes les lignes du tableau
}
```

# Tests unitaires de l'IHM
## Tests simples
* La classe QTest contient des méthodes statiques pour simuler des actions utilisateur. Utiliser ces méthodes pour simuler des actions sur le widget à tester
  * `QTest::keyClick(&widget, key)`
  * `QTest::keyClicks(&widget, keySequence)`
  * `QTest::mouseClick`
  * etc.
* Récupérer un attribut du widget et le comparer à l'attendu (avec **QCOMPARE** ou **QVERIFY**)

## Tests en lot
* une méthode qui réalise le test et une qui initialise les data utilisées pour le test
  * test: `MaClasse::nomTestCase()`
  * data: `MaClasse::nomTestCase_data()`
* Dans la méthode _data:
  * Initialiser un tableau qui contient toutes les données utiles pour le test. Une de ces colonnes pourra contenir des valeurs du type QTestEventList. Cette classe sert à créer des listes d'évènements utilisateur simulés.
    * `QTest::addColumn<QTestEventList>(evenements);`
  * Remplir ce tableau. 1 ligne par cas de test.

```cpp
QTestEventList maListe;
maListe.addKeyClick('a');
maListe.addKeyClick(Qt::Key_Backspace);
QTest::newRow(''cas1'') << maListe << ''resultat'';
```


* Dans la méthode de test:
  * Récupérer les éléments nécessaires avec la directive QFETCH
    * `QFETCH(QTestEventList, evenements);`
  * Simuler actions sur le widget
    * evenements.simulate(&widget);
  * Exécuter les comparaisons pour le test avec **QCOMPARE** ou **QVERIFY**
  * Qt effectue les séquences d’événements et les comparaisons pour toutes les lignes du tableau

# Benchmark
Permet de mesurer la durée d'exécution d'une ou plusieurs instructions
```cpp
QBENCHMARK {
    liste des instruction à benchmarker
}
```
