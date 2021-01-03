#!/usr/bin/env bash

set -xue

main() {
  cd /barley/project-rs

  case $BARLEY_TASK in
  "main" )
    for_main_process ;;
  "renderer" )
    for_renderer_process ;;
  * )
    for_unknown_task ;;
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

for_unknown_task() {
  echo "unknown BARLEY_TASK=$BARLEY_TASK"
  exit 1
}

main
