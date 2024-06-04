https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-pt

author
Brian Hogan

Português
Como Instalar e Utilizar o Docker no Ubuntu 20.04
Introdução
O Docker é um aplicativo que simplifica o processo de gerenciamento de processos de aplicação em containers. Os containers deixam você executar suas aplicações em processos isolados de recurso. Eles são semelhantes a máquinas virtuais, mas os containers são mais portáveis, mais fáceis de usar e mais dependentes do sistema operacional do host.

Para uma introdução detalhada aos diferentes componentes de um container Docker, verifique O Ecossistema Docker: Uma Introdução aos Componentes Comuns.

Neste tutorial, você irá instalar e usar a Edição Community (CE) do Docker no Ubuntu 20.04. Você instalará o Docker propriamente dito, trabalhará com contêineres e imagens, e enviará uma imagem para um repositório do Docker.

Pré-requisitos
Para seguir este tutorial, você precisará do seguinte:

Um servidor Ubuntu 20.04 configurado conforme o Guia de configuração inicial de servidor do Ubuntu 20.04, incluindo um usuário sudo não root e um firewall.
Uma conta no Docker Hub se você deseja criar suas próprias imagens e enviá-las para o Docker Hub, como mostrado nos passos 7 e 8.
Passo 1 — Instalando o Docker
O pacote de instalação do Docker disponível no repositório oficial do Ubuntu pode não ser a versão mais recente. Para garantir que tenhamos a versão mais recente, iremos instalar o Docker do repositório oficial do Docker. Para fazer isso, adicionaremos uma nova fonte de pacote, adicionaremos a chave GPG do Docker para garantir que os downloads sejam válidos, e então instalaremos o pacote.

Primeiro, atualize sua lista existente de pacotes:

sudo apt update
Em seguida, instale alguns pacotes pré-requisito que deixam o apt usar pacotes pelo HTTPS:

sudo apt install apt-transport-https ca-certificates curl software-properties-common
Então, adicione a chave GPG para o repositório oficial do Docker no seu sistema:

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
Adicione o repositório do Docker às fontes do APT:

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
Em seguida, atualize o banco de dados do pacote com os pacotes do Docker do recém adicionado repositório:

sudo apt update
Certifique-se de que você está prestes a instalar do repositório do Docker ao invés do repositório padrão do Ubuntu:

apt-cache policy docker-ce
Você verá um resultado assim, embora o número da versão para o Docker possa ser diferente:

Output of apt-cache policy docker-ce
docker-ce:
  Installed: (none)
  Candidate: 5:19.03.9~3-0~ubuntu-focal
  Version table:
     5:19.03.9~3-0~ubuntu-focal 500
        500 https://download.docker.com/linux/ubuntu focal/stable amd64 Packages
Observe que o docker-ce não está instalado, mas o candidato para a instalação é do repositório do Docker para o Ubuntu 20.04 (focal).

Finalmente, instale o Docker:

sudo apt install docker-ce
O Docker deve agora ser instalado, o daemon iniciado e o processo habilitado a iniciar no boot. Verifique se ele está funcionando:

sudo systemctl status docker
O resultado deve ser similar ao mostrado a seguir, mostrando que o serviço está ativo e funcionando:

Output
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2020-05-19 17:00:41 UTC; 17s ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 24321 (dockerd)
      Tasks: 8
     Memory: 46.4M
     CGroup: /system.slice/docker.service
             └─24321 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
Instalando o Docker agora não dá apenas o serviço do Docker (daemon), mas também o utilitário de linha de comando docker, ou o cliente do Docker. Vamos explorar como usar o comando docker mais tarde neste tutorial.

Passo 2 — Executando o Comando Docker Sem Sudo (Opcional)
Por padrão, o comando docker só pode ser executado pelo usuário root ou por um usuário no grupo docker, que é criado automaticamente no processo de instalação do Docker. Se você tentar executar o comando docker sem prefixar ele com o sudo ou sem estar no grupo docker, você terá um resultado como este:

