#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    echo "Provide a valid php version as first argument (5.6 7.0 7.1 7.2 7.3)"
    exit 1
fi

if [[ -z "$2" ]]; then
    echo "Provide a tag suffix as second argument (prod or dev)"
    exit 1
fi

if [[ -z "$3" ]]; then
    echo "Provide user UID"
    exit 1
fi

IMAGE_NAME="registry.sindria.org/nginx-php"
TAG_VERSION=2.0.1

PHP_VERSION=$1
TAG_SUFFIX=$2
HOST_USER_UID=$3
TIMEZONE=Europe/Rome

FULL_IMAGE_NAME="${IMAGE_NAME}-${PHP_VERSION}:${TAG_VERSION}-${TAG_SUFFIX}"

docker build --file ./Dockerfile \
    --tag ${FULL_IMAGE_NAME} \
    --build-arg TAG_VERSION=${TAG_VERSION} \
    --build-arg TAG_SUFFIX=${TAG_SUFFIX} \
    --build-arg HOST_USER_UID=${HOST_USER_UID} \
    --build-arg PHP_VERSION=${PHP_VERSION} \
    --build-arg TIMEZONE=${TIMEZONE} \
    .
