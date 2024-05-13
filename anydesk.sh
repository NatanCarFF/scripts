#!/bin/bash

# Adiciona o repositório AnyDesk
sudo sh -c 'echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list'

# Baixa e importa a chave de assinatura do AnyDesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -

# Atualiza a lista de pacotes do sistema
sudo apt update

# Instala o AnyDesk
sudo apt install anydesk

echo "AnyDesk foi instalado com sucesso!"
