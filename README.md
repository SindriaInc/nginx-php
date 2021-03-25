# Nginx PHP - WordPress

This set of images can be used with PHP project from version 7.1 to 7.4.

Available images:

- sindriainc/nginx-php:wordpress-7.1-local
- sindriainc/nginx-php:wordpress-7.1-production
- sindriainc/nginx-php:wordpress-7.2-local
- sindriainc/nginx-php:wordpress-7.2-production
- sindriainc/nginx-php:wordpress-7.3-local
- sindriainc/nginx-php:wordpress-7.3-production
- sindriainc/nginx-php:wordpress-7.4-local
- sindriainc/nginx-php:wordpress-7.4-production

#### Environment variables

- HOST_USER_UID default is "1000"
- TZ time zone default is "Europe/Rome"
- DEFAULT_SINDRIA_USER_PASSWORD default is "sindria"
- NGINX_PHP_PM_MAX_CHILDREN Max number of child process for php-fpm pool default is "16" 
- PHP_XDEBUG_IDE_KEY xdebug ide key, default is `PHPSTORM`
