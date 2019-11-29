# Download base image ubuntu 18.04
FROM ubuntu:18.04

ARG TAG_VERSION
ARG TAG_SUFFIX
ARG TAG_ENV
ARG HOST_USER_UID
ARG TIMEZONE

LABEL \
	name="sindria/nginx-php" \
	image="registry.sindria.org/nginx-php" \
	tag="${TAG_VERSION}-${TAG_SUFFIX}-${TAG_ENV}" \
	vendor="sindria"

ENV DEBIAN_FRONTEND="noninteractive" \
        TZ=${TIMEZONE} \
	SINDRIA_USER="sindria" \
	SINDRIA_USER_HOME="/home/sindria" \
	PHP_VERSION=${TAG_SUFFIX} \
	PHP_PM_MAX_CHILDREN=16

RUN apt-get update && \
    apt-get install -y --no-install-recommends aptitude apt-utils software-properties-common && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    add-apt-repository -y ppa:nginx/stable && \
    apt-get update && \
    apt-get install -y --no-install-recommends gpg-agent ssmtp curl vim unzip supervisor nginx cron iproute2 && \
    rm -rf /var/lib/apt/lists/*

# Adding sindria user
RUN useradd ${SINDRIA_USER} -u ${HOST_USER_UID} -d ${SINDRIA_USER_HOME} -s /bin/bash && \
    groupmod ${SINDRIA_USER} -g ${HOST_USER_UID} && \
    mkdir -p ${SINDRIA_USER_HOME}/bin/installers && \
    mkdir -p ${SINDRIA_USER_HOME}/config

COPY ./src/installers/* ${SINDRIA_USER_HOME}/bin/installers

COPY ./src/.bash_aliases /root/.bash_aliases
RUN cp /root/.bashrc ${SINDRIA_USER_HOME}/.bashrc && \
    cp /root/.bash_aliases ${SINDRIA_USER_HOME}/.bash_aliases && \
    chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME}

# Installing selected php version and development software kit
RUN ${SINDRIA_USER_HOME}/bin/installers/sindria_install_php.sh ${PHP_VERSION} ${TAG_ENV}

# nginx configuration
RUN mkdir /etc/nginx/sites
COPY ./src/nginx/nginx.conf /etc/nginx/
COPY ./src/nginx/conf.d/*.conf /etc/nginx/conf.d/

# PHP configuration
# Create a symlink for php-fpm executable and removing www fpm pools
RUN ln -s /usr/sbin/php-fpm${PHP_VERSION} /usr/sbin/php-fpm && \
    mkdir /run/php/ && \
    chown ${SINDRIA_USER}:root /run/php/ && \
    rm /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
COPY ./src/php/fpm/sindria.conf /etc/php/${PHP_VERSION}/fpm/pool.d/sindria.conf

# Email configuration
COPY ./src/mail/ssmtp.conf /etc/ssmtp/ssmtp.conf

# Supervisor configuration
COPY ./src/supervisor/supervisor.conf /etc/supervisor/supervisor.conf
COPY ./src/supervisor/conf.d/*.conf /etc/supervisor/conf.d/

# Setting up volume
RUN mkdir -p /var/www/app && \
    chown -R ${SINDRIA_USER}:${SINDRIA_USER} /var/www/app

WORKDIR /var/www/app

# Add and execute startup command
COPY ./src/startup.sh /startup.sh
CMD ["/bin/bash", "/startup.sh"]

EXPOSE 80
