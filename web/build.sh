#!/bin/bash

docker image rm govtnz/silverstripe-php:1.0
docker build -t govtnz/silverstripe-php:1.0 .
