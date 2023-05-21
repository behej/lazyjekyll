---
title: SDL
layout: default
icon: sdl.png
---
# Includes
```c
#include <SDL.h>          // inclusion de la lib SDL de base
#include <SDL_image.h>    // inclusion de la lib additionnelle SDL_image
#include <SDL_ttf.h>      // inclusion de la lib additionnelle SDL_ttf qui permet de manipuler du texte
```

# Types
## Types de la SDL

|Type|Description|
|---|---|
| `SDL_Surface *ecran;` | une surface 'ecran' qui correspond au fond. C'est sur l'écran que toutes les autres surfaces seront placées. |
| `SDL_Surface *rectangle;` | une surface rectangle pour dessiner |
| `SDL_Rect position;` | structure comprenant des coordonnées |
| `Uint32  couleur;` | une couleur est codée sur un type particulier |


# Fonctions de base
1. Initialisation de la SDL. Les options permettent de spécifier les modules à initialiser
    * `SDL_Init(SDL_INIT_AUDIO | SDL_INIT_CDROM | SDL_INIT_JOYSTICK | SDL_INIT_TIMER | SDL_INIT_VIDEO);`
2.  Initialisation complète
    * `SDL_Init(SDL_INIT_EVERYTHING);`
3. Initialisation individuelle d'un module après coup
    * `SDL_InitSubSystem(SDL_INIT_AUDIO);`
4. Initialisation de la lib TTF
    * `TTF_Init();` L'init de cette lib ne nécessite pas forcément l'init de la lib SDL au préalable. Elle peut être chargée indépendamment
5.  Affecter une icone au programme
    * `SDL_WM_SetIcon(surface, NULL);` La surface peut être initialisée par le chargement d'une image
6. Initialisation du mode vidéo. *Le résultat est un pointeur sur la surface du fond*
    * `ecran = SDL_SetVideoMode(int_resolution_horizontale, int_resolution_verticale, int_nb_bits_couleur, SDL_HWSURFACE | SDL_SWSURFACE | SDL_RESIZABLE | SDL_NOFRAME | SDL_FULLSCREEN | SDL_DOUBLEBUF);`
7. Changer le titre de la fenêtre
    * `SDL_WM_SetCaption("le titre de la fenêtre", NULL);`

# Gestion des surfaces
## Traitement des surfaces
Détermination d'une couleur à partir des composantes RGB

On a besoin du format utilisé pour les couleurs, ce format se récupère dans l'attribut format de l'*écran*
```c
couleur = SDL_MapRGB(ecran->format, int_rouge, int_vert, int_bleu);
```

**Remplissage d'une surface avec une couleur**
```c
SDL_FillRect(ecran, NULL, couleur);     // NULL: indique qu'on veut remplir l'ensemble de la surface
```

**Mise à jour de l'affichage**
```c
SDL_Flip(ecran);
```

## Ajout d'une surface
Création d'une nouvelle surface
```c
rectangle = SDL_CreateRGBSurface(SDL_HWSURFACE, int_largeur, int_hauteur, int_nb_bits_couleur, 0, 0, 0, 0):
```

Remplissage de la surface avec une couleur unie
```c
SDL_FillRect(rectangle, NULL, couleur);
```

**OU** chargement d'une image (la surface est automatiquement créée)
```c
rectangle = SDL_LoadBMP("mon_image.bmp");    // fonction standard de la lib (permet de charger uniquement des BMP)
rectangle = IMG_Load("mon_image.jpg");       // librairie additionnelle (permet de charge n'importe qu'elle image)
```

Gestion de la transparence pour une image BMP
```c
rectangle = SDL_LoadBMP("mon_image.bmp");
SDL_SetColorKey(rectangle, SDL_SRCCOLORKEY, couleur);   // la couleur indiquée devient alors transparente
SDL_SetAlpha(rectangle, SDL_SRCALPHA, int_transparence) // l'image est tranaparente. le niveau de transparence est variable de 0 à 255
```

Collage de la surface sur une autre
```c
position.x = coord_x;
position.y = coord_y;
SDL_BlitSurface(rectangle, NULL, ecran, &position);
```

# Gestion du clavier
Activation de la répétition des touches
```c
SDL_EnableKeyRepeat(int_temps_avant_1er_event, int_temps_entre_events_suivants);
```

# Gestion de la souris
Affichage/Masquage de la souris
```c
SDL_ShowCursor(SDL_DISABLE);
SDL_ShowCursor(SDL_ENABLE);
```

Déplacement de la souris
```c
SDL_WarpMouse(uint16_abscisse, uint16_ordonnee);
```

