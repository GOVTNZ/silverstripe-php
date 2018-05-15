#!/bin/bash

docker image rm govtnz/silverstripe-web-container:1.0
docker build -t govtnz/silverstripe-web-container:1.0 .
