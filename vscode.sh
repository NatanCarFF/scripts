#!/bin/bash

# Baixar o arquivo de deb
wget -qO code.deb "link_para_o_arquivo_de_deb"

# Instalar o pacote
sudo dpkg -i code.deb

# Iniciar o Visual Studio Code
code
