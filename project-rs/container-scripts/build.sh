#!/usr/bin/env bash

set -xue

cd /barley/project-js

trunk build \
  --dist ../project-js/dist \
  --release