Output
docker: Cannot connect to the Docker daemon. Is the docker daemon running on this host?.
See 'docker run --help'.
Se você quiser evitar digitar sudo sempre que você executar o comando docker, adicione seu nome de usuário no grupo docker:

sudo usermod -aG docker ${USER}
Para inscrever o novo membro ao grupo, saia do servidor e logue novamente, ou digite o seguinte:

su - ${USER}
Você será solicitado a digitar a senha do seu usuário para continuar.

Confirme que seu usuário agora está adicionado ao grupo docker digitando:

id -nG
Output
sammy sudo docker
Se você precisar adicionar um usuário ao grupo docker com o qual você não está logado, declare esse nome de usuário explicitamente usando:

sudo usermod -aG docker username
O resto deste artigo supõe que você esteja executando o comando docker como um usuário no grupo docker. Se você escolher não fazer isso, por favor preencha os comandos com sudo.

Vamos explorar o comando docker a seguir.

Passo 3 — Usando o Comando Docker
Usar o docker consiste em passar a ele uma cadeia de opções e comandos seguidos de argumentos. A sintaxe toma esta forma:

docker [option] [command] [arguments]
Para ver todos os subcomandos disponíveis, digite:

docker
No Docker 19, a lista completa de subcomandos disponíveis inclui:

Output
  attach      Attach local standard input, output, and error streams to a running container
  build       Build an image from a Dockerfile
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  exec        Run a command in a running container
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  images      List images
  import      Import the contents from a tarball to create a filesystem image
  info        Display system-wide information
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  login       Log in to a Docker registry
  logout      Log out from a Docker registry
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  ps          List containers
  pull        Pull an image or a repository from a registry
  push        Push an image or a repository to a registry
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  run         Run a command in a new container
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  search      Search the Docker Hub for images
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  version     Show the Docker version information
  wait        Block until one or more containers stop, then print their exit codes

Para visualizar as opções disponíveis para um comando específico, digite:

docker docker-subcommand --help
Para visualizar informações de sistema sobre o Docker, use:

docker info
Vamos explorar alguns desses comandos. Começaremos trabalhando com imagens.

Passo 4 — Trabalhando com Imagens do Docker
Os containers do Docker são construídos com imagens do Docker. Por padrão, o Docker puxa essas imagens do Docker Hub, um registro Docker gerido pelo Docker, a empresa por trás do projeto Docker. Qualquer um pode hospedar suas imagens do Docker no Docker Hub, então a maioria dos aplicativos e distribuições do Linux que você precisará terá imagens hospedadas lá.

Para verificar se você pode acessar e baixar imagens do Docker Hub, digite:

docker run hello-world
O resultado irá indicar que o Docker está funcionando corretamente:

Output
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
0e03bdcc26d7: Pull complete
Digest: sha256:6a65f928fb91fcfbc963f7aa6d57c8eeb426ad9a20c7ee045538ef34847f44f1
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

...

O Docker inicialmente não conseguiu encontrar a imagem hello-world localmente, então ele baixou a imagem do Docker Hub, que é o repositório padrão. Uma vez baixada a imagem, o Docker criou um container da imagem e executou o aplicativo no container, mostrando a mensagem.

Você pode procurar imagens disponíveis no Docker Hub usando o comando docker com o subcomando search. Por exemplo, para procurar a imagem do Ubuntu, digite:

docker search ubuntu
O script irá vasculhar o Docker Hub e devolverá uma lista de todas as imagens cujo nome correspondam ao string de pesquisa. Neste caso, o resultado será similar a este:

