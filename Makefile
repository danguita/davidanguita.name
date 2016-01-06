DOCKER_IMAGE_NAME := danguita/middleman
DOCKER_BUILD      := docker build --file Dockerfile
DOCKER_RUN        := docker run -it --rm -v $(shell pwd):/app

build: Dockerfile
	$(DOCKER_BUILD) --tag $(DOCKER_IMAGE_NAME) .

clean_build: Dockerfile
	$(DOCKER_BUILD) --no-cache --tag $(DOCKER_IMAGE_NAME) .

run:
	$(DOCKER_RUN) -p 4567:4567 $(DOCKER_IMAGE_NAME)

generate:
	$(DOCKER_RUN) $(DOCKER_IMAGE_NAME) bundle exec middleman build
