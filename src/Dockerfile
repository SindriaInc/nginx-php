# Download base image ubuntu 18.04
FROM ubuntu:18.04

ARG TAG_VERSION
ARG TAG_SUFFIX
ARG TAG_ENV
ARG HOST_USER_UID
ARG TIMEZONE

LABEL \
	name="sindriainc/nginx-php" \
	image="nginx-php" \
	tag="${TAG_VERSION}-${TAG_SUFFIX}-${TAG_ENV}" \
	vendor="sindria"

ENV DEBIAN_FRONTEND="noninteractive"
ENV HOST_USER_UID ${HOST_USER_UID}
ENV TZ=${TIMEZONE}
ENV SINDRIA_USER="sindria"
ENV SINDRIA_USER_HOME="/home/sindria"
ENV DEFAULT_SINDRIA_USER_PASSWORD="sindria"
ENV PHP_VERSION=${TAG_SUFFIX}
ENV PHP_PM_MAX_CHILDREN=16
ENV PHP_XDEBUG_IDE_KEY PHPSTORM

RUN apt-get update && \
    apt-get install -y --no-install-recommends aptitude apt-utils software-properties-common && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    add-apt-repository -y ppa:nginx/stable && \
    apt-get update && \
    apt-get install -y --no-install-recommends gpg-agent curl supervisor nginx cron openssh-server iproute2 && \
    rm -rf /var/lib/apt/lists/*

# Adding sindria user
RUN useradd ${SINDRIA_USER} -u ${HOST_USER_UID} -d ${SINDRIA_USER_HOME} -s /bin/bash && \
    groupmod ${SINDRIA_USER} -g ${HOST_USER_UID} && \
    mkdir -p ${SINDRIA_USER_HOME}/bin/installers && \
    mkdir -p ${SINDRIA_USER_HOME}/config

COPY resources/installers/* ${SINDRIA_USER_HOME}/bin/installers

# Installing selected php version and development software kit
RUN bash ${SINDRIA_USER_HOME}/bin/installers/sindria_install_php.sh ${PHP_VERSION} ${TAG_ENV}

# SSH configuration
COPY resources/ssh/sshd_config /etc/ssh/sshd_config
RUN mkdir -p /run/sshd && \
    ln -s /var/www/app ${SINDRIA_USER_HOME}/app && \
    chmod 751 /home && \
    chmod 751 /var && \
    mkdir -p ${SINDRIA_USER_HOME}/.ssh && \
    touch ${SINDRIA_USER_HOME}/.ssh/authorized_keys && \
    chmod 700 ${SINDRIA_USER_HOME}/.ssh && \
    chmod 600 ${SINDRIA_USER_HOME}/.ssh/* && \
    chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME} && \
    echo "${DEFAULT_SINDRIA_USER_PASSWORD}:${SINDRIA_USER}" | chpasswd

# Nginx configuration
RUN mkdir -p /etc/nginx/sites-enabled
COPY resources/nginx/nginx.conf /etc/nginx/
COPY resources/nginx/conf.d/* /etc/nginx/conf.d/
COPY resources/nginx/sites-available/app.conf /etc/nginx/sites-enabled/

# PHP configuration
# Create a symlink for php-fpm executable and removing www fpm pools
RUN ln -s /usr/sbin/php-fpm${PHP_VERSION} /usr/sbin/php-fpm && \
    mkdir -p /run/php/ && \
    chown ${SINDRIA_USER}:root /run/php/ && \
    rm /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
COPY resources/php/fpm/pool.d/sindria.conf /etc/php/${PHP_VERSION}/fpm/pool.d/sindria.conf

# Supervisor configuration
COPY resources/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY resources/supervisor/conf.d/*.conf /etc/supervisor/conf.d/

# Setting up volume
RUN mkdir -p /var/www/app && \
    chown -R ${SINDRIA_USER}:${SINDRIA_USER} /var/www/app

WORKDIR /var/www/app

# Add and execute startup command
COPY startup.sh /startup.sh
CMD ["/bin/bash", "/startup.sh"]

EXPOSE 80 22