Output
NAME                                                      DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
ubuntu                                                    Ubuntu is a Debian-based Linux operating sys…   10908               [OK]
dorowu/ubuntu-desktop-lxde-vnc                            Docker image to provide HTML5 VNC interface …   428                                     [OK]
rastasheep/ubuntu-sshd                                    Dockerized SSH service, built on top of offi…   244                                     [OK]
consol/ubuntu-xfce-vnc                                    Ubuntu container with "headless" VNC session…   218                                     [OK]
ubuntu-upstart                                            Upstart is an event-based replacement for th…   108                 [OK]
ansible/ubuntu14.04-ansible                               Ubuntu 14.04 LTS with
...

Na coluna OFICIAL, o OK indica uma imagem construída e suportada pela empresa por trás do projeto. Uma vez que você tenha identificado a imagem que você gostaria de usar, você pode baixá-la para seu computador usando o subcomando pull.

Execute o comando a seguir para baixar a imagem oficial ubuntu no seu computador:

docker pull ubuntu
Você verá o seguinte resultado:

Output
Using default tag: latest
latest: Pulling from library/ubuntu
d51af753c3d3: Pull complete
fc878cd0a91c: Pull complete
6154df8ff988: Pull complete
fee5db0ff82f: Pull complete
Digest: sha256:747d2dbbaaee995098c9792d99bd333c6783ce56150d1b11e333bbceed5c54d7
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
Após o download de uma imagem, você pode então executar um container usando a imagem baixada com o subcomando run. Como você viu com o exemplo hello-world, caso uma imagem não tenha sido baixada quando o docker for executado com o subcomando run, o cliente do Docker irá primeiro baixar a imagem e então executar um container usando ele.

Para ver as imagens que foram baixadas no seu computador, digite:

docker images
O resultado se parecerá com o seguinte:

Output
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              latest              1d622ef86b13        3 weeks ago         73.9MB
hello-world         latest              bf756fb1ae65        4 months ago        13.3kB
Como você verá mais tarde neste tutorial, imagens que você usa para executar containers podem ser modificadas e usadas para gerar novas imagens, que podem então ser enviadas (pushed é o termo técnico) para o Docker Hub ou outros registros do Docker.

Vamos ver como executar containers mais detalhadamente.

Passo 5 — Executando um Container do Docker
O container hello-world que você executou no passo anterior é um exemplo de um container que executa e finaliza após emitir uma mensagem de teste. Os containers podem ser muito mais úteis do que isso, e eles podem ser interativos. Afinal, eles são semelhantes a máquinas virtuais, apenas mais fáceis de usar.

Como um exemplo, vamos executar um container usando a última imagem do Ubuntu. A combinação dos switches -i e -t dá a você um acesso de shell interativo no container:

docker run -it ubuntu
Seu prompt de comando deve mudar para refletir o fato de você agora estar trabalhando dentro do container e deve assumir esta forma:

Output
root@d9b100f2f636:/#
Observe o id do container no prompt de comando. Neste exemplo, é d9b100f2f636. Você precisará do ID do container mais tarde para identificar o container quando você quiser removê-lo.

Agora você pode executar qualquer comando dentro do container. Por exemplo, vamos atualizar o banco de dados do pacote dentro do container. Você não precisa prefixar nenhum comando com sudo, porque você está operando dentro do container como o usuário root:

apt update
Então, instale qualquer aplicativo nele. Vamos instalar o Node.js:

apt install nodejs
Isso instala o Node.js no container do repositório oficial do Ubuntu. Quando a instalação terminar, verifique se o Node.js está instalado:

node -v
Você verá o número da versão exibido no seu terminal:

Output
v10.19.0
Qualquer alteração que você faça dentro do container apenas se aplica a esse container.

Para sair do container, digite exit no prompt.

Vamos ver como gerenciar os containers no nosso sistema a seguir.

Passo 6 — Gerenciando os Containers do Docker
Após usar o Docker por um tempo, você terá muitos containers ativos (executando) e inativos no seu computador. Para visualizar os ativos, use:

docker ps
Você verá um resultado similar ao seguinte:

