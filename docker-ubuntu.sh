#!/bin/bash

# Atualize o índice de pacotes
sudo apt update

# Instale as dependências para adicionar um repositório via HTTPS
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Adicione a chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Adicione o repositório do Docker às fontes APT
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Atualize o índice de pacotes novamente
sudo apt update

# Instale o Docker CE (Community Edition)
sudo apt install -y docker-ce

# Verifique se o Docker foi instalado corretamente
sudo docker --version

# Opcional: Adicione seu usuário ao grupo docker para evitar usar sudo
sudo usermod -aG docker $USER

# Avisar ao usuário para fazer logout e login novamente para aplicar as alterações do grupo
echo "Por favor, faça logout e login novamente ou execute 'newgrp docker' para aplicar as alterações do grupo."
