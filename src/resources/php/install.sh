#!/usr/bin/env bash

PHP_VERSION=$1

apk update

case ${PHP_VERSION} in
    7.0)
        apk add php7-fpm
        rm /etc/php7/php-fpm.d/www.conf
        export MAJOR_VERSION=7
        ;;
    7.1)
        apk add php7-fpm
        rm /etc/php7/php-fpm.d/www.conf
        export MAJOR_VERSION=7
        ;;
    7.2)
        apk add php7-fpm
        rm /etc/php7/php-fpm.d/www.conf
        export MAJOR_VERSION=7
        ;;
    7.3)
        apk add php7-fpm
        rm /etc/php7/php-fpm.d/www.conf
        export MAJOR_VERSION=7
        ;;
    7.4)
        apk add php7-fpm
        rm /etc/php7/php-fpm.d/www.conf
        export MAJOR_VERSION=7
        ;;
    8)
        apk add php8-fpm
        rm /etc/php8/php-fpm.d/www.conf
        export MAJOR_VERSION=8
        ;;
    *)
        echo "Invalid PHP version specified"
        exit 1
    ;;
esac