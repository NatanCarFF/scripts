Para baixar e executar o script `otimizar_ubuntu.sh` do GitHub, siga estes passos:

1. **Identificar o link de download bruto (raw) do script**:
   No GitHub, a URL que você forneceu aponta para a página do script. Precisamos da URL do conteúdo bruto do script.

   A URL bruta para o script é:
   ```
   https://raw.githubusercontent.com/NatanCarFF/scripts/main/otimizar_ubuntu.sh
   ```

2. **Baixar o script**:
   Use `curl` ou `wget` para baixar o script diretamente para o seu servidor Ubuntu.

   - Usando `curl`:
     ```bash
     curl -O https://raw.githubusercontent.com/NatanCarFF/scripts/main/otimizar_ubuntu.sh
     ```

   - Usando `wget`:
     ```bash
     wget https://raw.githubusercontent.com/NatanCarFF/scripts/main/otimizar_ubuntu.sh
     ```

3. **Verificar e ajustar as permissões do script**:
   Certifique-se de que o script tem permissões de execução.

   ```bash
   chmod +x otimizar_ubuntu.sh
   ```

4. **Executar o script**:
   Com as permissões ajustadas, execute o script.

   ```bash
   ./otimizar_ubuntu.sh
   ```

### Passo a Passo Completo

1. **Instalar `curl` ou `wget` (se ainda não estiverem instalados)**:
   ```bash
   sudo apt update
   sudo apt install curl wget
   ```

2. **Baixar o script usando `curl`**:
   ```bash
   curl -O https://raw.githubusercontent.com/NatanCarFF/scripts/main/otimizar_ubuntu.sh
   ```

   Ou, usando `wget`:
   ```bash
   wget https://raw.githubusercontent.com/NatanCarFF/scripts/main/otimizar_ubuntu.sh
   ```

3. **Ajustar as permissões do script**:
   ```bash
   chmod +x otimizar_ubuntu.sh
   ```

4. **Executar o script**:
   ```bash
   ./otimizar_ubuntu.sh
   ```

### Observação de Segurança
Antes de executar o script, é sempre uma boa prática revisar seu conteúdo para garantir que ele é seguro e faz exatamente o que você espera. Você pode abrir o script em um editor de texto, como `nano` ou `vim`, para inspecioná-lo:

```bash
nano otimizar_ubuntu.sh
```

Seguindo esses passos, você poderá baixar e executar o script `otimizar_ubuntu.sh` do GitHub no seu servidor Ubuntu.
