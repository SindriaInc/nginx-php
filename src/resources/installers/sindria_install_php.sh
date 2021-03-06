#!/usr/bin/env bash

PHP_VERSION=$1
TAG_ENV=$2

LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
apt-get update

case ${PHP_VERSION} in
    5.6)
        apt-get install -y --no-install-recommends php5.6 php5.6-calendar php5.6-ctype php5.6-curl php5.6-dom \
                php5.6-exif php5.6-fileinfo php5.6-ftp php5.6-gd php5.6-gettext php5.6-iconv php5.6-intl php5.6-json\
                php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-mysqli php5.6-mysqlnd\
                php5.6-PDO php5.6-Phar php5.6-posix php5.6-readline php5.6-shmop\
                php5.6-SimpleXML php5.6-sockets php5.6-sysvmsg php5.6-sysvsem php5.6-sysvshm\
                php5.6-tokenizer php5.6-wddx php5.6-xml php5.6-xmlreader php5.6-xmlwriter\
                php5.6-xsl php5.6-opcache php5.6-zip php5.6-fpm php5.6-bcmath php5.6-imap php5.6-soap
        ;;
    7.0)
        apt-get install -y --no-install-recommends php7.0 php7.0-calendar php7.0-ctype php7.0-curl php7.0-dom \
                php7.0-exif php7.0-fileinfo php7.0-ftp php7.0-gd php7.0-gettext php7.0-iconv php7.0-intl php7.0-json \
                php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-mysqli php7.0-mysqlnd \
                php7.0-PDO php7.0-Phar php7.0-posix php7.0-readline php7.0-shmop \
                php7.0-SimpleXML php7.0-sockets php7.0-sysvmsg php7.0-sysvsem php7.0-sysvshm \
                php7.0-tokenizer php7.0-wddx php7.0-xml php7.0-xmlreader php7.0-xmlwriter \
                php7.0-xsl php7.0-opcache php7.0-zip php7.0-fpm php7.0-bcmath php7.0-imap php7.0-soap
        ;;
    7.1)
        apt-get install -y --no-install-recommends php7.1 php7.1-calendar php7.1-ctype php7.1-curl php7.1-dom \
                php7.1-exif php7.1-fileinfo php7.1-ftp php7.1-gd php7.1-gettext php7.1-iconv php7.1-intl php7.1-json \
                php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-mysqli php7.1-mysqlnd \
                php7.1-PDO php7.1-Phar php7.1-posix php7.1-readline php7.1-shmop \
                php7.1-SimpleXML php7.1-sockets php7.1-sysvmsg php7.1-sysvsem php7.1-sysvshm \
                php7.1-tokenizer php7.1-wddx php7.1-xml php7.1-xmlreader php7.1-xmlwriter \
                php7.1-xsl php7.1-opcache php7.1-zip php7.1-fpm php7.1-bcmath php7.1-imap php7.1-soap
        ;;
    7.2)
        apt-get install -y --no-install-recommends php7.2 php7.2-calendar php7.2-ctype php7.2-curl php7.2-dom \
                php7.2-exif php7.2-fileinfo php7.2-ftp php7.2-gd php7.2-gettext php7.2-iconv php7.2-intl php7.2-json \
                php7.2-mbstring php7.2-mysql php7.2-mysqli php7.2-mysqlnd \
                php7.2-PDO php7.2-Phar php7.2-posix php7.2-readline php7.2-shmop \
                php7.2-SimpleXML php7.2-sockets php7.2-sysvmsg php7.2-sysvsem php7.2-sysvshm \
                php7.2-tokenizer php7.2-wddx php7.2-xml php7.2-xmlreader php7.2-xmlwriter \
                php7.2-xsl php7.2-opcache php7.2-zip php7.2-fpm php7.2-bcmath php7.2-imap php7.2-soap
        ;;
    7.3)
        apt-get install -y --no-install-recommends php7.3 php7.3-calendar php7.3-ctype php7.3-curl php7.3-dom \
                php7.3-exif php7.3-fileinfo php7.3-ftp php7.3-gd php7.3-gettext php7.3-iconv php7.3-intl php7.3-json \
                php7.3-mbstring php7.3-mysql php7.3-mysqli php7.3-mysqlnd \
                php7.3-PDO php7.3-Phar php7.3-posix php7.3-readline php7.3-shmop \
                php7.3-SimpleXML php7.3-sockets php7.3-sysvmsg php7.3-sysvsem php7.3-sysvshm \
                php7.3-tokenizer php7.3-wddx php7.3-xml php7.3-xmlreader php7.3-xmlwriter \
                php7.3-xsl php7.3-opcache php7.3-zip php7.3-fpm php7.3-bcmath php7.3-imap php7.3-soap
        ;;
    7.4)
        apt-get install -y --no-install-recommends php7.4 php7.4-calendar php7.4-ctype php7.4-curl php7.4-dom \
                php7.4-exif php7.4-fileinfo php7.4-ftp php7.4-gd php7.4-gettext php7.4-iconv php7.4-intl php7.4-json \
                php7.4-mbstring php7.4-mysql php7.4-mysqli php7.4-mysqlnd \
                php7.4-PDO php7.4-Phar php7.4-posix php7.4-readline php7.4-shmop \
                php7.4-SimpleXML php7.4-sockets php7.4-sysvmsg php7.4-sysvsem php7.4-sysvshm \
                php7.4-tokenizer php7.4-xml php7.4-xmlreader php7.4-xmlwriter \
                php7.4-xsl php7.4-opcache php7.4-zip php7.4-fpm php7.4-bcmath php7.4-imap php7.4-soap
        ;;
    *)
        echo "Invalid PHP version specified"
        exit 1
    ;;
