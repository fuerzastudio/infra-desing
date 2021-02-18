# Fuerza Studio WebServer
[![N|Solid](https://www.fuerzastudio.com.br/wp-content/themes/fuerza/resources/img/logo.png)](https://www.fuerzastudio.com.br/)
## _NGINX + PHP Server  (using docker)_

The project is a webserver based on php using nginx, running in a docker instance with our image.

## Requirements

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

     - ### Setup
##### Docker
```sh
$ yum -y update && yum -y install curl && curl -fsSL https://get.docker.com | bash
```
##### Docker Compose
```sh
$ curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ chmod +x /usr/local/bin/docker-compose
$ ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

### Docker image

A [image](https://hub.docker.com/r/linuxsolutions/server-web-nginx-php-fpm) ready to build your web server with Nginx and PHP-FPM.

* [Nginx](https://www.nginx.com/) - Web server!
* [PHP 7.4.11](https://www.php.net/) - Wordpress core Language
* [Composer](https://getcomposer.org/doc/00-intro.md) - Package Management
* [WP-CLI](https://developer.wordpress.org/cli/commands/) - WordPress Command Line

## Settings

The Directory `config` have all config files for Nginx

| File | About |
| ------ | ------ |
| general.conf | General Wordpress Settings for control assets, robots and fonts. |
| nginx.conf | General Nginx Settings | 
| php.conf | PHP upstream file  |
| security.conf | Wordpress security file |
| webp.conf | Settings file to allow changing the image format to WEBP |
| wordpress.conf | Settings file for Wordpress Applications |

- ##### infra-design/nginx/conf.d/

The directory `nginx/sites-enabled`  have all Settings files for sites, where define the root path, includes etc. For include new sites on server, please use the pattern below:

`new-site.com.conf`
```conf
server {
    listen   80;
    listen   [::]:80;
    server_name new-site.com;
    
    return 301 https://new-site.com$request_uri;
}
server {
    listen   443 ssl;
    listen   [::]:443 ssl;
    server_name new-site.com;
    
    ssl_certificate     new-site.com.chained.crt;
    ssl_certificate_key new-site.com.key;
    
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

- ##### PHP
The directory `php` contains the archieve `php.ini` for change PHP configuration.


## Running

```sh
$ cd /path/infra-design && docker-compose up -d --build
```
* Container named: `server`.

> Note: Verify the deployment by navigating to your server address in
your preferred browser.

```sh
127.0.0.1
```