Output
CONTAINER ID        IMAGE               COMMAND             CREATED             

Neste tutorial, você iniciou dois containers; um da imagem hello-world e outro da imagem ubuntu. Ambos os containers já não estão funcionando, mas eles ainda existem no seu sistema.

Para ver todos os containers — ativos e inativos, execute docker ps com o switch -a:

docker ps -a
Você verá um resultado similar a este:

1c08a7a0d0e4        ubuntu              "/bin/bash"         2 minutes ago       Exited (0) 8 seconds ago                       quizzical_mcnulty
a707221a5f6c        hello-world         "/hello"            6 minutes ago       Exited (0) 6 minutes ago                       youthful_curie

Para ver o último container que você criou, passe o switch -l:

docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
1c08a7a0d0e4        ubuntu              "/bin/bash"         2 minutes ago       Exited (0) 40 seconds ago                       quizzical_mcnulty

Para iniciar um container parado, use o docker start, seguido do ID do container ou nome do container. Vamos iniciar o contêiner baseado no Ubuntu com o ID do 1c08a7a0d0e4:

docker start 1c08a7a0d0e4
O container irá iniciar e você pode usar o docker ps para ver seu status:

Output
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
1c08a7a0d0e4        ubuntu              "/bin/bash"         3 minutes ago       Up 5 seconds                            quizzical_mcnulty

Para parar um container em execução, use o docker stop, seguido do ID ou nome do container. Desta vez, usaremos o nome que o Docker atribuiu ao contêiner, que é quizzical_mcnulty:

docker stop quizzical_mcnulty
Uma vez que você tenha decidido que você já não precisa mais de um container, remova ele com o comando docker rm, novamente usando o ID do container ou o nome. Use o comando docker ps -a para encontrar o ID ou nome do container associado à imagem hello-world e remova-o.

docker rm youthful_curie
Você pode iniciar um novo container e dar a ele um nome usando o switch --name. Você também pode usar o switch --rm para criar um container que remove a si mesmo quando ele é parado. Veja o comando docker run help para obter mais informações sobre essas e outras opções.

Os containers podem ser transformados em imagens que você pode usar para criar novos containers. Vamos ver como isso funciona.

Passo 7 —Enviando Alterações em um Container para uma Imagem do Docker
Quando você iniciar uma imagem do Docker, você pode criar, modificar e deletar arquivos assim como você pode com uma máquina virtual. As alterações que você faz apenas se aplicarão a esse container. Você pode iniciá-lo e pará-lo, mas uma vez que você o destruir com o comando docker rm, as alterações serão perdidas para sempre.

Esta seção mostra como salvar o estado de um container como uma nova imagem do Docker.

Após instalar o Node.js dentro do container do Ubuntu, você agora tem um container executando uma imagem, mas o container é diferente da imagem que você usou para criá-lo. Mas você pode querer reutilizar este container Node.js como a base para novas imagens mais tarde.

Então, envie as alterações a uma nova instância de imagem do Docker usando o comando a seguir.

docker commit -m "What you did to the image" -a "Author Name" container_id repository/new_image_name
O switch -m é para a mensagem de envio que ajuda você e outros a saber quais as alterações que você fez, enquanto -a é usado para especificar o autor. O container_id é aquele que você anotou anteriormente no tutorial quando você iniciou a sessão interativa do Docker. A menos que você tenha criado repositórios adicionais no Docker Hub, repository é normalmente seu nome de usuário do Docker Hub.

Por exemplo, para o usuário sammy, com o ID do container d9b100f2f636, o comando seria:

docker commit -m "added Node.js" -a "sammy" d9b100f2f636 sammy/ubuntu-nodejs
Quando você envia uma imagem, a nova imagem é salva localmente no seu computador. Mais tarde neste tutorial, você aprenderá como empurrar uma imagem para um registro do Docker para que outros possam acessá-la.

