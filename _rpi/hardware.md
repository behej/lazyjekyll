---
title: Hardware
layout: default
icon: raspberrypi.png
---
# Wifi TP-Link TL-WN725N
> 💡 Surtout utile pour les vieux Raspberry 1, sans module wifi

source : [http://vincent-delmaestro.fr/blog/connecter-un-raspberry-pi-en-wifi/](http://vincent-delmaestro.fr/blog/connecter-un-raspberry-pi-en-wifi/)

## Installer les drivers
Pour les versions de Kernel 3.10.x

```sh
cd ~
wget {{site.url}}/assets/files/8188eu_31024_614.zip
unzip 8188eu_31024_614.zip
sudo cp 8188eu.ko /lib/modules/`uname -r`/kernel/net/wireless
sudo cp rtl8188eufw.bin /lib/firmware/rtlwifi
sudo depmod -a
sudo modprobe 8188eu
```

## Configurer le Wifi
Editer le fichier `/etc/network/interfaces`

```sh
iface lo inet loopback
iface eth0 inet dhcp
 
auto wlan0
iface wlan0 inet dhcp
   wpa-ssid <Nom_De_La_Box>
   wpa-psk <Cle_De_Securite>
```

# Ecran 3,5" TFT sur GPIO

## Installer les drivers
```sh
git clone https://github.com/goodtft/LCD-show.git
chmod -R 755 LCD-show
cd LCD-show/
sudo ./LCD35-show
```

## Retourner l'écran
On peut retourner l'écran pour adapter l'affichage selon l'orientation du RPi

```sh
cd LCD-show
./rotate.sh 180
```

## Afficher une image sur l'écran
Le serveur graphique est rattaché à la session qui démarre en local sur le raspberry (celle qui affiche le bureau sur l'écran), alors que les sessions ssh n'ont pas de serveur graphique.

Si on veut afficher une image depuis une session ssh, il faut indiquer quel écran et quel serveur graphique utiiser.

```sh
export DISPLAY=:0
export XAUTHORITY=/home/pi/.Xauthority
feh --fullscreen /path/to/my/image.jpg &
``` 


