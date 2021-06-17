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
* [PHP 7.4.18](https://www.php.net/) - Wordpress core Language
* [Composer](https://getcomposer.org/doc/00-intro.md) - Package Management
* [WP-CLI](https://developer.wordpress.org/cli/commands/) - WordPress Command Line

## Settings

The Directory `nginx/common` have all config files for Nginx

| File | About |
| ------ | ------ |
| acl.conf | Restricting Access to Proxied TCP Resources. |
| locations.conf | Define application location and access settings. | 
| php.conf | PHP upstream file  |
| security.conf | Wordpress security file |
| webp.conf | Settings file to allow changing the image format to WEBP |
| wpcommon.conf | Settings file for Wordpress Applications |
| wpsubdir.conf | Setting to enable multi-site WordPress based on subdirectories. |
| wpce-php.conf | PHP configuration supporting Plugin [Cache Enabled.](https://wordpress.org/plugins/cache-enabler/) |
| wpfc-php.conf | PHP configuration supporting Plugin [Fast CGI.](https://br.wordpress.org/plugins/nginx-helper/) |
| wprocket-php.conf | PHP configuration supporting Plugin [WP Rocket.](https://wpengine.com/solution-center/wp-rocket/#:~:text=WP%20Rocket%20is%20a%20premium,users%20as%20well%20as%20beginners.) |
| wpsc-php.conf | PHP configuration supporting Plugin [Super cache.](https://br.wordpress.org/plugins/wp-super-cache/) |

## Default settings and performance

The Directory `nginx/conf.d` configuration, performance and security files for the webserver and WordPress application.

- ##### infra-design/nginx/sites-enabled/

The directory `nginx/sites-enabled`  have all Settings files for sites, where define the root path, includes etc. For include new sites on server, please use the pattern below:

`example.com`
```conf
server {
  listen 80;
  listen [::]:80;
  server_name example.com;

  set $base /var/www/example.com;
	root $base/htdocs;

  index index.php index.html index.htm;

  include common/wpfc-php.conf; #Cache FastCGI
  include common/locations.conf;
  include common/wpcommon.conf;  
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