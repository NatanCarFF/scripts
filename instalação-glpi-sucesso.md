Para instalar o GLPI em um contêiner e o banco de dados (por exemplo, MariaDB) em outro contêiner, e usar um servidor Apache para executar o GLPI, podemos usar o Docker Compose para facilitar a orquestração dos contêineres. Aqui está um exemplo de como você pode fazer isso:

### Passos:

1. **Crie uma estrutura de diretórios para o projeto:**
   ```bash
   mkdir glpi-docker
   cd glpi-docker
   mkdir glpi mariadb
   ```

2. **Crie o arquivo `docker-compose.yml`:**
   ```yaml
   version: '3.8'

   services:
     db:
       image: mariadb:latest
       container_name: glpi-db
       restart: always
       environment:
         MYSQL_ROOT_PASSWORD: root_password
         MYSQL_DATABASE: glpi
         MYSQL_USER: glpi_user
         MYSQL_PASSWORD: glpi_password
       volumes:
         - ./mariadb/data:/var/lib/mysql

     glpi:
       image: diouxx/glpi:latest
       container_name: glpi-app
       restart: always
       ports:
         - "80:80"
       environment:
         GLPI_DB_HOST: db
         GLPI_DB_USER: glpi_user
         GLPI_DB_PASSWORD: glpi_password
         GLPI_DB_NAME: glpi
       depends_on:
         - db
       volumes:
         - ./glpi:/var/www/html/glpi

   volumes:
     mariadb_data:
   ```

3. **Crie um arquivo `.env` para armazenar as variáveis de ambiente de forma segura (opcional, mas recomendado):**
   ```ini
   MYSQL_ROOT_PASSWORD=root_password
   MYSQL_DATABASE=glpi
   MYSQL_USER=glpi_user
   MYSQL_PASSWORD=glpi_password
   ```

   E atualize o `docker-compose.yml` para referenciar o arquivo `.env`:
   ```yaml
   version: '3.8'

   services:
     db:
       image: mariadb:latest
       container_name: glpi-db
       restart: always
       env_file:
         - .env
       volumes:
         - ./mariadb/data:/var/lib/mysql

     glpi:
       image: diouxx/glpi:latest
       container_name: glpi-app
       restart: always
       ports:
         - "80:80"
       environment:
         GLPI_DB_HOST: db
         GLPI_DB_USER: ${MYSQL_USER}
         GLPI_DB_PASSWORD: ${MYSQL_PASSWORD}
         GLPI_DB_NAME: ${MYSQL_DATABASE}
       depends_on:
         - db
       volumes:
         - ./glpi:/var/www/html/glpi

   volumes:
     mariadb_data:
   ```

4. **Execute o Docker Compose:**
   ```bash
   docker-compose up -d
   ```

### Descrição:

- **Serviço `db`:** Usa a imagem oficial do MariaDB. Configura as variáveis de ambiente para definir a senha do root, o banco de dados e o usuário do banco de dados.
- **Serviço `glpi`:** Usa uma imagem Docker do GLPI com o Apache configurado. Define as variáveis de ambiente para conectar-se ao banco de dados MariaDB.
- **Volumes:** Os volumes são utilizados para persistir os dados do banco de dados e os arquivos do GLPI.

### Notas:

- **Persistência de Dados:** Os volumes montados asseguram que os dados do banco de dados e os arquivos do GLPI sejam persistentes e não sejam perdidos quando os contêineres são reiniciados.
- **Personalização:** Você pode ajustar as configurações conforme necessário, como a porta do Apache, o nome do banco de dados, as credenciais, etc.
- **Segurança:** Para produção, é recomendável usar senhas mais fortes e configurar a segurança adequadamente, incluindo a utilização de um arquivo `.env` para variáveis de ambiente sensíveis.

Com este setup, você pode acessar o GLPI no seu navegador através do endereço `http://localhost` e seguir as instruções de instalação do GLPI para configurar o sistema.

