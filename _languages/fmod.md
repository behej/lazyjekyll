---
title: FMOD
layout: default
icon: c.svg
---
# Déclarations
```c
FMOD_SYSTEM *system     // Déclaration d'un objet système: Utile dans tout le programme pour paramétrer la lib
FMOD_SOUND  *tir        // Déclaration d'un objet 'son'
FMOD_CHANNEL *channel   // Déclaration d'un canal. Les canaux sont utilisés pour gérer le son (volume, pause, repétition, etc.)
FMOD_CHANNELGROUP *channelGroup     // Déclaration d'un groupe de canaux. Permet de manipuler simultanément plusieurs canaux.
```

# Initialisation
Allocation de l'objet systeme
```c
FMOD_System_Create(&system);
```
Initialisation de l'objet systeme
```c
FMOD_System_Init(system, nbMaxChannels, FMOD_INIT_NORMAL, NULL);
```

# Gestion des sons
Banque de sons: http://www.findsounds.com/

**Pour les sons courts**: on charge le son en mémoire en entier
```c
FMOD_System_CreateSound(system, "sounds/sparo2.wav", FMOD_CREATESAMPLE, NULL, &son);
```
* `FMOD_CREATESAMPLE`: indique qu'il faut décompresser tout le son à l'initialisation
* Retourne `FMOD_OK` si pas d'erreur

**Pour les sons longs (musiques, fonds sonores)**: le son n'est pas chargé en entier pour limiter l'utilisation mémoire. On privilégie le streaming
```c
FMOD_System_CreateSound(system, "sounds/sparo2.wav", FMOD_SOFTWARE | FMOD_2D | FMOD_CREATESTREAM, NULL, &musique);
```

Jouer le son
```c
FMOD_System_PlaySound(system, FMOD_CHANNEL_FREE, son, 0, NULL);
```
* `FMOD_CHANNEL_FREE`: laisse la lib choisir un channel libre

Libère la mémoire
```c
FMOD_Sound_Release(tir);
```

# Gestion des canaux
Récupération d'un canal
```c
FMOD_System_GetChannel(system, numChannel, &channel);
```

Récupération d'un groupe de canaux
```c
FMOD_System_GetMasterChannelGroup(system, &channelGroup);
```

**Volume**
```c
FMOD_Channel_SetVolume(channel, volume);
FMOD_ChannelGroup_SetVolume(channelGroup, volume);
```
* 0.0 <= volume < 1.0

**Répétition**
```c
FMOD_Sound_SetLoopCount(musique, nbRepetitions);
```
* Le nombre de répétitions ne tient pas compte de la lecture initiale. si nbRepetitions = 1, la chanson sera jouée 2 fois en tout.
* nbRepetitions = -1 : la chanson est répétée à l'infini

**Pause/Stop**
```c
FMOD_Channel_GetPaused(canal, &etat)        // Récupère l'état du/des canal
FMOD_ChannelGroup_GetPaused(canal, &etat)

FMOD_Channel_SetPaused(canal, etat)         // Active ou désactive la pause
FMOD_ChannelGroup_SetPaused(canal, etat)
```
* etat = 0 : lecture en cours
* etat = 1 : en pause

**Traitement du signal**
```c
FMOD_Channel_GetSpectrum(channel, tabFloat, nbValTab, channelOffset, FMOD_DSP_FFT_WINDOW_RECT);
```

Récupère l'analyse spectrale du son
* tabFloat: tableau de float dans lequel seront retournées les valeurs de l'analyse
* nbValTab: nombre de cases du tableau. Toujours une puissance de 2


# Arrêt
Arret et libération de la mémoire de l'objet systeme
```c
FMOD_System_Close(system);
FMOD_System_Release(system);
```
