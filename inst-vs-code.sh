# Atualiza o sistema
sudo apt update

# Tente instalar o Visual Studio Code
sudo apt install -y code

# Verifica se o Visual Studio Code foi instalado com sucesso
if [[ $? -eq 0 ]]; then
  echo "Visual Studio Code instalado com sucesso!"
else
  echo "Erro ao instalar o Visual Studio Code. Por favor, tente novamente."
fi
