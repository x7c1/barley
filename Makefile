DOCKER_COMPOSE := docker-compose --file containers/docker-compose.yml --project-name barley

help: ## Show this help.
	@awk -F: '/^[A-Za-z0-9_-]+:.*## / { sub(/.*## /, "", $$2); printf "make %-12s - %s\n", $$1, $$2 }' Makefile

all: ## Assemble Electron app.
	make rust-main
	make npm-install
	make webpack
	make electron

rust-main: ## Build Rust project for main process.
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
