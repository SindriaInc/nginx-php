#!/usr/bin/env bash

CONTAINER_GATEWAY=`/sbin/ip route|awk '/default/ { print $3 }'`

# Adding host machine hostname
echo -e "\n# Hostname for gateway" >> /etc/hosts
echo -e "${CONTAINER_GATEWAY}\tdocker.host.internal\n" >> /etc/hosts

# Configuring email relay
#sed -i -E "s|rewriteDomain=([a-zA-Z0-9\.\-]+)|rewriteDomain=${VIRTUAL_HOST}|g" /etc/ssmtp/ssmtp.conf
#sed -i -E "s|hostname=([a-zA-Z0-9\.\-]+)|hostname=${VIRTUAL_HOST}|g" /etc/ssmtp/ssmtp.conf

# Adding variables to php-fpm pool configuration
sed -i -E "s|\[@@POOL_NAME@@\]|\[${HOSTNAME}-php-fpm-pool\]|g" /etc/php/${PHP_VERSION}/fpm/pool.d/sindria.conf
sed -i -E "s|pm.max_children = ([0-9]+)|pm.max_children = ${PHP_PM_MAX_CHILDREN}|g" /etc/php/${PHP_VERSION}/fpm/pool.d/sindria.conf

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
    chown root:root /etc/cron.d/*
    chmod 644 /etc/cron.d/*
fi

# Fix permission
chown -R sindria:sindria /var/www/app

# Override timezone by env
if [ "$TZ" != "" ]; then
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
fi

# Override host user uid by env
if [ "$HOST_USER_UID" != "" ] || [ $HOST_USER_UID != 1000 ]; then
    usermod -u $HOST_USER_UID sindria && groupmod sindria -g $HOST_USER_UID
fi

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf