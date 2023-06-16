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