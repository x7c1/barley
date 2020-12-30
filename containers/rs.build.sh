#!/usr/bin/env bash

set -xue

main() {
  cd /barley/project-rs

  case $BARLEY_BUILD_KIND in
  "main" )
    for_main_process ;;
  "renderer" )
    for_renderer_process ;;
  * )
    when_unknown_build_kind ;;
  esac
}

for_main_process() {
  echo "build for main process"

  wasm-pack build \
    barley-main \
    --target nodejs \
    --out-dir /barley/project-js/barley-main \
    --release

  ls -lh /barley/project-js/barley-main
}

for_renderer_process() {
  echo "build for renderer process"

  wasm-pack build \
    app \
    --target bundler \
    --out-dir /barley/project-js/barley-renderer \
    --release

  ls -lh /barley/project-js/barley-renderer
}

when_unknown_build_kind() {
  echo "unknown BARLEY_BUILD_KIND=$BARLEY_BUILD_KIND"
  exit 1
}

main
