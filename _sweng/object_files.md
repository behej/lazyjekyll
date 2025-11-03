---
title: Fichiers .obj
layout: default
icon: linux.png
---
# Introduction
Les fichiers object (`.o` ou `.obj`), les libraries (statiques `.a` ou dynamiques `.so`) ainsi que les binaires exécutables contiennent pas mal d'informations qui permettent d'en savoir plus sur eux. On parle de **table des symboles**.

# Analyse d'un fichier objet
## Lister les symboles

```bash
nm my_file.o

> output:
         U external_function
00000000 T internal_function1
00000000 T internal_function2
```

On obtient tous les symboles contenus dans le fichier
* 1ère colonne: adresse du symbole
* 2e colonne: le type
* 3e colonne: le nom du symbole

| Type | Description |
|:----:|-------------|
| U    | Undefined   |
| T    | Text - dans la section text, ce qui signifie que le symbole est définit et correspond à du code |
| t    | text - mais privé |
| W    | Weak |


### Options de la commande `nm`
* nm -A : affiche toujours le nom du fichier devant l'adresse (pratique lorsqu'on liste les symboles d'une lib qui regroupe plusieurs objets)
* nm -C : demangle des symboles
* nm -v : trier par nom
* nm -S : trier par taille d'objet
* nm -n : trier par adresse
* nm -r : inverse l'ordre
* nm -u : uniquement les symboles non définis
* nm -g : uniquement les symboles externes



