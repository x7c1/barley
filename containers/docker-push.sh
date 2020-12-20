#!/usr/bin/env bash

# usage:
# $ echo "$CR_PAT" | docker login ghcr.io --username x7c1 --password-stdin
# $ ./docker-push.sh "js.Dockerfile" "js-0.1"

repository="x7c1/barley"
file="$1"
tag="$2"

docker build ./ \
  --file ./"$file" \
  --tag ghcr.io/$repository:"$tag"

docker push ghcr.io/$repository:$tag
