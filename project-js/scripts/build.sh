#!/usr/bin/env bash

set -xue

node -v

cd /barley/project-js

npm install

npm run make

ls -lh out/make/deb/x64
