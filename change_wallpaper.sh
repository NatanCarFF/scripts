#!/bin/bash

while true; do
    # Baixa uma imagem aleatória da internet para a pasta temporária
    wget -qO /tmp/wallpaper.jpg https://source.unsplash.com/random

    # Define a imagem baixada como papel de parede
    gsettings set org.gnome.desktop.background picture-uri "file:///tmp/wallpaper.jpg"

    # Espera 30 segundos antes de mudar o papel de parede novamente
    sleep 30
done