----------------------------------------------------

Para atender às suas solicitações de segurança ao usar o GLPI, você pode seguir estes passos após a instalação inicial. Aqui está como você pode atualizar as senhas dos usuários padrão e remover o arquivo `install/install.php` automaticamente usando um script bash dentro do contêiner do GLPI.

### Atualizar Docker Compose e Adicionar Scripts de Inicialização

Primeiro, vamos ajustar o `docker-compose.yml` para adicionar um script de inicialização que alterará as senhas dos usuários padrão e removerá o arquivo `install/install.php`.

#### Estrutura de Diretórios

Adicione um diretório `scripts` para armazenar o script de inicialização:

```bash
mkdir scripts
```

#### Script de Inicialização

Crie um arquivo chamado `initialize_glpi.sh` dentro do diretório `scripts`:

```bash
#!/bin/bash

# Espera o banco de dados estar disponível
until mysql -h "$GLPI_DB_HOST" -u "$GLPI_DB_USER" -p"$GLPI_DB_PASSWORD" "$GLPI_DB_NAME" -e "show tables;" > /dev/null 2>&1; do
  echo "Aguardando banco de dados..."
  sleep 3
done

# Conexão com o banco de dados para atualizar senhas dos usuários padrão
mysql -h "$GLPI_DB_HOST" -u "$GLPI_DB_USER" -p"$GLPI_DB_PASSWORD" "$GLPI_DB_NAME" <<-EOSQL
  UPDATE glpi_users SET password = MD5('new_glpi_password') WHERE name = 'glpi';
  UPDATE glpi_users SET password = MD5('new_postonly_password') WHERE name = 'post-only';
  UPDATE glpi_users SET password = MD5('new_tech_password') WHERE name = 'tech';
  UPDATE glpi_users SET password = MD5('new_normal_password') WHERE name = 'normal';
EOSQL

# Remover o arquivo de instalação
rm -f /var/www/html/glpi/install/install.php

echo "Senhas de usuários padrão atualizadas e arquivo install.php removido."
```

Certifique-se de dar permissão de execução ao script:

```bash
chmod +x scripts/initialize_glpi.sh
```

#### Atualizar `docker-compose.yml`

Atualize o `docker-compose.yml` para copiar e executar o script de inicialização:

```yaml
version: '3.8'

services:
  db:
    image: mariadb:latest
    container_name: glpi-db
    restart: always
    env_file:
      - .env
    volumes:
      - ./mariadb/data:/var/lib/mysql

  glpi:
    image: diouxx/glpi:latest
    container_name: glpi-app
    restart: always
    ports:
      - "80:80"
    environment:
      GLPI_DB_HOST: db
      GLPI_DB_USER: ${MYSQL_USER}
      GLPI_DB_PASSWORD: ${MYSQL_PASSWORD}
      GLPI_DB_NAME: ${MYSQL_DATABASE}
    depends_on:
      - db
    volumes:
      - ./glpi:/var/www/html/glpi
    entrypoint: /bin/bash -c "/usr/sbin/apache2ctl -D FOREGROUND & /scripts/initialize_glpi.sh"
    volumes:
      - ./glpi:/var/www/html/glpi
      - ./scripts:/scripts

volumes:
  mariadb_data:
```

### Execute o Docker Compose

1. **Suba os contêineres:**

   ```bash
   docker-compose up -d
   ```

2. **Verifique os logs para assegurar que as alterações foram aplicadas:**

   ```bash
   docker-compose logs -f glpi-app
   ```

Este setup fará com que, após o banco de dados estar disponível, o script `initialize_glpi.sh` seja executado. Ele irá:

- Atualizar as senhas dos usuários padrão para novas senhas seguras.
- Remover o arquivo `install/install.php`.

Dessa forma, você garante que as senhas dos usuários padrão são seguras e que o arquivo de instalação é removido após a instalação inicial, melhorando a segurança do seu setup GLPI.