Listando as imagens do Docker novamente irá mostrar a nova imagem, além da antiga da qual ela foi derivada:

docker images
Você verá um resultado como esse:

Output
REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
sammy/ubuntu-nodejs   latest              7c1f35226ca6        7 seconds ago       179MB
...

Neste exemplo, o ubuntu-nodejs é a nova imagem, que foi derivada da imagem ubuntu existente do Docker Hub. A diferença de tamanho reflete as alterações que foram feitas. E neste exemplo, a mudança foi que o NodeJS foi instalado. Então, da próxima vez que você precisar executar um container usando o Ubuntu com o NodeJS pré-instalado, você pode apenas usar a nova imagem.

Você também pode construir Imagens de um Dockerfile, que permite a você automatizar a instalação de software em uma nova imagem. No entanto, isso está fora do âmbito deste tutorial.

Agora vamos compartilhar a nova imagem com outros para que eles possam criar containers a partir dela.

Passo 8 — Empurrando Imagens do Docker para um Repositório do Docker
O próximo passo lógico após criar uma nova imagem de uma imagem existente é compartilhá-la com alguns de seus amigos, todo o mundo no Docker Hub, ou outro registro do Docker que você tenha acesso. Para empurrar uma imagem para o Docker Hub ou qualquer outro registro do Docker, você deve ter uma conta lá.

Esta seção mostra como empurrar uma imagem do Docker para o Docker Hub. Para aprender a criar seu próprio registro privado do Docker, verifique Como Configurar um Registro Privado do Docker no Ubuntu 14.04.

Para empurrar sua imagem, primeiro logue no Docker Hub.

docker login -u docker-registry-username
Você será solicitado a autenticar-se usando sua senha do Docker Hub. Se você especificou a senha correta, a autenticação deve ser bem sucedida.

Nota: se seu nome de usuário de registro do Docker for diferente do nome de usuário local que você usou para criar a imagem, você terá que anexar sua imagem com seu nome de usuário de registro. Para o exemplo dado no último passo, você digitaria:

docker tag sammy/ubuntu-nodejs docker-registry-username/ubuntu-nodejs
Então você pode empurrar sua própria imagem usando:

docker push docker-registry-username/docker-image-name
Para empurrar a imagem ubuntu-nodejs no repositório sammy, o comando seria:

docker push sammy/ubuntu-nodejs
O processo pode levar algum tempo para se completar uma vez que ele envia as imagens, mas quando finalizado, o resultado se parecerá com este:

Output
The push refers to a repository [docker.io/sammy/ubuntu-nodejs]
e3fbbfb44187: Pushed
5f70bf18a086: Pushed
a3b5c80a4eba: Pushed
7f18b442972b: Pushed
3ce512daaf78: Pushed
7aae4540b42d: Pushed

...


Após empurrar uma imagem para um registro, ela deve estar listada no painel da sua conta, como mostrado na imagem abaixo.

New Docker image listing on Docker Hub

Se uma tentativa de empurrar resultar em um erro deste tipo, então você provavelmente não logou:

Output
The push refers to a repository [docker.io/sammy/ubuntu-nodejs]
e3fbbfb44187: Preparing
5f70bf18a086: Preparing
a3b5c80a4eba: Preparing
7f18b442972b: Preparing
3ce512daaf78: Preparing
7aae4540b42d: Waiting
unauthorized: authentication required
Logue com docker login e repita a tentativa de empurrar. Então verifique se ela existe na sua página de repositório do Docker Hub.

Você agora pode usar o docker pull sammy/ubuntu-nodejs para puxar a imagem para uma nova máquina e usá-la para executar um novo contêiner.

Conclusão
Neste tutorial você instalou o Docker, trabalhou com imagens e containers, e empurrou uma imagem modificada para o Docker Hub. Agora que você sabe o básico, explore os outros tutoriais do Docker na Comunidade DigitalOcean.
