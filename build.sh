#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    echo "Provide user UID"
    exit 1
fi

if [[ -z "$2" ]]; then
    echo "Provide a tag version as second argument (eg. 1.0.0)"
    exit 1
fi


if [[ -z "$3" ]]; then
    echo "Provide a valid php version as first argument (5.6 7.0 7.1 7.2 7.3 7.4)"
    exit 1
fi

IMAGE_NAME="registry.sindria.org/docker-images/nginx-php"

HOST_USER_UID=$1
TAG_VERSION=$2
TAG_SUFFIX=$3
TIMEZONE=Europe/Rome

FULL_IMAGE_NAME="${IMAGE_NAME}:${TAG_VERSION}-${TAG_SUFFIX}"

docker build ./src \
    --tag ${FULL_IMAGE_NAME} \
    --build-arg TAG_VERSION=${TAG_VERSION} \
    --build-arg TAG_SUFFIX=${TAG_SUFFIX} \
    --build-arg HOST_USER_UID=${HOST_USER_UID} \
    --build-arg PHP_VERSION=${TAG_SUFFIX} \
    --build-arg TIMEZONE=${TIMEZONE}
