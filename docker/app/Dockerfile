FROM ruby:3.0.2-slim

ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y librsvg2-bin\
                       && rm -rf /var/lib/apt/lists/*\
                       && gem install bundler -v 2.1.4

WORKDIR /home/project

COPY docker/app/docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
