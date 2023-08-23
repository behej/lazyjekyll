---
title: Git
layout: default
icon: git.png
---
# Configuration
* git config \-\-global user.name "Sponge Bob"
* git config \-\-global user.email "sponge.bob@gmail.com"
* git config \-\-global alias.''cmd'' "my command \-\-with \-\-options"
  * git config \-\-global alias.co 'checkout'
  * git config \-\-global alias.br 'checkout'
  * git config \-\-global alias.st 'status'
  * git config \-\-global alias.lg 'log \-\-oneline \-\-graph'
  * git config \-\-global alias.amend 'commit \-\-amend \-\-no-edit'
* git config \-\-global core.editor 'vim' (ouu n'importe quel éditeur)

Les alias sont stockés dans le fichier ~/.gitconfig

# Status
* git status : affiche le statut courant (fichiers modifiés, synchro avec le remote, etc.)
* git branch : affiche la liste des branches dispos localement
* git fetch : mets à jours les infos de origin
* git log : affiche la liste des derniers commits
  * git log \-\-oneline : affiche chaque commit sur une seule ligne
  * git log \-\-graph : affiche les derniers commits sous forme de graphique
* git diff *\<old\> \<new\>* :
  * git diff *\<old\> \<new\>* \-\- *\<file\>* : Affiche les différences d'un fichier précis
  * git diff \-\-name-only
  * git diff \-\-word-diff=color : Affiche les différences sur une seule ligne avec la distinction par couleur
* git merge-base branche1 branche2 : indique l'ancêtre commun le plus récent des 2 branche. Ne fonctionne que si les 2 branches n'ont pas été mergées.

# Branches
* git branch : affiche la liste des branches dispos localement
* git checkout *\<branche\>* : Bascule sur la branche indiquée
* git checkout -b *\<branche\>* : crée la branche indiquée et bascule dessus
* git branch -d *\<branche\>* : Efface la branche si celle-ci a été mergée dans une autre branche
* git branch -D *\<branche\>* : Efface la branche même si celle-ci n'a pas été mergée dans une autre branche
* git branch -m *\<src\> \<dest\>* : move - déplace (ou renomme) une branche. -M pour l'option \-\-force (écrase la destination si déjà existante)
* git branch -c *\<src\> \<dest\>* : copy- Copie une branche. -C pour l'option \-\-force

# Commits
* git add *\<fichier\>* : ajout le fichier à la staging area
  * git add -i: Ajout de fichiers interractif (suivre les instructions)
  * git add -A: Ajoute tous les fichiers modifiés (y compris les nouveaux fichiers)
* git commit : commit les derniers changements
  * git commit -a : Ajoute tous les fichiers modifiés à la staging area et procède au commit
  * git commit -m "message" : Procède au commit avec le message de commit indiqué
* git checkout *\<fichier\>* : Annule tous les changements effectués sur le fichier indiqué
  * git checkout *\<branch\> \<fichier\>* : Récupère uniquement le fichier indiqué depuis la branche indiquée
* git pull : Rapatrie les derniers changements du repo et les merge dans la branche locale
* git push : pousse les derniers changements sur le repo distant
  * git push origin *\<hash\>:\<branche\>* : pousse uniquement les commits jusqu'au hash indiqué sur la branche distante. Permet de ne pousser qu'une partie et de garder en local les derniers commits.
* git merge *\<branche\>*: merge la branche indiquée dans la branche courante
  * git merge \-\-no-ff *\<branche\>* : Par défaut, git va tenter de rejouer tous les commits de la branche indiquée par dessus le HEAD de la branche courante (cette pratique s'appelle le fast-forward). Cela se produit notamment si la branche courante n'a pas évolué depuis que la branche de travail a été créée. L'option \-\-no-ff va forcer git a fusionner la branche indiquée dans la branche courante. On aura alors un 'true merge' et la branche créée restera visible.
* git revert *\<sha\>* : annule un commit
  * git revert -n/\-\-no-commit *\<sha\>* : modifie les fichier pour annuler un commit mais ne commit pas les changements
* git reset HEAD :Retire les fichiers de la staging area mais conserve les changements dans les fichiers
  * git reset \-\-hard: Annule les changement faits dans les fichiers
* git checkout *\<file\>* : Checkout le fichier indiqué depuis le HEAD et donc annule tous les changements effectués sur ce fichier
  * git checkout -p *\<file\>*: Annule les modifications effectuées sur le fichier mais en mode 'patch' (ie avec une interface permettant de sélectionner les morceaux de code à annuler ou non)
* git cherry-pick *\<sha\>* : applique le commit indiqué sur la branche courante
  * git cherry-pick A..B : cherry-pick tous les commits entre A et B (A exclu)
  * git cherry-pick A^..B : cherry-pick tous les commits entre A et B (A inclus)
* git commit \-\-amend: modifie le dernier commit. Les modifications présentes dans la staging area sont ajoutées au dernier commit. Si rien dans la staging area, permet au moins de modifier le message de commit
  * git commit \-\-amend -m "message": Indique directement le nouveau message de commit
  * git commit \-\-amend \-\-no-edit: Modifie le commit mais conserve le même message

# Rebase
## git rebase

Le principe est de *rejouer* les commits d'une branche mais en partant d'un nouveau point de départ. Ce qui a pour effet de déplacer la branche.
```sh
Avant
-----
A--B--C  (master)
    \
     D--E  (branche)

Après
-----
A--B--C
       \
        D'--E'
```

* git rebase -i origin: Rebase interactif de tous les commits locaux par rapport à l'origin. Permet de nettoyer l'historique avant un push sur le repo
* git rebase master *\<branche\>* : Si la branche master a évolué depuis qu'on a fait dérivé notre branche et qu'on veut faire repartir notre branche depuis le HEAD de master. Cette commande va 'rejouer' tous les commits de notre branche sur le HEAD du master
* git rebase *\<new_starting_point\> \<branche\>* : Version plus générique du rebase. On va rejouter tous les commits de notre branche à partir du nouveau point de départ indiqué (cela peut être un hash de commit, une branche, un tag)

## git rebase \-\-onto
Cette option permet de déplacer une branche même si elle-même partait déjà d'une branche dérivée.
 
```
Avant
-----
A--B--C--D--E  (master)
    \
     F--G--H--I  (branche_1)
               \
                J--K--L  (branche_2)

Après
-----
A--B--C--D--E  (master)
    \        \
     \        J'--K'--L'  (branche_2)
      \
       F--G--H--I  (branche_1)
```

* git rebase \-\-onto master branche_1 branche_2 : Déplace la branche_2 (depuis son départ de la branche_1) vers la branche master

# Patch
## Créer un patch
### format-patch
Se placer sur la branche, le commit ou le tag dont on veut créer un patch
* git format-patch *\<reference\>* \-\-stdout \> *\<file\>*.patch

```
A--B--C--D  (master)
    \
     E--F  (branche1)
```

* git checkout master && git format-patch HEAD~2 \-\-stdout > file1.patch : créer un patch avec les commits C et D
* git checkout branche1 && git format-patch master \-\-stdout > file2.patch : créer un patch avec les commits E et F

### diff
Utiliser la commande git diff pour établir les différences entre 2 commits/branches et rediriger la sortie dans une fichier. Ce fichier pourra être utilisé en tant que patch.
* git diff *\<commit1\> \<commit2\>* \> *\<file\>*.patch

Se reporter à la commande diff pour plus de détails.

## Appliquer un patch
* git apply \-\-stat *\<patch-file\>* : N'applique pas le patch mais affiche le nb de fichiers modifiés
* git apply \-\-check *\<patch-file\>* : N'applique pas le patch mais vérifie qu'il s'exécuterait correctement
* git apply *\<patch\>* : Applique le patch mais ne commit pas les changements
* git am \-\-signoff *\<patch-file\>* : Applique le patch et crée les commits associés avec l'identité de l'auteur du patch. Option signoff ajoute un message avec l'identité de celui qui a appliqué le patch.
  * Note: cette commande ne fonctionne qu'avec les patch créé à l'aide de la commande **format-patch**.

# Divers
* git reflog : affiche l'historique des dernière commandes
  * Utile pour annuler une action avec la commande: git reset HEAD@{*n*}
* git rev-parse *\<commit/branch/tag\>* : affiche le SHA1 du commit indiqué
* git rev-parse \-\-abbrev-ref HEAD : affiche le nom de la branche courante

# Bibliographie
* [https://delicious-insights.com/fr/articles/bien-utiliser-git-merge-et-rebase/](https://delicious-insights.com/fr/articles/bien-utiliser-git-merge-et-rebase/)
* [http://renaudmathieu.fr/creer-et-appliquer-un-patch-avec-git/](http://renaudmathieu.fr/creer-et-appliquer-un-patch-avec-git/)
* [https://www.devroom.io/2009/10/26/how-to-create-and-apply-a-patch-with-git/](https://www.devroom.io/2009/10/26/how-to-create-and-apply-a-patch-with-git/)
