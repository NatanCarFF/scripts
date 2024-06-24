#!/bin/bash

# Atualiza o índice de pacotes
sudo apt update

# Instala pacotes necessários para adicionar repositórios sobre HTTPS
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# Adiciona a chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# Adiciona o repositório do Docker ao sistema
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Atualiza o índice de pacotes novamente
sudo apt update

# Instala a versão comunitária do Docker (Docker CE) e Docker Compose
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose

# Verifica se o Docker foi instalado corretamente
docker --version

# Opcional: adiciona o usuário atual ao grupo docker para executar comandos Docker sem sudo
sudo usermod -aG docker $USER

echo "Instalação do Docker concluída."
