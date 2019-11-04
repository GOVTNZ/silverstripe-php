#!/bin/bash

docker image rm govtnz/silverstripe-web-circleci-php7.3:latest
docker build -t govtnz/silverstripe-web-circleci-php7.3:latest .
