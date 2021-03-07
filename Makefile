DOCKER_COMPOSE := docker-compose --file containers/docker-compose.yml --project-name barley

help: ## Show this help.
	@awk -F: '/^[A-Za-z0-9_-]+:.*## / { sub(/.*## /, "", $$2); printf "make %-14s - %s\n", $$1, $$2 }' Makefile

assemble: ## Assemble Electron app.
	make rust-main
	make npm-install
	make webpack
	make electron

rust-main: ## Build Rust project for main process.
	$(DOCKER_COMPOSE) run \
	  --rm \
	  -e BARLEY_TASK='main' \
	  app-builder \
	  /barley/containers/rs.build.sh

npm-install: ## Run `npm install`.
	$(DOCKER_COMPOSE) run \
	  --rm \
	  -e BARLEY_TASK='npm-install' \
	  app-builder \
	  /barley/containers/js.build.sh

webpack: ## Run webpack.
	$(DOCKER_COMPOSE) run \
	  --rm \
	  -e BARLEY_TASK='webpack-build' \
	  app-builder \
	  /barley/containers/js.build.sh

electron: ## Build Electron app.
	$(DOCKER_COMPOSE) run \
	  --rm \
	  -e BARLEY_TASK='electron-make' \
	  app-builder \
	  /barley/containers/js.build.sh

electron-start: ## Launch Electron app.
	cd project-js; \
	npm run electron-start

docker-image: ## Build docker image.
	cd containers; \
	. ./version.sh && ./docker-build.sh

reset: ## Recreate containers.
	$(DOCKER_COMPOSE) up \
	  --build \
	  --force-recreate
