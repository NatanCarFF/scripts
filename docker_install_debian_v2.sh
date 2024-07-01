#!/bin/bash

# Atualiza o sistema
sudo apt update
sudo apt upgrade -y

# Instala dependências necessárias
sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common

# Adiciona a chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# Adiciona o repositório Docker ao apt sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Instala o Docker Engine
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Inicia o serviço do Docker e o habilita para iniciar na inicialização
sudo systemctl start docker
sudo systemctl enable docker

# Verifica a instalação do Docker
docker --version

# Opcional: Adiciona o usuário atual ao grupo Docker para executar comandos sem sudo
sudo usermod -aG docker $USER
echo "Script concluído. É recomendado fazer logout e login novamente para aplicar as alterações."
