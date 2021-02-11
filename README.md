# Infra Default

### New Features!

  - [Docker](https://www.docker.com/)
  - [Docker Compose](https://docs.docker.com/compose/)

### Tecnologias

Dillinger uses a number of open source projects to work properly:

* [Nginx](https://www.nginx.com/) - Servidor leve de HTTP!
* [PHP 7.4.11](https://www.php.net/) - Linguagem core do WordPress

### Instalação

#### Docker

```sh
$ yum -y update && yum -y install curl && curl -fsSL https://get.docker.com | bash
```

#### Docker Compose

```sh
$ curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ chmod +x /usr/local/bin/docker-compose
$ ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

### Serviços

##### Config

Diretório `config` contém os arquivos de configurações para Nginx correspondendo a aplicação.
* `general.conf` Configurações gerais de controle do WordPress para os assest, robots e fonts.
* `nginx.conf` Configurações gerais para o Nginx.
* `php.conf` Arquivo para fazer o upstream com PHP.
* `security.conf` Arquivo com ciretérios de segurança para o WordPress.
* `webp.conf` Arquivo de confiração para permitir alterar o formato de imagem desenvolvido pelo Google que promete reduzir o tamanho dos arquivos.
* `wordpress.conf` Arquivo de configuração focado para aplicações baseadas em WordPress.

##### nginx/sites-enabled

Diretório `nginx/sites-enabled` contém o(s) arquivo(s) do bloco de configuração do site, define-se por exemplo o root do site, includes com os arquivos de configurações. Havendo necessidade de inserção de mais sites no servidor, pode-se basear no arquivo novamarca.lasalle.edu.br.conf ou seguir o exemplo abaixo;
`novo-site.com.conf`
```conf
server {
    listen   80;
    listen   [::]:80;
    server_name novo-site.com;
    
    return 301 https://novo-site.com$request_uri;
}
server {
    listen   443 ssl;
    listen   [::]:443 ssl;
    server_name novo-site.com;
    
    ssl_certificate     novo-site.com.chained.crt;
    ssl_certificate_key novo-site.com.key;
    
    set $base /var/www/novo-site.com;
	root $base/htdocs;
    index index.php index.html index.htm;

    sendfile off;

    server_tokens off;

    error_log /dev/stdout info;
    access_log /dev/stdout;

    location / {
		try_files $uri $uri/ /index.php?$query_string;
	}

    location ~ \.php$ {
		include common/php.conf;
	}
    
    include common/general.conf;
	include common/wordpress.conf;
    include common/webp.conf;

}
```
##### PHP
Diretório `php` contém o arquivo `php.ini` para manipulação das configurações do PHP.

### Subindo o serviço

```sh
$ cd /root/infra-novamarca && docker-compose up -d --build
```
* O nome do container é `server`.

Detalhes sobre a imagem baseada é encontrada [aqui](https://hub.docker.com/r/fuerzastudio/nginx-php-fpm) 