DOCKER_IMAGE_NAME := danguita/davidanguita.name
DOCKER_BUILD      := docker build --file Dockerfile
DOCKER_RUN        := docker run --rm -v $(shell pwd):/app
SERVER_PORT       := 4567

build: Dockerfile
	$(DOCKER_BUILD) --tag $(DOCKER_IMAGE_NAME) .

clean_build: Dockerfile
	$(DOCKER_BUILD) --no-cache --tag $(DOCKER_IMAGE_NAME) .

run:
	$(DOCKER_RUN) -p $(SERVER_PORT):4567 $(DOCKER_IMAGE_NAME) bundle exec middleman server --environment=development

generate:
	$(DOCKER_RUN) $(DOCKER_IMAGE_NAME) bundle exec middleman build
