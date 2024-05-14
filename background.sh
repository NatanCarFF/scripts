#!/bin/bash

ubuntu_wallpapers_dir="/usr/share/backgrounds"

images=$(find "$ubuntu_wallpapers_dir" -type f \( -iname "*.jpg" -o -iname "*.png" \))

while true; do
    random_image=$(shuf -n 1 -e $images)
    gsettings set org.gnome.desktop.background picture-uri "file://$random_image"
    sleep 30
done
