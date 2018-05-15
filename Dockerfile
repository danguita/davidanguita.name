FROM ruby:2.4.3-alpine3.7

LABEL maintainer="David Anguita <david@davidanguita.name>"
LABEL version="2.1"

RUN apk add --update --no-cache \
  build-base \
  tzdata \
  nodejs

WORKDIR /app

ADD Gemfile Gemfile.lock ./
RUN bundle install

CMD ["bundle", "exec", "middleman", "server"]
