#!/bin/bash

# Atualizando o sistema
echo "Atualizando o sistema..."
apt update && apt upgrade -y

# Verificando se o 'sudo' está instalado
if ! command -v sudo &> /dev/null
then
    echo "'sudo' não encontrado. Instalando..."
    # Instalando 'sudo' se não estiver presente
    apt install sudo -y
fi

# Adicionando a chave GPG do Docker
echo "Adicionando a chave GPG do Docker..."
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Adicionando o repositório do Docker
echo "Adicionando o repositório do Docker..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualizando os repositórios novamente
echo "Atualizando os repositórios..."
sudo apt update

# Instalando o Docker
echo "Instalando o Docker..."
sudo apt install docker-ce -y

# Verificando se o Docker foi instalado corretamente
echo "Verificando o status do Docker..."
sudo systemctl status docker --no-pager

# Testando o Docker
echo "Testando o Docker com o comando hello-world..."
sudo docker run hello-world

echo "Instalação concluída! O Docker está instalado e funcionando no seu sistema."
