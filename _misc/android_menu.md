---
title: Android - Menu
layout: default
icon: android.png
---
# Menu
1. Créer un menu (dans les ressources)
2. Ajouter le menu à l'activité
3. Gérer les actions lorsqu'on clique sur un item du menu

## Ajouter le menu à l'activité
Dans la classe de l'activité
```java
@Override
public boolean onCreateOptionsMenu(Menu menu) {
    getMenuInflater().inflate(R.menu.<id_menu_to_add>, menu);
    return true;
}
```

## Gérer les actions lorsqu'on clique sur un item du menu

Dans la classe de l'activité
```java
@Override
public boolean onOptionsItemSelected(MenuItem item) {
    switch (item.getItemId()) {
        case R.id.<id_menu_item1>:
            // do stuff
            break;
        case R.id.<id_menu_item2>:
            // do stuff
            break;
        default:
            break;
    }
    return true;
}
```