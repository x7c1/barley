#!/usr/bin/env bash

# usage:
# $ echo "$CR_PAT" | docker login ghcr.io --username ${your_name} --password-stdin
# $ ./js.version.sh && ./docker-push.sh

./docker-build.sh

docker push "$BARLEY_DOCKER_REPOSITORY":"$BARLEY_DOCKER_TAG"
