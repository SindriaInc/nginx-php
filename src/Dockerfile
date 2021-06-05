ARG TAG_SUFFIX
FROM sindriainc/php:1.0.0-${TAG_SUFFIX}

ARG TAG_VERSION
ARG TAG_SUFFIX
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
    supervisor \
    nginx && \
    rm -rf /var/cache/apk/*

# Install fpm
COPY resources/php/fpm/pool.d/sindria.conf ${SINDRIA_USER_HOME}
COPY resources/php/install.sh ${SINDRIA_USER_HOME}
RUN bash ${SINDRIA_USER_HOME}/install.sh ${PHP_VERSION} && \
    rm -rf ${SINDRIA_USER_HOME}/install.sh && \
    rm -rf ${SINDRIA_USER_HOME}/sindria.conf && \
    rm -rf /var/cache/apk/*

ENV PHP_MAJOR_VERSION=${MAJOR_VERSION}

# Nginx configuration
RUN mkdir -p /run/nginx && \
    rm -rf /etc/nginx/conf.d/default.conf && \
    mkdir -p /etc/nginx/sites-enabled
COPY resources/nginx/nginx.conf /etc/nginx/
COPY resources/nginx/conf.d/*.conf /etc/nginx/conf.d/
COPY resources/nginx/sites-available/app.conf /etc/nginx/sites-enabled/

# Supervisor configuration
COPY resources/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY resources/supervisor/conf.d/*.conf /etc/supervisor/conf.d/
RUN mkdir -p /var/log/supervisor && \
    touch /var/log/supervisor/supervisord.log

ENTRYPOINT [""]

# Add and execute startup command
COPY startup.sh /startup.sh
CMD ["/bin/bash", "/startup.sh"]

EXPOSE 80

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping