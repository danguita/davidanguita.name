DOCKER_IMAGE_NAME := danguita/davidanguita.name
DOCKER_BUILD      := docker build --file Dockerfile
DOCKER_RUN        := docker run --rm -v $(shell pwd):/app
SERVER_PORT       := 4567

.PHONY: build
build: Dockerfile
	$(DOCKER_BUILD) --tag $(DOCKER_IMAGE_NAME) .

.PHONY: clean_build
clean_build: Dockerfile
	$(DOCKER_BUILD) --no-cache --tag $(DOCKER_IMAGE_NAME) .

.PHONY: run
run:
	$(DOCKER_RUN) -p $(SERVER_PORT):4567 $(DOCKER_IMAGE_NAME) bundle exec middleman server --environment=development

.PHONY: generate
generate:
	$(DOCKER_RUN) $(DOCKER_IMAGE_NAME) bundle exec middleman build