# Gestion des évènements
```c
SDL_Event   event;  // déclaration de la variable evenement

  // Récupération des évenements
  SDL_WaitEvent(&event);  // interrompte le programme jusqu'à ce qu'un évènement survienne
  SDL_PollEvent(&event);  // récupère l'évènement et continue

  switch  (event.type)
  {
      // Fermeture du programme
      //-----------------------
      case    SDL_QUIT:
          break;

      // CLAVIER
      //---------
      case    SDL_KEYDOWN:
      case    SDL_KEYUP:
          // Récupération de la touche actionnée
          switch  (event.key.keysym.sym)
          {
              case    SDLK_ESCAPE:
              case    SDLK_RETURN:
                  break;
          }
          break;

      // SOURIS
      //--------
      case    SDL_MOUSEBUTTONDOWN:
      case    SDL_MOUSEBUTTONUP:
          // récupération du bouton de la souris
          switch  (event.button.button)
          {
              case    SDL_BUTTON_LEFT:
              case    SDL_BUTTON_RIGHT:
              case    SDL_BUTTON_MIDDLE:
              case    SDL_BUTTON_WHEELUP:
              case    SDL_BUTTON_WHEELDOWN:
                  break;
          }
          // récupération des coordonnées de la souris
          abscisse = event.button.x;
          ordonnee = event.button.y;
          break;
      case    SDL_MOUSEMOTION:
          // récupération des coordonnées de la souris
          abscisse = event.motion.x;
          ordonnee = event.motion.y;
          break;

      // FENETRE
      //---------
      case    SDL_VIDEORESIZE:
          nouvelle_largeur = event.resize.w;
          nouvelle_hauteur = event.resize.h;
          break;
      case    SDL_ACTIVEEVENT:    // fenêtre activée ou desactivée
          gain_ou_perte = event.active.gain;  // =0 si fenêtre quittée / =1 si fenêtre activée
          if  ((event.active.state & SDL_APPMOUSEFOCUS) == SDL_APPMOUSEFOCUS)     // la souris rentre ou sort de l'écran
          if  ((event.active.state & SDL_APPINPUTFOCUS) == SDL_APPINPUTFOCUS)     // la fenetre gagne ou perd le 1er plan
          if  ((event.active.state & SDL_APPACTIVE) == SDL_APPACTIVE)             // nature de l'évenement
          break;
      default:
          break;
  }
```

# Gestion du temps
```c
// tempo
SDL_Delay(temps_en_ms);

// Récupération du temps total d'exécution
tempsEcouleDepuisDebut = SDL_GetTicks()

// Timer
SDL_TimerID     hTimer = 0;
hTimer = SDL_AddTimer(interval, callbackDuTimer, &parametres);
SDL_RemoveTimer(hTimer);
```


Fonction callback du timer
```c
Uint32 callbackDuTimer(Uint32 intervalle, void* params)
{
  // params est un pointeur sur void. On ne peut donc pas l'utiliser directement car on ne connait pas le type de données.
  type* donnees = (type*) params;    // le cast explicite est indispensable.
  ...
  return intervalle;    // doit impérativement retourner ''intervalle'' sinon le timer s'arrête
}
```

# Manipulation de texte (avec la lib TTF)
```c
int     tailleDeLaPolice = 22;
char*   cheminDeLaPolice = "arial.ttf"      // on a choisi ici de placer la police dans le répertoire du projet
                                            // on peut aussi faire référence à un chemin absolu
                                            // plus de polices sur www.dafont.com
SDL_Color   couleur = {0, 0, 0};        // Attention: ici on utilise des SDL_Color. Différent des SDL_MagRGB.


// définition d'un pointeur sur une police
TTF_Font    *police = NULL;

// Charger une police
police = TTF_OpenFont(cheminDeLaPolice, tailleDeLaPolice);


// Ecrire du texte à l'écran: la lib crée une surface qu'il faut blitter à l'écran
//---------------------------------------------------------------------------------

// Solid: méthode rapide mais sans anti-aliasing. Gère la transparence
TTF_RenderText_Solid(police, "texte a aficher", couleur);
TTF_RenderUTF8_Solid(police, "texte a aficher", couleur);
TTF_RenderUNICODE_Solid(police, "texte a aficher", couleur);
TTF_RenderGlyph_Solid(police, "texte a aficher", couleur);

// Shaded: méthode plus lente, avec anti-aliasing. ne gère pas la transparence
TTF_RenderText_Shaded(police, "texte a aficher", couleurFG, couleurBG);
TTF_RenderUTF8_Shaded
TTF_RenderUNICODE_Shaded
TTF_RenderGlyph_Shaded

// Blended: idem Shaded mais gère la transparence. Mais le blit sera plus long que shaded
TTF_RenderText_Blended
TTF_RenderUTF8_Blended
TTF_RenderUNICODE_Blended
TTF_RenderGlyph_Blended


// Modifier le style de la police
TTF_SetFontStyle(police, TTF_STYLE_NORMAL | TTF_STYLE_BOLD | TTF_STYLE_ITALIC | TTF_STYLE_UNDERLINE);

// Fermer la police ouverte
TTF_CloseFont(police);
```

# Libération des ressources
Libération de la mémoire allouée à une surface
```c
SDL_FreeSurface(rectangle);
```

Fermeture propre d'une partie des modules
```c
SDL_QuitSubSystem(SDL_INIT_AUDIO);
```

Quitter la lib TTF
```c
TTF_Quit();
```
 
Arrêt de la SDL. Cette commande libère aussi l'espace occupé par la variable 'ecran'.
```c
SDL_Quit();
```
