## Sindria nginx-php Docker image

This set of images can be used with PHP project from version 5.6 to 7.3.

Available images:
- registry.sindria.org/nginx-php-5.6
- registry.sindria.org/nginx-php-7.0
- registry.sindria.org/nginx-php-7.1
- registry.sindria.org/nginx-php-7.2
- registry.sindria.org/nginx-php-7.3

### Installation & Configuration

You can use docker-compose.example.yml configuration file as a sample, here you can find instructions
for deploying a new application.

#### Environment variables
- VIRTUAL_HOST Main domain of the application (e.g example.org)
- PHP_PM_MAX_CHILDREN Max number of child process for php-fpm pool 

#### Installation instructions
- copy `config` directory in your project root
- navigate to `config/php/cli` and `config/php/fpm`, copy ini configuration file corresponding to your
PHP version as `php.ini`
- navigate to `config/nginx/sites`, open `app.conf` and update it according to your needs
- if you have any cron job, you can add it to `config/cron.d/app`

