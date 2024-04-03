#!/bin/bash

# Verifica se o Snap está instalado
if ! command -v snap &> /dev/null; then
    echo "Snap não está instalado. Instalando Snap..."
    sudo apt update
    sudo apt install snapd
fi

# Instala o Microsoft Teams via Snap
echo "Instalando o Microsoft Teams via Snap..."
sudo snap install teams-for-linux

# Exibe uma mensagem de conclusão
echo "Microsoft Teams foi instalado com sucesso."
