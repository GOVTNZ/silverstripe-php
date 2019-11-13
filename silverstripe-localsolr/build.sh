#!/bin/bash

docker image rm govtnz/silverstripe-localsolr:1.0
docker build -t govtnz/silverstripe-localsolr:1.0 .
