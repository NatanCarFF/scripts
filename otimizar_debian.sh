#!/bin/bash

# Script de otimização para Debian

# Verificar se o script está sendo executado como root
if [ "$(id -u)" != "0" ]; then
    echo "Este script precisa ser executado como root."
    exit 1
fi

# Instalar pacote necessário
apt-get -y install procps

# Atualizar repositórios e pacotes
apt update
apt upgrade -y

# Remover pacotes não utilizados e limpar cache
apt autoremove -y
apt clean

# Otimização de swappiness
echo "vm.swappiness=10" >> /etc/sysctl.conf
/sbin/sysctl -p

# Desabilitar serviços desnecessários
systemctl disable bluetooth.service

# Ajustar configurações de rede (opcional)
# Exemplo: aumentar limite de conexões
echo "net.core.somaxconn=1024" >> /etc/sysctl.conf
/sbin/sysctl -p

# Otimizar uso de CPU
# Exemplo: ajustar governador da CPU para performance
if systemctl status cpufrequtils.service >/dev/null 2>&1; then
    echo 'GOVERNOR="performance"' > /etc/default/cpufrequtils
    systemctl restart cpufrequtils.service
else
    echo "Serviço cpufrequtils não encontrado ou não suportado."
fi

# Otimizar uso de disco (opcional)
# Exemplo: ativar trim para SSDs
systemctl enable fstrim.timer

# Reiniciar para aplicar as mudanças
echo "Otimização concluída. Reiniciando o sistema..."
sleep 3
/sbin/shutdown -r now
