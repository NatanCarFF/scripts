#!/bin/bash

# Verificar se o script está sendo executado como root
if [ "$(id -u)" -ne 0 ]; then
  echo "Este script precisa ser executado como root. Por favor, use sudo."
  exit 1
fi

# Atualizar o sistema
echo "Atualizando o sistema..."
apt update && apt upgrade -y

# Instalar dependências (curl e sudo)
echo "Instalando dependências..."
apt install -y curl sudo

# Baixar a versão mais recente do Docker Compose
echo "Baixando o Docker Compose..."
DOCKER_COMPOSE_VERSION="v2.18.1"
curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Conceder permissões de execução ao binário do Docker Compose
echo "Concedendo permissões de execução..."
chmod +x /usr/local/bin/docker-compose

# Verificar se o Docker Compose foi instalado corretamente
echo "Verificando a instalação do Docker Compose..."
docker-compose --version

# Instalar bash-completion (opcional)
echo "Instalando bash-completion..."
apt install -y bash-completion

# Habilitar autocompletar no terminal para Docker Compose
echo "Habilitando autocompletar..."
echo "source /usr/local/bin/docker-compose-completion" >> ~/.bashrc
source ~/.bashrc

echo "Instalação do Docker Compose concluída!"
