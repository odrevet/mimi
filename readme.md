# About

Mini Music Interface. Search and listen to your music using fuzzy search. 

Mimi has a minimal approach, so minimal that having a screen is optional.  

This setup is developed under void linux on a raspberry pi 1B

* Search for music: 
    - Only using a keyboard using fuzzy search
    - Connect via ssh 
    - From a Web API

# Init

* Set shell to bash
* Install packages
    - alsa-utils: sound driver
    - moc: music player using the console
    - fzf: fuzzy search for musics to play
    - sox: play bip sounds to inform the user when the system is up or when to type
    - mimic: text to speech used to read how musics found and other information's
    - lighttdp: web server to control and get info on playlist
    - jq: used for the API to format response into JSON
* qemacs: lightweight text editor for maintenance (personal preference)
* Create a user named `player` to play with unprivileged rights

```
chsh -s /bin/bash
/bin/bash
xbps-install -u xbps
xbps-install -Sy alsa-utils moc qemacs fzf sox mimic lighttpd jq
useradd -m -g audio player -s /bin/bash
```

# enable audio

uncomment `dtparam=audio=on` in `/boot/config.txt`

# Auto login

```
cp -R /etc/sv/agetty-tty1 /etc/sv/agetty-autologin-tty1
```

Edit `/etc/sv/agetty-autologin-tty1/conf` and change it to:

```
GETTY_ARGS="--autologin player --noclear"
BAUD_RATE=38400
TERM_NAME=linux
```

Log onto tty2 using `chvt2` and do
```
rm /var/service/agetty-tty1
ln -s /etc/sv/agetty-autologin-tty1 /var/service
```

# Changes to /etc/fstab

## Auto mount connected usb drive

```
/dev/sda1 /mnt auto defaults,nofail 0 0
```

## Desactivate fs check

Prevent the system to run the rescue shell.
As the raspberry is shutdown by cutting power using a switch.
In `/etc/fstab` set last value to 0

# Scripts 

The repo mimic how file needs to be organized on the host linux system


## .moc/config

Set driver and prevent stutter

## /etc/sudoers

Allow the system to be shutdown and run the webserver without a password


# Listen music using playlist.sh

First generate music_list.txt using `bash refresh_musics.list.sh` then: 

* using `bash readkeys.sh` press `f` or `F1`
* or using directly `bash playlist.sh FILTER`

# test API 

Set QUERY_STRING when call a script that accept params like this: 

```
cd /var/www
QUERY_STRING='action=next' /var/www/control.sh
```
