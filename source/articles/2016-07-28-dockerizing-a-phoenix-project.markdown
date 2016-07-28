---
title: Dockerizing a Phoenix project
tagline:
date: 2016-07-28 15:40 CEST
comments: true
tags: Phoenix, Elixir, Docker
description:
---

I personally love to keep all my projects isolated in one way or another.
In some cases –the most complex ones– I need to provision Virtual
Machines by using tools like [Vagrant](https://www.vagrantup.com/) and
[Ansible](https://www.ansible.com/), but in most of them I can
just define a bunch of Docker containers within the project's context,
which is my preferred approach so far for ease and portability.

I wanted to share my experiencie preparing a Docker environment
to develop a sample project using the [Elixir language](http://elixir-lang.org/)
and the [Phoenix framework](http://www.phoenixframework.org/).

Let's dive in:

## The application image

In Phoenix projects we have some dependencies related to the Elixir language
and the platform that it leverages from: [Erlang VM](https://www.erlang.org/).
To easily match those requirements, there's an [official Elixir repo](https://hub.docker.com/_/elixir/)
of Docker images, so let's take advantage of that.

Here's the `Dockerfile` to build the main image. It is the only one in
this sample application since it provides all dependencies to run any
other Phoenix application instances, and we're just gonna use it in both
development and test environments:

```shell
# ./Dockerfile

# Starting from the official Elixir 1.3.2 image:
# https://hub.docker.com/_/elixir/
FROM elixir:1.3.2
MAINTAINER David Anguita <david@davidanguita.name>

ENV DEBIAN_FRONTEND=noninteractive

# Install hex
RUN mix local.hex --force

# Install rebar
RUN mix local.rebar --force

# Install the Phoenix framework itself
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# Install NodeJS 6.x and the NPM
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y -q nodejs

# Set /app as workdir
WORKDIR /app
```

## The containers

We'll use [Docker Compose](https://docs.docker.com/compose/) to build
and run containers. This sample application will use
[PostgreSQL](https://www.postgresql.org/) 9.5 as database, and let's
say there aren't extra dependencies in the test environment, to keep
things simple:

```shell
# ./docker-compose.yml

web:
  build: .
  dockerfile: Dockerfile # That's our Dockerfile path
  env_file: .env # Set environment variables from an `.env` file, if needed
  command: mix phoenix.server # Start the server if no other command is specified
  environment:
    - MIX_ENV=dev # That's the environment mode, you know
    - PORT=4000
    - PG_HOST=postgres
    - PG_USERNAME=postgres
  volumes:
    - .:/app # Here we're mounting our project's root directory inside the container
  ports:
    - "4000:4000"
  links:
    - postgres

test:
  image: phoenixbootstrap_web # We're just using the already built `web` image here
  env_file: .env
  command: mix test # Run the entire test suite if no other command is specified
  environment:
    - MIX_ENV=test # That's key
    - PORT=4001
    - PG_HOST=postgres
    - PG_USERNAME=postgres
  volumes_from:
    - web
  links:
    - postgres

postgres:
  image: postgres:9.5 # https://hub.docker.com/_/postgres/
  ports:
    - "5432"
```

## Configuring the repo

Before starting the containers, let's configure our Ecto adapter to
match the environment settings:

```elixir
# ./config/dev.exs

config :app, App.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("PG_USERNAME"),
  password: System.get_env("PG_PASSWORD"),
  hostname: System.get_env("PG_HOST"),
  database: "app_dev",
  pool_size: 10
```

```elixir
# ./config/test.exs

config :app, App.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("PG_USERNAME"),
  password: System.get_env("PG_PASSWORD"),
  hostname: System.get_env("PG_HOST"),
  database: "app_test",
  pool: Ecto.Adapters.SQL.Sandbox
```

## Running the environment

We should be now ready to go on our Dockerized Phoenix application.
Here's a generic check-list to get everything up and running:

### Development environment

```shell
# Build the Docker image and start the `web` container, daemonized
$ docker-compose up -d web
```

```shell
# Install application's dependencies and compile them all
$ docker-compose run web mix do deps.get, compile
```

```shell
# Create database and run migrations
$ docker-compose run web mix ecto.create && mix ecto.migrate
```

```shell
# Install (mostly) JS dependencies through `npm`
$ docker-compose run web npm config set strict-ssl false && npm install
```

```shell
# Execute the seeding script, if needed
$ docker-compose run web mix run priv/repo/seeds.exs
```

```shell
# Restart the `web` container to ensure everything's up
$ docker-compose restart web
```

Your application should just be reachable at
`http://<your_docker_host>:4000/` 🎉

[![Welcome to Phoenix](2016-07-28-dockerizing-a-phoenix-project/welcome-to-phoenix.jpg)](2016-07-28-dockerizing-a-phoenix-project/welcome-to-phoenix.jpg)

### Test environment

To deal with the test environment, for which we already have a proper
container:

```shell
# Execute all tests (It's a `$ mix test` actually)
$ docker-compose run test
```

```shell
# Execute tests for specific files
$ docker-compose run test mix test test/models/user_test.exs
```

***

So, I'd say that's a good starting point for covering any other
environment needs. Thanks for reading, and please share your thoughts in
the comments!

