DOCKER_COMPOSE := docker-compose --file containers/docker-compose.yml --project-name barley

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

run:
	cd project-js && npm run start
