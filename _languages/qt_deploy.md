---
title: Déploiement
layout: default
icon: qt.png
---
# Déploiement sous Windows
## Il est beau mon logiciel
Sous Windows, l'exécution de votre logiciel implique la présence des dll Qt. Ces dll sont plus ou moins nombreuses selon les fonctionnalités mises en oeuvre. Lorsqu'on exécute notre logiciel en passant par l'intermédiaire de notre IDE favori, le lien avec les dll requises est complètement transparent. Il en est tout autre lorsqu'on essaie de simplement double-cliquer sur le fichier .exe généré. En général, au lieu de voir apparaître sous nos yeux ébahis notre merveilleuse GUI, on se prend en pleine face un gentil petit message d'erreur nous indiquant qu'il manque une dll. Si vous avez de la chance, le message d'erreur vous indiquera gentiment quelle dll vous manque. Parmi les dll de base qui vous seront toujours réclamées, on retrouve notamment:
* des dll propres à Qt: Qt5Core, Qt5Gui, Qt5Widgets
* des dll propres à minGW: icudt53.dll, icuin53.dll, icuuc53.dll, libgcc_s_dw2-1.dll, libstdc++-6.dll, libwinpthread-1.dll


## Les aventuriers de la DLL perdu
S'ensuit alors une longue quête à la recherche de la dll perdue. On l'a tous déjà fait, on recherche la dll sur son poste, on la copie à côté de notre binaire. Bon c'était facile finalement, pas la peine d'en faire un article entier ! Allez, on double-clique sur l'exécutable. *Pan !* nouveau message d'erreur, encore une dll manquante. Aaah, mais c'est qu'il y en avait plusieurs. Et on recommence tant qu'il faut.

Quelques DLL copiées plus tard et quelques recherches Google pour les cas mystérieux - ben oui c'était pas explicitement marqué qu'il fallait un répertoire *'platforms'*. On arrive enfin à lancer notre logiciel et à s'amuser un peu avec notre GUI.


Bon c'était pas si insurmontable. Allez on copie tout ça sur une clé USB et on file le déployer sur autre PC. Un PC d'un utilisateur lambda, celui qui utilisera votre logiciel sans se soucier de comment il a été développé, en gros un PC sans Qt d'installé dessus et c'est surtout ça qui est important. Et là encore une fois, il y a de fortes chances d'obtenir un nouveau message d'erreur. En général, à ce stade là, on est hyper confiant, fier et impatient de pouvoir montrer notre travail à un proche. Ce même proche qui vous dira instantanément: *"ben, ça marche pas ton truc !"*. Gros moment de solitude, on repart avec sa clé USB entre les jambes direction Google pour trouver pourquoi ça marchait sur mon poste mais pas sur celui de mon pote. C'est vite réglé en général, mais c'est trop tard, on est passé pour un c**.


## La méthode facile
Mais savez-vous qu'il y a beaucoup plus simple comme méthode ?

Ben oui, c'est qu'ils ont tout prévu chez Qt. Ils nous ont concocté un petit utilitaire qui permet très facilement de récupérer l'intégralité des dll requises (même un peu plus en réalité) et tout ça en une seule action. Elle est pas belle la vie ?

Cet utilitaire s'appelle **windeployqt.exe**, il se trouve dans le dossier `<QTDIR>/bin/` et il se lance en ligne de commande.

Pour le lancer rien de plus simple:
* on s'assure déjà que `<QTDIR>/bin/` est bien dans le path de notre Windows
* on a préalablement compilé notre logiciel et l'exécutable se trouve dans le dossier `<PROJET>\release\`
* Idéalement, on a effectué un petit coup de nettoyage pour virer les .o et autres artefacts de compilation
* et enfin on exécute la commande `windeployqt.exe <PROJET>\release\`

Après quelques instants et quelques lignes dans la console plus tard, notre exécutable n'est plus tout seul, mais il a trouvé plein de copines dll pour s'amuser. On double clique que le binaire et ... oh miracle, notre logiciel se lance sans erreur.

Lorsque vous distribuerez votre logiciel, ce sont toutes ces dll et également les dossiers qu'il faudra distribuer en plus de votre exécutable.


## Un peu de customization
Bon cette ligne de commande c'est pas si mal, mais on va un peu l'affiner. Un petit tour dans l'aide avec 'windeployqt -h' pour faire un tour d'horizon des options disponibles. Perso, je vous conseille:
* `--release` : C'est toujours mieux d'indiquer qu'on est en release
* `--no-translations` : par défaut toutes les langues sont copiées. On va gérer cela à la main, ça sera mieux.
* `--force` : pour forcer l'écrasement des dll si certaines sont déjà présentes. Cela permet d'être certains qu'on déploiera les bonnes et nous évitera un nouveau moment de solitude.


Et voilà. Dernière étape pour en terminer avec tout cela. On ajoute l'exécution de windeployqt dans une étape de compilation de notre projet Qt. Ainsi, à chaque fois qu'on lance une compilation en release, l'étape de déploiement est automatiquement exécutée. Idéalement, on aura également intercalé une étape de nettoyage juste avant.
