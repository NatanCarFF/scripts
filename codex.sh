#!/bin/bash

# Atualizar repositórios e pacotes
sudo apt update && sudo apt upgrade -y

# Remover pacotes desnecessários
sudo apt autoremove -y

# Limpar cache do apt
sudo apt clean

# Habilitar TRIM para SSDs
sudo systemctl enable fstrim.timer

# Ajustar swappiness (troca)
sudo sysctl vm.swappiness=10

# Desabilitar relatórios de erros automáticos
sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport

# Desabilitar hibernação
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

# Instalar e habilitar firewall
sudo apt install ufw -y
sudo ufw enable

# Desabilitar acessos remotos não necessários
sudo systemctl disable ssh

# Desabilitar relatórios de erros do kernel
sudo sed -i 's/kernel.panic = 0/kernel.panic = 10/g' /etc/sysctl.conf

# Desabilitar a busca automática por drivers de impressoras
sudo systemctl disable cups-browsed

# Otimizar configurações de energia
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash intel_pstate=disable"/g' /etc/default/grub
sudo update-grub

# Otimizar configurações de energia para SSDs
echo "vm.dirty_background_ratio = 5" | sudo tee -a /etc/sysctl.conf
echo "vm.dirty_ratio = 10" | sudo tee -a /etc/sysctl.conf

# Reiniciar o sistema
sudo reboot
