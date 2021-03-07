#!/usr/bin/env bash

# usage:
# $ ./version.sh && ./docker-build.sh

docker build ./ \
  --file ./"$BARLEY_DOCKER_FILE" \
  --tag "$BARLEY_DOCKER_REPOSITORY":"$BARLEY_DOCKER_TAG"
