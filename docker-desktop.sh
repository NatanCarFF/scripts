#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Este script precisa ser executado com privilégios de superusuário (root)." 
  exit 1
fi

# Baixa o pacote Docker Desktop
echo "Baixando o pacote Docker Desktop..."
wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-desktop-4.30.0-amd64.deb

# Instala o pacote Docker Desktop
echo "Instalando o pacote Docker Desktop..."
dpkg -i docker-desktop-4.30.0-amd64.deb

# Resolvendo dependências (se necessário)
echo "Resolvendo dependências..."
apt-get install -f

# Inicia o Docker Desktop
echo "Iniciando o Docker Desktop..."
systemctl start docker

# Adiciona o usuário ao grupo docker
echo "Adicionando o usuário ao grupo docker..."
usermod -aG docker "$USER"

# Verifica a instalação
echo "Verificando a instalação do Docker..."
docker --version

echo "Instalação concluída com sucesso!"

