---
title: Yocto
layout: default
icon: yocto.png
---
# Intro
> ⚠️ **Règle d'or:** Ne jamais modifier les fichiers téléchargés

* Recipe: Recette pour builder qqch
* Layer: niveau d'organisation d'une distro. Un layer peut contenir plusieurs recettes. Un layer un globalement un dossier qui commence par le préfixe ''meta-''
* Recette d'image: liste des composants/layers pour une image

Pour modifier une recette, on ne modifie jamais les fichiers téléchargés mais on crée une surcharge en créant un ficher .bbappend

# Commandes
## Général
Initialisation de l'environnement: La 1ère fois: crée le sous-dossier et initialise l'environnement. Les fois suivantes: initialise l'env.
```sh
source poky/oe-init-build-env <build>
source poky/oe-init-build-env build-qemu/
```

## Layers
Affichage des layers
```sh
bitbake-layers show-layers
```

Ajout d'un layer existant
```sh
bitbake-layers add-layer <path/to/layer>
bitbake-layers add-layer ../meta-openembedded/meta-oe/
```

Création d'un nouveau layer
```sh
bitbake-layers create-layer <../meta-my-layer>      // Un layer commence par le préfixe 'meta-' (par convention)
bitbake-layers add-layer <../meta-my-layer>
``` 


# Mise en place
## Principe général
### Téléchargement des sources
```sh
mkdir yocto
cd  yocto/
git clone git://git.yoctoproject.org/poky -b hardknott
```

### Choix d'une version spécifique (par l'intermédiaire des tags)
```sh
cd poky
git checkout yocto-3.3.1
cd ..
```

### Initialisation de l'environnement
```sh
source poky/oe-init-build-env build-qemu
```

* Crée un dossier pour une cible donnée (ici l'émulateur) et se place dedans.
* La première fois, le script crée l'environnement car inexistant. Les fois suivantes, il se contente d'initialiser le PATH
* Cette commande doit être exécutée à chaque session de travail (pour màj le PATH)

### Création d'une première image
```sh
bitbake  core-image-minimal
IMAGE=qemuarm bitbake core-image-minimal
```

* Prend très longtemps la première fois. Plus rapide les fois suivantes.
* sans la variable IMAGE, l'image par défaut est générée (cf. ficher local.conf: IMAGE ??= "qemux86-64")
* avec la variable IMAGE, on peut sélectionner l'image souhaitée (cf liste des machines dispo dans local.conf)

On obtient les fichiers suivants, placés dans le dossier `tmp/deploy/images/qemux86-64/`
* core-image-minimal-qemux86-64.ext4: filesystem
* bzImage: noyau linux
* core-image-minimal-qemux86-64.qemuboot.conf: fichier de configuration de qemu

### Démarrer le simulateur
1. Installer qemu au préalable
```sh
sudo apt-get install qemu-system-x86    # pour x86
sudo apt-get install qemu-system-arm    # pour arm
```
2. Lancer le simu, à l'aide du script fourni par Yocto
```sh
runqemu qemux86-64
runqemu qemuarm
```

## Génération pour Raspberry Pi
### Ajout d'un layer
```sh
cd yocto
git clone git://git.yoctoproject.org/meta-raspberrypi -b hardknott
```
Crée un layer dans un dossier à côté de poky

### Initialisation
```
cd yocto
source poky/oe-init-build-env build-rpi
```

### Gestion des layers
```sh
bitbake-layers show-layers
```

Affiche les layers. On voit que la recette contient 3 layers (meta, meta-poky et meta-poky-bsp)

```sh
bitbake-layers add-layer ../meta-raspberrypi/
```

Ajoute le layer pour RPi. On peut voir le layer ajouté dans le fichier conf/bblayers.conf

### Compilation de l'image
```sh
MACHINE=raspberrypi4  bitbake  core-image-minimal
```

# Bibliographie
* [https://www.blaess.fr/christophe/yocto-lab/sequence-I-2/index.html](https://www.blaess.fr/christophe/yocto-lab/sequence-I-2/index.html)
