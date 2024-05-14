#!/bin/bash

download_dir="/home/natancarff/Imagens/background"

# Palavra-chave para a busca de imagens
keyword="landscape"  # Você pode alterar a palavra-chave conforme necessário

# Realiza a busca no Unsplash
search_url="https://unsplash.com/pt-br/s/photos/$keyword"
image_urls=$(wget -qO - "$search_url" | grep -o 'https://images.unsplash.com/.*?ixlib=.*?auto=format&fit=crop&w=.*?&q=.*?&cs=tinysrgb&crop=.*?&bg=.*?&ar=.*?')

# Baixa as imagens para o diretório especificado
for url in $image_urls; do
    wget -P "$download_dir" "$url"
done

# Seleciona aleatoriamente uma imagem para definir como papel de parede
wallpapers=($download_dir/*)
random_wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

# Define o papel de parede
gsettings set org.gnome.desktop.background picture-uri "file://$random_wallpaper"

echo "Papel de parede atualizado para: $random_wallpaper"

