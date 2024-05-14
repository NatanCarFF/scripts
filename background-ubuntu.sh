#!/bin/bash

# Função para obter uma lista de URLs de imagens aleatórias dos destaques do Google
get_random_google_images() {
    local json_data=$(curl -s "https://www.google.com.br/?hl=pt-BR") # Faz o download da página inicial do Google
    local image_urls=$(echo "$json_data" | grep -oE '"ou":"([^"]+)' | sed 's/"ou":"//') # Extrai URLs das imagens dos destaques
    echo "$image_urls"
}

# Função para definir o papel de parede da área de trabalho com uma imagem aleatória
set_random_wallpaper() {
    local random_image_url=$(get_random_google_images | shuf -n 1) # Obtém uma URL de imagem aleatória
    gsettings set org.gnome.desktop.background picture-uri "$random_image_url" # Define o papel de parede
}

# Loop infinito para atualizar o papel de parede a cada 30 segundos
while true; do
    set_random_wallpaper
    sleep 30
done

