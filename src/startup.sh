#!/usr/bin/env bash

CONTAINER_GATEWAY=`/sbin/ip route|awk '/default/ { print $3 }'`

# Adding host machine hostname
echo -e "\n# Hostname for gateway" >> /etc/hosts
echo -e "${CONTAINER_GATEWAY}\tdocker.host.internal\n" >> /etc/hosts

# Configuring email relay
sed -i -E "s|rewriteDomain=([a-zA-Z0-9\.\-]+)|rewriteDomain=${VIRTUAL_HOST}|g" /etc/ssmtp/ssmtp.conf
sed -i -E "s|hostname=([a-zA-Z0-9\.\-]+)|hostname=${VIRTUAL_HOST}|g" /etc/ssmtp/ssmtp.conf

# Adding variables to php-fpm pool configuration
sed -i -E "s|\[@@POOL_NAME@@\]|\[${HOSTNAME}-php-fpm-pool\]|g" /etc/php/${PHP_VERSION}/fpm/pool.d/sindria.conf
sed -i -E "s|pm.max_children = ([0-9]+)|pm.max_children = ${PHP_PM_MAX_CHILDREN}|g" /etc/php/${PHP_VERSION}/fpm/pool.d/sindria.conf

# Copying nginx virtualhost(s) configuration(s)
cp /home/sindria/config/nginx/sites/*.conf /etc/nginx/sites/

# Check if php.ini config exists
if [ -e /home/sindria/config/php/fpm/php.ini ]; then
    cp /home/sindria/config/php/fpm/php.ini /etc/php/${PHP_VERSION}/fpm/php.ini
fi

# Copying cron.d configuration
cp /home/sindria/config/cron.d/* /etc/cron.d/
chown root:root /etc/cron.d/*
chmod 644 /etc/cron.d/*

chown -R sindria:sindria /var/www/app

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf