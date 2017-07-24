#!/bin/bash

bundle exec rails db:migrate db:seed
bundle exec puma -w 5
