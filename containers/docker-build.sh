#!/usr/bin/env bash

# usage:
# $ ./docker-build.sh "js.Dockerfile" "js-0.1"

BARLEY_DOCKER_REPOSITORY="ghcr.io/x7c1/barley"

docker build ./ \
  --file ./"$BARLEY_DOCKER_FILE" \
  --tag $BARLEY_DOCKER_REPOSITORY:"$BARLEY_DOCKER_TAG"
