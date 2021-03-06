# Nginx PHP

This set of images can be used with PHP project from version 5.6 to 7.4.

Available images:

- sindriainc/nginx-php:2.0.0-5.6-local
- sindriainc/nginx-php:2.0.0-5.6-production
- sindriainc/nginx-php:2.0.0-7.0-local
- sindriainc/nginx-php:2.0.0-7.0-production
- sindriainc/nginx-php:2.0.0-7.1-local
- sindriainc/nginx-php:2.0.0-7.1-production
- sindriainc/nginx-php:2.0.0-7.2-local
- sindriainc/nginx-php:2.0.0-7.2-production
- sindriainc/nginx-php:2.0.0-7.3-local
- sindriainc/nginx-php:2.0.0-7.3-production
- sindriainc/nginx-php:2.0.0-7.4-local
- sindriainc/nginx-php:2.0.0-7.4-production

### Installation & Configuration

You can use docker-compose.example.yml configuration file as a sample, here you can find instructions
for deploying a new application.

#### Environment variables
- VIRTUAL_HOST Main domain of the application (e.g example.org)
- PHP_PM_MAX_CHILDREN Max number of child process for php-fpm pool 
- PHP_XDEBUG_IDE_KEY xdebug ide key, default is `PHPSTORM`

#### Installation instructions
- copy `config` directory in your project root.
- navigate to `config/php/cli` and `config/php/fpm`, copy ini configuration file corresponding to your
PHP version as `php.ini`
- navigate to `config/nginx/sites`, open `app.conf` and update it according to your needs
- if you have any cron job, you can add it to `config/cron.d/app`
