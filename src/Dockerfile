# Extends nginx-php base image
ARG TAG_SUFFIX
ARG TAG_ENV
FROM sindriainc/nginx-php:2.0.0-${TAG_SUFFIX}-${TAG_ENV}

ARG TAG_VERSION
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

WORKDIR /var/www/app

# Timezone configuration
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Nginx configuration
COPY resources/nginx/sites-available/app.conf /etc/nginx/sites-enabled/app.conf