esac

# Installing additional PHP extensions
apt-get install --no-install-recommends -y php-memcached php-redis php-imagick php-mongo


if [ ${TAG_ENV} = 'local' ]; then
    # Installing composer
    curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
    # Installing Xdebug
    apt-get install -y --no-install-recommends php-xdebug
    echo "xdebug.mode=${PHP_XDEBUG_MODE}" >> /etc/php/${PHP_VERSION}/fpm/conf.d/20-xdebug.ini
    echo "xdebug.start_with_request=${PHP_XDEBUG_START_WITH_REQUEST}" >> /etc/php/${PHP_VERSION}/fpm/conf.d/20-xdebug.ini
    echo "xdebug.client_host=${PHP_XDEBUG_HOST}" >> /etc/php/${PHP_VERSION}/fpm/conf.d/20-xdebug.ini
    echo "xdebug.client_port=${PHP_XDEBUG_PORT}" >> /etc/php/${PHP_VERSION}/fpm/conf.d/20-xdebug.ini
    echo "xdebug.idekey=${PHP_XDEBUG_IDE_KEY}" >> /etc/php/${PHP_VERSION}/fpm/conf.d/20-xdebug.ini
    echo "xdebug.log=/var/log/xdebug.log" >> /etc/php/${PHP_VERSION}/fpm/conf.d/20-xdebug.ini
    touch /var/log/xdebug.log
    # CS Fixer
    curl -L https://cs.symfony.com/download/php-cs-fixer-v2.phar -o /usr/local/bin/php-cs-fixer
    chmod +x /usr/local/bin/php-cs-fixer
    # PHP Code Sniffer
    curl -L https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /usr/local/bin/phpcs
    curl -L https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar -o /usr/local/bin/phpcbf
    chmod +x /usr/local/bin/phpcs
    chmod +x /usr/local/bin/phpcbf
    # Installing Node.js
    apt-get install -y --no-install-recommends nodejs npm
    curl -sL https://deb.nodesource.com/setup_12.x | bash -
    apt-get install --no-install-recommends -y nodejs
    # Installing packages
    apt-get install --no-install-recommends -y wget vim unzip git rsync net-tools iputils-ping
fi

# Cleaning
rm -rf /var/lib/apt/lists/*
