#!/bin/bash

# Remover o snap do Visual Studio Code
snap remove code

# Atualizar o cache do apt
sudo apt update

# Instalar o Visual Studio Code
sudo apt install code
