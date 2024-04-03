#!/bin/bash

# Adicionar a chave GPG do repositório do Microsoft Edge
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -

# Adicionar o repositório do Microsoft Edge ao sistema
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'

# Atualizar a lista de pacotes
sudo apt update

# Instalar o Microsoft Edge
sudo apt install microsoft-edge-dev
