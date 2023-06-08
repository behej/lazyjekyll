---
title: Linux
layout: default
icon: linux.png
---
# Général
## 📂 Description du filesystem

|Dossier|Usage|
|---|---|
|/bin|Binaires essentiels pour le fonctionnement de l'OS|
|/boot/|Fichiers nécessaires au démarrage du système (inclus le kernel)|
|/dev/|Devices. Tous les périphériques sont représentés ici en tant que fichier texte|
|/etc/|Fichiers de configuration de différents aspects de l'OS ou de programmes|
|/home/|Répertoires home de tous les utilisateurs|
|/lib|Shared libraries pour bin et sbin|
|/opt/|Pour les programmes optionnels. Rarement besoin de naviguer dedans|
|/proc/|Processes. Ne correspond pas à de vrais fichiers ou des périphérique, mais est créé à la volée par l'OS pour tracker tous les processes exécutés.|
|/root/|Répertoire home de root|
|/sbin|System binaries. Binaires essentiellement destinés à être utilisé par root|
|/tmp/|Dossier temporaire. Est effacé à chaque redémarrage du système|
|/usr/bin/|Binaires destinés à l'utilisateur final de la machine|
|/usr/local/bin/|Binaires compilés manuellement et non gérés par le gestionnaire de paquets|
|/usr/local/lib/| Libs compilées manuellement et non gérées par le gestionnaire de paquets|
|/var/|Variables files. Fichiers utilisés par l'OS et les app pour stocker des infos en cours d'utilisation.|

## Flux de sortie des processus
Linux propose une sortie standard (stdout - 1), généralement affichage à l'écran. Et une sortie d'erreur (stderr - 2).

Par défaut, tout est affiché à l'écran. il est possible de rediriger ces sorties pour les ignorer ou les enregistrer dans des fichiers.

