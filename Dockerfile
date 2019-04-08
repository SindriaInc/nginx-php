# Download base image ubuntu 18.04
FROM ubuntu:18.04

ARG HOST_USER_UID
ARG PHP_VERSION

LABEL \
	name="sindria's PHP-FPM ${PHP_VERSION} Image" \
	image="sindria/nginx-php-${PHP_VERSION}" \
	tag="nginx-php-${PHP_VERSION}" \
	vendor="sindria"

ENV DEBIAN_FRONTEND="noninteractive" \
	SINDRIA_USER="sindria" \
	SINDRIA_USER_HOME="/home/sindria" \
	SINDRIA_APP_CODE_PATH="/var/www/app" \
	SINDRIA_HOST_USER_UID=${SINDRIA_HOST_USER_UID} \
	SINDRIA_PHP_VERSION=${PHP_VERSION}

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y aptitude apt-utils software-properties-common

# Adding nginx stable repo
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get upgrade -y

# Adding sindria user user
RUN useradd ${SINDRIA_USER} -u ${SINDRIA_HOST_USER_UID} -d ${SINDRIA_USER_HOME} -s /bin/bash
RUN groupmod ${SINDRIA_USER} -g ${SINDRIA_HOST_USER_UID}
RUN mkdir -p ${SINDRIA_USER_HOME}/bin/installers
COPY ./installers/* ${SINDRIA_USER_HOME}/bin/installers
RUN mkdir -p ${SINDRIA_USER_HOME}/config

COPY .bash_aliases /root/.bash_aliases
RUN cp /root/.bashrc ${SINDRIA_USER_HOME}/.bashrc
RUN cp /root/.bash_aliases ${SINDRIA_USER_HOME}/.bash_aliases
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME}

RUN apt-get install -y ssmtp curl vim unzip supervisor nginx nodejs npm iproute2

# Installing selected php version
RUN ${SINDRIA_USER_HOME}/bin/installers/sindria_install_php.sh ${NGINX_PHP_VERSION}

# nginx configuration
RUN mkdir /etc/nginx/sites
COPY nginx/nginx.conf /etc/nginx/
COPY nginx/conf.d/*.conf /etc/nginx/conf.d/

# Removing unused www pool
RUN rm /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

# PHP configuration
# Create a symlink for php-fpm executable
RUN ln -s /usr/sbin/php-fpm${PHP_VERSION} /usr/sbin/php-fpm
RUN mkdir /run/php/
RUN chown ${SINDRIA_USER}:root /run/php/
COPY php/fpm/sindria.conf /etc/php/${PHP_VERSION}/fpm/pool.d/sindria.conf

# Email configuration
COPY mail/ssmtp.conf /etc/ssmtp/ssmtp.conf

# Supervisor configuration
COPY supervisor/supervisor.conf /etc/supervisor/supervisor.conf
COPY supervisor/*.conf /etc/supervisor/conf.d/

# Setting up volume
RUN mkdir -p ${SINDRIA_APP_CODE_PATH}
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_APP_CODE_PATH}
VOLUME ${SINDRIA_APP_CODE_PATH}

# Add and execute startup command
COPY ./startup.sh /startup.sh
CMD ["/bin/bash", "/startup.sh"]

EXPOSE 80
