#!/usr/bin/env bash

set -xue

cd /barley/project-rs

trunk build \
  app/Cargo.toml \
  --dist /barley/project-js/dist \
  --release

ls -lh target/wasm32-unknown-unknown/release
ls -lh target/wasm-bindgen/release
