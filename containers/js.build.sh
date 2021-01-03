#!/usr/bin/env bash

set -xue

main() {
  cd /barley/project-js

  case $BARLEY_TASK in
  "npm-install" )
    for_npm_install ;;
  "electron-make" )
    for_electron_make ;;
  "webpack-server" )
    for_webpack_server ;;
  "webpack-build" )
    for_webpack_build ;;
  * )
    for_unknown_task ;;
  esac
}

for_npm_install() {
  # workaround
  # https://github.com/mapbox/node-pre-gyp/issues/477#issuecomment-689923448
  apt-get install -y build-essential python

  npm install
}

for_electron_make() {
  echo "build electron app"
  npm run electron-make

  ls -alh out/barley-linux-x64
  ls -alh out/make/deb/x64
}

for_webpack_server() {
  echo "launch webpack-dev-server"
  npm run webpack-start
}

for_webpack_build() {
  npm run webpack-build
  ls -alh pkg
  ls -alh dist
}

for_unknown_task() {
  echo "unknown BARLEY_TASK=$BARLEY_TASK"
  exit 1
}

main
