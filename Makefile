DOCKER_COMPOSE := docker-compose --file container/docker-compose.yml --project-name barley

up:
	$(DOCKER_COMPOSE) up \
	  --abort-on-container-exit \
	  js-builder

down:
	$(DOCKER_COMPOSE) down

reset:
	$(DOCKER_COMPOSE) up \
	  --build \
	  --force-recreate
