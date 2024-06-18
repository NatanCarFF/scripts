#!/bin/bash

# Atualiza a lista de pacotes
sudo apt-get update

# Instala os pacotes necessários para adicionar um novo repositório
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Adiciona a chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Adiciona o repositório Docker às fontes APT
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualiza a lista de pacotes novamente
sudo apt-get update

# Instala o Docker Engine
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Verifica se o Docker está instalado corretamente
sudo docker --version

# Adiciona o usuário atual ao grupo docker (opcional)
sudo usermod -aG docker $USER

# Reinicia a sessão para aplicar as mudanças no grupo (opcional)
newgrp docker

# Mensagem de conclusão
echo "Docker foi instalado com sucesso no Ubuntu."
