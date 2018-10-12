#!/bin/bash

docker image rm govtnz/silverstripe-web-circleci:latest
docker build -t govtnz/silverstripe-web-circleci:latest .
