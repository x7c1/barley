DOCKER_COMPOSE := docker-compose --file containers/docker-compose.yml --project-name barley

help: ## Show this help.
	@awk -F: '/^[A-Za-z0-9_-]+:.*## / { sub(/.*## /, "", $$2); printf "make %-16s - %s\n", $$1, $$2 }' Makefile

up: ## Assemble Electron app.
	make up-rust-main
	make up-rust-renderer
	make npm-install
	make webpack
	make electron

up-rust-renderer: ## Build Rust project for renderer process.
	$(DOCKER_COMPOSE) run \
	  --rm \
	  -e BARLEY_BUILD_KIND='renderer' \
	  rs-builder \
	  /barley/containers/rs.build.sh

up-rust-main: ## Build Rust project for main process.
	$(DOCKER_COMPOSE) run \
	  --rm \
	  -e BARLEY_BUILD_KIND='main' \
	  rs-builder \
	  /barley/containers/rs.build.sh

npm-install: ## Run `npm install`.
	$(DOCKER_COMPOSE) run \
	  --rm \
	  -e BARLEY_BUILD_KIND='npm-install' \
	  js-builder \
	  /barley/containers/js.build.sh

electron: ## Build Electron app.
	$(DOCKER_COMPOSE) run \
	  --rm \
	  -e BARLEY_BUILD_KIND='electron-make' \
	  js-builder \
	  /barley/containers/js.build.sh

webpack: ## Run webpack.
	$(DOCKER_COMPOSE) run \
	  --rm \
	  -e BARLEY_BUILD_KIND='webpack-build' \
	  js-builder \
	  /barley/containers/js.build.sh

reset: ## Recreate containers.
	$(DOCKER_COMPOSE) up \
	  --build \
	  --force-recreate

docker-image: ## Build docker image.
	cd containers; \
	. ./version.sh && ./docker-build.sh

clear:
	rm -f project-js/dist/*

run-electron: ## Launch Electron app.
	cd project-js; \
	npm run electron-start

trunk-serve: ## Launch dev server.
	cd project-rs; \
	trunk serve \
		app/index.html \
		--public-url '/' \
		--dist ../project-js/dist
