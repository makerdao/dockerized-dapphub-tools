#! /usr/bin/env bash

set -e

function message() {
    echo
    echo -----------------------------------
    echo "$@"
    echo -----------------------------------
    echo
}

BUILD_NUMBER=$1
DOCKER_IMAGE_NAME="makerdao/dapphub-tools"
TAG=$BUILD_NUMBER

if [ -z "$BUILD_NUMBER" ]; then
    echo 'This build requires a Travis build number. (bash ./.travis/build.sh $TRAVIS_BUILD_NUMBER)'
    exit 1
fi
echo $BUILD_NUMBER

# build image
message BUILDING IMAGE
docker build --tag "$DOCKER_IMAGE_NAME:$TAG" --tag "$DOCKER_IMAGE_NAME:latest" .
# docker login
echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USER" --password-stdin
# docker push
docker push "$DOCKER_IMAGE_NAME:$TAG"
docker push "$DOCKER_IMAGE_NAME:latest"