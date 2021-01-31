#!/usr/bin/env bash

CONTAINER_GATEWAY=`/sbin/ip route|awk '/default/ { print $3 }'`

# Adding host machine hostname
echo -e "\n# Hostname for gateway" >> /etc/hosts
echo -e "${CONTAINER_GATEWAY}\tdocker.host.internal\n" >> /etc/hosts

# Adding variables to php-fpm pool configuration
sed -i -E "s|\[@@POOL_NAME@@\]|\[${HOSTNAME}-php-fpm-pool\]|g" /etc/php/${PHP_VERSION}/fpm/pool.d/sindria.conf

# Change max children php-fpm pool configuration
if [ "$PHP_PM_MAX_CHILDREN" != "16" ]; then
    sed -i -E "s|pm.max_children = ([0-9]+)|pm.max_children = ${PHP_PM_MAX_CHILDREN}|g" /etc/php/${PHP_VERSION}/fpm/pool.d/sindria.conf
fi

# Override xdebug ide key
if [ "${PHP_XDEBUG_IDE_KEY}" != "phpstorm" ]; then
    sed -i -E "s|phpstorm|${PHP_XDEBUG_IDE_KEY}|g" /etc/php/${PHP_VERSION}/fpm/conf.d/20-xdebug.ini
fi

# Override nginx virtualhost configuration
if [ -e /home/sindria/config/nginx/sites-available/app.conf ]; then
    cp /home/sindria/config/nginx/sites-available/app.conf /etc/nginx/sites-enabled/
fi

# Override php.ini fpm if config file exists
if [ -e /home/sindria/config/php/fpm/php.ini ]; then
    cp /home/sindria/config/php/fpm/php.ini /etc/php/${PHP_VERSION}/fpm/php.ini
fi

# Override php.ini cli if config file exists
if [ -e /home/sindria/config/php/cli/php.ini ]; then
    cp /home/sindria/config/php/cli/php.ini /etc/php/${PHP_VERSION}/cli/php.ini
fi

# Override cron.d configuration
if [ -e /home/sindria/config/cron.d/app ]; then
    cp /home/sindria/config/cron.d/app /etc/cron.d/
fi

# Fix permission
chown root:root /etc/cron.d/*
chmod 644 /etc/cron.d/*
chown -R sindria:sindria /var/www/app

# Override timezone by env
if [ "$TZ" != "" ] || [ "$TZ" != "Europe/Rome" ]; then
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
fi

# Override host user uid by env
if [ "$HOST_USER_UID" != "1000" ]; then
    usermod -u $HOST_USER_UID sindria && groupmod sindria -g $HOST_USER_UID
fi

# Override default sindria user password by env
if [ "$DEFAULT_SINDRIA_USER_PASSWORD" != "sindria" ]; then
    echo "${DEFAULT_SINDRIA_USER_PASSWORD}:${SINDRIA_USER}" | chpasswd
fi

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
