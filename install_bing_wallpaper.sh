#!/bin/bash

# Define o nome do arquivo .deb baixado
DEB_FILE="bing-wallpaper.deb"

# Baixa o arquivo .deb do Bing Wallpaper (substitua o URL pelo URL real do download)
wget -O $DEB_FILE https://exemplo.com/caminho-para-o-arquivo/$DEB_FILE

# Verifica se o download foi concluído com sucesso
if [ $? -ne 0 ]; then
    echo "Erro ao baixar o arquivo $DEB_FILE. Verifique o URL de download."
    exit 1
fi

# Instala o pacote .deb
sudo dpkg -i $DEB_FILE

# Verifica e instala dependências se necessário
sudo apt-get install -f

# Limpa o arquivo .deb após a instalação
rm $DEB_FILE

# Informa ao usuário que a instalação foi concluída
echo "Instalação do Bing Wallpaper concluída."

# Inicia o aplicativo Bing Wallpaper (se existir um comando específico para isso)
# Substitua `bing-wallpaper` pelo comando real de inicialização do aplicativo, se necessário
# bing-wallpaper &

# Fim do script
