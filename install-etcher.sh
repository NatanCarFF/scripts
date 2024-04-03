#!/bin/bash

# Adiciona o repositório Etcher à lista de repositórios
echo "Adicionando o repositório Etcher..."
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list

# Adiciona a chave do GPG para o repositório
echo "Adicionando a chave GPG do repositório..."
sudo apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 379CE192D401AB61

# Atualiza a lista de pacotes para incluir o novo repositório
echo "Atualizando a lista de pacotes..."
sudo apt update

# Instala o Etcher
echo "Instalando o Etcher..."
sudo apt install balena-etcher-electron

echo "Etcher instalado com sucesso!"
