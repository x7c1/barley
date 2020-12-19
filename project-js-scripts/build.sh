#!/usr/bin/env bash

set -xue

node -v

cd /barley/project-js

npm install

npm run make

ls -al out/make/deb/x64