* `commande > fichier` : les 2 sorties (stdout et stderr) de la commande sont redirigées vers le fichier indiqué
* `commande 1> fichier` : la sortie standard (stdout) de la commande est redirigée vers le fichier indiqué
* `commande >> fichier` : la sortie standard est ajoutée à la fin du fichier
* `commande > /dev/null` : la sortie standard est redirigée vers le fichier NULL (la sortie n'est pas récupérée ni affichée)
* `commande 1>fichier 2>erreur` : la sortie d'erreur (stderr) est redirigée vers le fichier erreur
* `commande > fichier 2>&1` : la sortie stderr est redirigée vers stdout


## Gestion des processus
Lorsqu'on lance une commande dans le terminal, on ne récupère la main qu'à la fin de l'exécution de la commande. Pour les commandes un peu longues, il peut être intéressant de les lancer en arrière plan.
* `<commande> &` : exécute la commande en arrière plan
* **CTRL+Z** : interrompt la commande en cours
* `bg` : relance la commande interrompue en la basculant en arrière plan
* `jobs` : liste toutes les tâches qui tournent en arrière plan
* `fg %n` : ramène une tâche de l'arrière plan vers le premier plan (la valeur *n* est donnée par la commande jobs)

Les tâches en arrière plan restent quand même attachées au shell. Si on ferme le shell, les tâches sont arrêtées. On peut détacher une tâche du shell pour qu'elle s'exécute de manière autonome.
* `disown -h %n` : détache le job du shell. On peut remplacer *%n* par le pid de la tâche

# Commandes courantes

* **echo** \<texte\> : affiche le texte
  * -e : active l'interprétation des caractères d’échappement (\\)
  * -n : désactive le caractère LF à la toute fin du echo

* **cat** : concatène des fichiers et affiche le résultat
  * cat file : affiche le fichier
  * cat file* : concatène et affiche tous les fichiers correspondant au pattern
  * cat file1 file2 > file3 : concatène les fichiers 1 et 2 dans le fichier 3 (NB: fonctionne aussi avec des fichiers binaires)
* **wc** : compte le nb de lignes, mots et octets d'un fichier
  * wc -l : compte le nb de ligne uniquement
* **grep**
  * grep [options] \<pattern\> \<fichier\>
  * grep -nri
  * grep -a : Force le fichier lu comme un fichier texte
  * grep -v : Renvoie les entrées qui ne matchent PAS le pattern
  * -i : ignore case
  * -I : ignore les fichiers binaires
* **xargs**: Récupère l'entrée du process et l'utilise en tant qu'arguments de la commande (*exemple:* `cat file | xargs kill`)
* **hexdump** \<file\>: Affiche le contenu binaire d'un fichier (en hexa)
  * -v : affiche l'intégralité du fichier (sinon les paquets de lignes identiques sont représentés par une étoile)
  * -s \<nb\> : skip les \<nb\> premiers octets du fichier
  * -n \<nb\> : affiche uniquement \<nb\> octets
  * -e \<formatString\> : définit le format d'affichage. La syntaxe de la formatString est celle de printf.
    * *exemple 1* : `-e "%u\n"` : affiche les octets au format uint avec retour chariot après chaque octet
    * *exemple 2* : `-e 8/1 "%02X ""\t"` : Traite les octets par paquets de 8. Après chaque paquet de 8, on ajoute une TAB. Dans chaque paquet de 8, on traite les octets 1 par 1 et on les affiche sous la forme %02X, avec un espace juste après.
* **head**: affiche les premières ligne d'un fichier
  * head -*n*: affiche les *n* premières lignes d'un fichier
* **tail**: idem head mais affiche la fin d'un fichier
  * tail -f : affiche le fichier au fur et à mesure qu'il est mis à jour
* **find** \<starting_point\> \<criterias\> : trouve un fichier ou un dossier
  * find . -name "\<pattern\>" : Cherche les fichier et dossiers dont le nom matche le pattern (dans le dossier courant et ses sous-dossiers)
  * find . -iname "\<pattern\>" : Idem -name mais case insensitive
  * find . -type d : cherche les dossiers
  * find . -type f : cherche les fichiers
  * find . -mtime xx : cherche selon la date de modification
    * -mtime +30 : les fichiers dont la date de modification est "il y a plus de 30 jours"
    * -mtime -10 : les fichiers dont la date de modification est "il y a moins de 10 jours"
  * find . ctime xx : cherche selon la date de création
  * find . atime xx : cherche selon la date d'accès
  * find . -mmin +60 : les fichiers dont la date de modif est "il y a plus de 60 minutes"
    * existe également les variantes -amin, -cmin
  * find . -mindepth x : renvoie uniquement les fichiers qui sont dans des dossier d'une profondeur x ou plus
  * find . -maxdepth x : Profondeur max pour les fichiers retournés
  * find . -user \<user\> : cherche les fichiers appartenant à un user
  * find . -group \<group\> : cherche les fichiers appartenant à un groupe
  * find . -size +50M : cherche les fichiers de plus de 50MB
  * `find . ! <criteria>` : cherche les fichiers ne correspondant PAS au critère
  * `find . <criteria> -delete` : efface les éléments trouvés
  * `find . <criteria> -exec <command> {} +`  : execute la commande indiquée sur tous les éléments trouvés en une seule fois (à cause du `+`): exemple *chmod 666 file1 file2 file3*
  * `find . <criteria> -exec <command> {} \;`  : execute la commande indiquée sur chaque élément trouvé (la commande est répétée autant de fois que d'éléments trouvés, à cause du `;`): exemple *chmod 666 file1* puis *chmod 666 file2* etc.
  * find . -path "\<pattern\>": Cherche les dossier
  * find . -path "\<pattern\>" -prune -o -name
* **sed** *TODO*
* **cut** : Découpe une chaine de caractère selon un délimiteur spécifique
  * cut -d; : indique que la chaine doit être découpée à chaque fois qu'un point-virgule est rencontré
  * cut -f2,3 : Renvoie du 2ème au 3ème morceau (numérotation à partir de 1)
  * echo "a;b;c;d" | cut -d';' -f2,3 --> b;c
* **rev** : Renverse une chaine de caractère

## 🗜 Archives
* tar -cf archive.tar file1 file2 ... : compresse les fichiers dans une archive au format tar
* tar -czf archive.tar file1 file2 ... : compresse les fichiers dans une archive au format tar.gz
* tar -cjf archive.tar file1 file2 ... : compresse les fichiers dans une archive au format tar.bz2
* tar -xf archive.tar : extrait l'archive dans le dossier courant
* tar -xf archive.tar -C /path/to/target/dir : extrait l'archive dans un dossier partculier
* tar -tvf archive.tar : liste le contenu de l'archive
* tar -xzf archive.tar file1 file2 : extrait uniquement certains fichiers de l'archive

## Divers
* `pdfunite file1.pdf file2.pdf output.pdf` : concatène des fichiers pdf



# 🕞 Cron
Planification de tâches à heure ou intervalle fixe

```sh
min   hour   day   month  weekday  command
0     *      *     *      *        script   # toutes les heures: n'importe quelle heure, jour quand les minutes sont à 0
0     2      *     *      *        script   # tous les jours à 2h: n'importe quel jour, mois à 2h00
*/15  *      *     *      *        script   # toutes les 15 min
0     */4    *     *      *        script   # toutes les 4h
0     5      1     *      *        script   # tous les 1er du mois à 5h
```

Editer le fichier cron de l'utilisateur:
```sh
crontab -e
```

A noter qu'un fichier crontab général est existant dans le dosser `/etc/`. On peut également trouver des dossiers `/etc/cron.daily, hourly, ...` qui contiennent des scripts qui seront tous lancé périodiquement.

Faire attention à bien démarrer le service cron (cron deamon) `crond`

# Réseau


## Scan réseau
* **nmap** : scan réseau
  * `nmap <addr>` : scan uniquement les addresses spécifiées (nmap 192.168.0.1, nmap 192.168.0.0/24)
  * `nmap -sP <addr>` : détermine uniquement si les adresses sont en ligne
  * `nmap <addr> -p<port>` : scanne uniquement le port ou les plage de ports spécifiés (-p80 ; -p22,400-450)
* **netstat**: affiche les informations réseau détaillées

## Connexion SSH
* **ssh**: connexion ssh à un serveur distant
  * `ssh <login>@<address>` : connexion en tant que *login* au serveur indiqué par *address*
    * Si l'hôte est configuré avec une clé publique associée à une clé privée présente dans le dossier `~/.ssh/`, alors la connexion est autorisée.
    * Sinon, un mot de passe sera demandé
  * `ssh -i <path_to_private_key> <login>@<address>`: Utilise la clé privée indiquée pour l'authentification (note: le serveur doit être configuré avec la clé publique correspondante)


