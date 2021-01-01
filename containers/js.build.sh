#!/usr/bin/env bash

set -xue

main() {
  cd /barley/project-js

  case $BARLEY_BUILD_KIND in
  "npm-install" )
    for_npm_install ;;
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

for_npm_install() {
  python3 -V

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
  npm run webpack
  ls -alh pkg
}

when_unknown_build_kind() {
  echo "unknown BARLEY_BUILD_KIND=$BARLEY_BUILD_KIND"
  exit 1
}

main
