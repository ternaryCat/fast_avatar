FROM ruby:3.1.2-slim

ENV LANG C.UTF-8

# build-essential libpq-dev - for pg
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev librsvg2-bin\
                       && rm -rf /var/lib/apt/lists/*\
                       && gem install bundler -v 2.1.4

WORKDIR /home/project

COPY docker/app/docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
