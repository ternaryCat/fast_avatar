#!/bin/bash
set -e

bundle install
bundle exec rake db:migrate

exec "$@"
