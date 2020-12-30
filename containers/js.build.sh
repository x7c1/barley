#!/usr/bin/env bash

set -xue

main() {
  cd /barley/project-js

  case $BARLEY_BUILD_KIND in
  "electron-make" )
    for_electron_make ;;
  "webpack-server" )
    for_webpack_server ;;
  "webpack-build" )
    for_webpack_build ;;
  * )
    when_unknown_build_kind ;;
  esac
}

for_electron_make() {
  echo "build electron app"
  npm install
  npm run electron-make
}

for_webpack_server() {
  echo "launch webpack-dev-server"
  npm run webpack-start
}

for_webpack_build() {
  echo "run webpack"
  npm run webpack
}

when_unknown_build_kind() {
  echo "unknown BARLEY_BUILD_KIND=$BARLEY_BUILD_KIND"
  exit 1
}

main
