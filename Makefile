DOCKER_COMPOSE := docker-compose --file containers/docker-compose.yml --project-name barley

help: ## Show this help.
	@awk -F: '/^[A-Za-z0-9_-]+:.*## / { sub(/.*## /, "", $$2); printf "make %-12s - %s\n", $$1, $$2 }' Makefile

up: ## Build Electron app.
	make up-rust
	make up-js

up-rust: ## Build Rust project.
	$(DOCKER_COMPOSE) up \
	  --abort-on-container-exit \
	  rs-builder

up-js: ## Build JavaScript project.
	$(DOCKER_COMPOSE) up \
	  --abort-on-container-exit \
	  js-builder

reset: ## Recreate containers.
	$(DOCKER_COMPOSE) up \
	  --build \
	  --force-recreate

images: ## Build docker images.
	cd containers; \
	. ./rs.version.sh && ./docker-build.sh; \
	. ./js.version.sh && ./docker-build.sh

all:
	rm -f project-js/dist/*
	make trunk-build
	make up

npm-run: ## Launch Electron app.
	cd project-js; \
	npm run start

trunk-serve: ## Launch dev server.
	cd project-rs; \
	trunk serve \
		--public-url '/' \
		--dist ../project-js/dist

trunk-build: ## Build wasm files.
	cd project-rs; \
	trunk build \
		--dist ../project-js/dist \
		--release
