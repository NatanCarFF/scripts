Claro! Vou criar um script que automatiza todo o processo de instalação do Docker no Debian, incluindo a instalação do `sudo` (caso necessário), a adição da chave GPG e repositório do Docker, e a instalação do próprio Docker.

Aqui está o script:

### Script para instalar o Docker no Debian

```bash
#!/bin/bash

# Atualizando o sistema
echo "Atualizando o sistema..."
apt update && apt upgrade -y

# Verificando se o 'sudo' está instalado
if ! command -v sudo &> /dev/null
then
    echo "'sudo' não encontrado. Instalando..."
    # Instalando 'sudo' se não estiver presente
    apt install sudo -y
fi

# Adicionando a chave GPG do Docker
echo "Adicionando a chave GPG do Docker..."
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Adicionando o repositório do Docker
echo "Adicionando o repositório do Docker..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualizando os repositórios novamente
echo "Atualizando os repositórios..."
sudo apt update

# Instalando o Docker
echo "Instalando o Docker..."
sudo apt install docker-ce -y

# Verificando se o Docker foi instalado corretamente
echo "Verificando o status do Docker..."
sudo systemctl status docker --no-pager

# Testando o Docker
echo "Testando o Docker com o comando hello-world..."
sudo docker run hello-world

echo "Instalação concluída! O Docker está instalado e funcionando no seu sistema."
```

### Passos para executar o script

1. **Criar o arquivo de script:**
   Abra o terminal e crie um arquivo de script, por exemplo, `install_docker.sh`:

   ```bash
   nano install_docker.sh
   ```

2. **Copiar e colar o script:**
   Cole o conteúdo do script que forneci acima dentro do arquivo.

3. **Dar permissões de execução:**
   Torne o script executável com o comando:

   ```bash
   chmod +x install_docker.sh
   ```

4. **Executar o script:**
   Agora, você pode executar o script com o comando:

   ```bash
   sudo ./install_docker.sh
   ```

### O que o script faz:
- Atualiza o sistema.
- Verifica se o `sudo` está instalado e o instala, caso não esteja.
- Adiciona a chave GPG e o repositório do Docker.
- Atualiza a lista de pacotes e instala o Docker.
- Verifica o status do Docker para garantir que ele foi instalado corretamente.
- Executa um teste com o comando `docker run hello-world` para verificar se o Docker está funcionando.

Esse script automatiza toda a instalação do Docker, facilitando o processo. Se você tiver alguma dúvida ou precisar de mais ajuda, fique à vontade para perguntar!
