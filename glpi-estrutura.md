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
       env_file:
         - .env
       volumes:
         - ./mariadb/data:/var/lib/mysql

     glpi:
       image: wlanfibra/glpi:v1.2
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

3. **Crie um arquivo `.env` para armazenar as variáveis de ambiente de forma segura (opcional, mas recomendado):**
   ```ini
   MYSQL_ROOT_PASSWORD=root_password
   MYSQL_DATABASE=glpi
   MYSQL_USER=glpi_user
   MYSQL_PASSWORD=glpi_password
   ```

4. **Execute o Docker Compose:**
   ```bash
   docker-compose up -d
   ```


1. **Suba um contêiner MySQL Client temporário:**

   ```bash
   docker run -it --rm --network glpi-docker_default mysql:latest bash
   ```

2. **Dentro do contêiner MySQL Client, importe as informações de timezones:**

   ```bash
   mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -h glpi-db -u root -p mysql
   ```

   Quando solicitado, insira a senha do root definida no seu `docker-compose.yml`.

#### 2. Conceder Permissões ao Usuário GLPI

3. **Ainda dentro do contêiner MySQL Client, acesse o MySQL como root:**

   ```bash
   mysql -h glpi-db -u root -p
   ```

4. **No prompt do MySQL, conceda permissões ao usuário `glpi_user`:**

   ```sql
   GRANT SELECT ON mysql.time_zone_name TO 'glpi_user'@'%';
   FLUSH PRIVILEGES;
   EXIT;
   ```

5. **Saia do contêiner temporário:**

   ```bash
   exit
   ```

#### 3. Subir os Contêineres e Verificar

1. **Suba os contêineres (caso ainda não estejam rodando):**

   ```bash
   docker-compose up -d
   ```

2. **Verifique os logs para assegurar que as alterações foram aplicadas:**

   ```bash
   docker-compose logs -f glpi-app
   ```
