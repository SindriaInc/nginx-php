#!/usr/bin/env bash

PHP_VERSION=$1

apk update

case ${PHP_VERSION} in
    7.0)
        apk add php7-fpm
        ln -s /usr/sbin/php-fpm7 /usr/sbin/php-fpm
        ln -s /etc/php7 /etc/php
        mkdir -p /run/php/
        rm /etc/php7/php-fpm.d/www.conf
        cp ${SINDRIA_USER_HOME}/sindria.conf /etc/php7/php-fpm.d/sindria.conf
        chown ${SINDRIA_USER}:root /run/php/
        ;;
    7.1)
        apk add php7-fpm
        ln -s /usr/sbin/php-fpm7 /usr/sbin/php-fpm
        ln -s /etc/php7 /etc/php
        mkdir -p /run/php/
        rm /etc/php7/php-fpm.d/www.conf
        cp ${SINDRIA_USER_HOME}/sindria.conf /etc/php7/php-fpm.d/sindria.conf
        chown ${SINDRIA_USER}:root /run/php/
        ;;
    7.2)
        apk add php7-fpm
        ln -s /usr/sbin/php-fpm7 /usr/sbin/php-fpm
        ln -s /etc/php7 /etc/php
        mkdir -p /run/php/
        rm /etc/php7/php-fpm.d/www.conf
        cp ${SINDRIA_USER_HOME}/sindria.conf /etc/php7/php-fpm.d/sindria.conf
        chown ${SINDRIA_USER}:root /run/php/
        ;;
    7.3)
        apk add php7-fpm
        ln -s /usr/sbin/php-fpm7 /usr/sbin/php-fpm
        ln -s /etc/php7 /etc/php
        mkdir -p /run/php/
        rm /etc/php7/php-fpm.d/www.conf
        cp ${SINDRIA_USER_HOME}/sindria.conf /etc/php7/php-fpm.d/sindria.conf
        chown ${SINDRIA_USER}:root /run/php/
        ;;
    7.4)
        apk add php7-fpm
        ln -s /usr/sbin/php-fpm7 /usr/sbin/php-fpm
        ln -s /etc/php7 /etc/php
        mkdir -p /run/php/
        rm /etc/php7/php-fpm.d/www.conf
        cp ${SINDRIA_USER_HOME}/sindria.conf /etc/php7/php-fpm.d/sindria.conf
        chown ${SINDRIA_USER}:root /run/php/
        ;;
    8)
        apk add php8-fpm
        ln -s /usr/sbin/php-fpm8 /usr/sbin/php-fpm
        ln -s /etc/php8 /etc/php
        mkdir -p /run/php/
        rm /etc/php8/php-fpm.d/www.conf
        cp ${SINDRIA_USER_HOME}/sindria.conf /etc/php8/php-fpm.d/sindria.conf
        chown ${SINDRIA_USER}:root /run/php/
        ;;
    *)
        echo "Invalid PHP version specified"
        exit 1
    ;;
esac