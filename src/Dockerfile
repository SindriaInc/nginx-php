ARG TAG_SUFFIX
FROM sindriainc/php:1.0.0-${TAG_SUFFIX}

ARG TAG_VERSION
ARG HOST_USER_UID
ARG TIMEZONE

LABEL \
	name="sindriainc/nginx-php" \
	image="nginx-php" \
	tag="${TAG_VERSION}-${TAG_SUFFIX}" \
	vendor="sindria"

ENV HOST_USER_UID ${HOST_USER_UID}
ENV TZ=${TIMEZONE}
ENV SINDRIA_USER="sindria"
ENV SINDRIA_USER_HOME="/home/sindria"
ENV PHP_VERSION=${TAG_SUFFIX}
ENV PHP_PM_MAX_CHILDREN=16

# Install packages
RUN apk add \
    nginx && \
    docker-php-ext-install \
    fpm && \
    docker-php-ext-enable \
    fpm

# Nginx configuration
RUN mkdir -p /run/nginx && \
    rm -rf /etc/nginx/conf.d/default.conf && \
    mkdir -p /etc/nginx/sites-enabled
COPY resources/nginx/nginx.conf /etc/nginx/
COPY resources/nginx/conf.d/*.conf /etc/nginx/conf.d/
COPY resources/nginx/sites-enabled/app.conf /etc/nginx/sites-enabled/

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

# Add and execute startup command
COPY startup.sh /startup.sh
CMD ["/bin/bash", "/startup.sh"]

EXPOSE 80