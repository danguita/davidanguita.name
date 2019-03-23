FROM ruby:2.4.3-alpine3.7

LABEL maintainer="David Anguita <david@davidanguita.name>"
LABEL app="davidanguita_name" version="2.1.1"

WORKDIR /app

RUN apk add --update --no-cache \
      tzdata \
      nodejs

ADD Gemfile Gemfile.lock ./

RUN set -ex \
      && apk add --update --no-cache --virtual .build-deps build-base \
      && bundle install -j 4 \
      && apk del .build-deps

CMD ["bundle", "exec", "middleman", "server"]
