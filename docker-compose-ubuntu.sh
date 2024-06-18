#!/bin/bash

# Defina a versão do Docker Compose que deseja instalar
DOCKER_COMPOSE_VERSION="2.19.1"

# Baixa o binário do Docker Compose para o diretório /usr/local/bin
sudo curl -L "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Aplica permissão de execução ao binário do Docker Compose
sudo chmod +x /usr/local/bin/docker-compose

# Cria um link simbólico para /usr/bin, caso seja necessário
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Verifica se o Docker Compose está instalado corretamente
docker-compose --version

# Mensagem de conclusão
echo "Docker Compose versão ${DOCKER_COMPOSE_VERSION} foi instalado com sucesso no Ubuntu."
