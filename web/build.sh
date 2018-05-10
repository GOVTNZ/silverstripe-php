#!/bin/bash

docker image rm govtnz/silverstripe-php:5.6
docker build -t govtnz/silverstripe-php:5.6 .
