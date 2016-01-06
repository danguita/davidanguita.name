FROM ruby:2.3.0
MAINTAINER David Anguita <david@davidanguita.name>

RUN apt-get update
RUN apt-get -y -q install nodejs

ADD Gemfile Gemfile.lock /app/
WORKDIR /app
RUN bundle install

CMD ["bundle", "exec", "middleman", "server"]
