server {
  listen 80;
  listen [::]:80;
  server_name example.com;

  set $base /var/www/example.com;
	root $base/htdocs;

  index index.php index.html index.htm;

  include common/php.conf;
  include common/locations.conf;
  include common/wpcommon.conf;  
}