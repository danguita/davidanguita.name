DOCKER_IMAGE_NAME := danguita/davidanguita.name
DOCKER_IMAGE_TAG  := latest
DOCKER_BUILD      := docker build --file Dockerfile
DOCKER_RUN        := docker run --rm -v $(shell pwd):/app
SERVER_PORT       := 4567

.PHONY: build
build: Dockerfile
	$(DOCKER_BUILD) --tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .

.PHONY: clean_build
clean_build: Dockerfile
	$(DOCKER_BUILD) --no-cache --tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .

.PHONY: server
server:
	$(DOCKER_RUN) -p $(SERVER_PORT):4567 $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) \
		bundle exec middleman server --verbose --environment=development

.PHONY: generate
generate:
	$(DOCKER_RUN) $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) \
		bundle exec middleman build --verbose

.PHONY: shell
shell:
	$(DOCKER_RUN) -it $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) /bin/sh
