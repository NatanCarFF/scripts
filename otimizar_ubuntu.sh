#!/bin/bash

# Atualizar o sistema
echo "Atualizando o sistema..."
sudo apt update
sudo apt upgrade -y

# Remover pacotes não utilizados
echo "Removendo pacotes não utilizados..."
sudo apt autoremove -y

# Limpar caches
echo "Limpando caches..."
sudo apt clean

# Instalar e configurar zram
echo "Instalando e configurando zram..."
sudo apt install -y zram-config

# Limitar serviços em segundo plano
echo "Limitando serviços em segundo plano..."
sudo systemctl list-unit-files --state=enabled
echo "Deseja desativar algum serviço? (S/N)"
read resposta
if [ "$resposta" == "S" ] || [ "$resposta" == "s" ]; then
    echo "Digite o nome do serviço que deseja desativar:"
    read servico
    sudo systemctl disable "$servico"
fi

# Instalar e executar htop
echo "Instalando e executando htop para monitorar recursos..."
sudo apt install -y htop
htop

# Desativar efeitos visuais
echo "Desativando efeitos visuais..."
# Adicione aqui os comandos específicos para desativar efeitos visuais do seu ambiente de desktop

# Revisar configurações de inicialização
echo "Revisando configurações de inicialização..."
# Adicione aqui os comandos específicos para revisar e desativar aplicativos de inicialização

# Otimizar o sistema de arquivos
echo "Otimizando o sistema de arquivos..."
sudo fstrim -av

echo "Otimizações concluídas."
