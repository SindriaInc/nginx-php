#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    echo "Provide image name as first argument (eg. sindriainc/<repo-slug>)"
    exit 1
fi

if [[ -z "$2" ]]; then
    echo "Provide a tag version as second argument (eg. 1.0.0, local)"
    exit 1
fi

IMAGE_NAME=$1
TAG_VERSION=$2

for PHP_VERSION in 7.0 7.1 7.2 7.4 8
do
	bash build.sh ${IMAGE_NAME} ${TAG_VERSION} ${PHP_VERSION}
  docker push ${IMAGE_NAME}:${TAG_VERSION}-${PHP_VERSION}
done