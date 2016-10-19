# sagebind/php-nginx
A lightweight PHP application server with PHP 7, PHP-FPM and [NGINX].

This image is designed to be a minimal, stable environment for running standard PHP applications behind a web server in a single container.

Add the root of the web application to `/var/www`, either as a volume or by creating an image based on this one with the application files copied into it.


[nginx]: http://nginx.org
