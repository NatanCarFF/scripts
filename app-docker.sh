#!/bin/bash

# Atualiza o índice de pacotes do apt
sudo apt update

# Instala dependências para permitir que o apt utilize repositórios HTTPS
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Adiciona a chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Adiciona o repositório do Docker às fontes do apt
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Atualiza novamente o índice de pacotes do apt
sudo apt update

# Instala a versão do Docker CE (Community Edition)
sudo apt install -y docker-ce

# Verifica se o Docker foi instalado corretamente, verificando sua versão
docker --version

# Adiciona o usuário atual ao grupo "docker" para executar comandos Docker sem precisar de sudo
sudo usermod -aG docker $USER

echo "Docker instalado com sucesso. Você pode precisar fazer logout e login novamente para aplicar as alterações do grupo."
