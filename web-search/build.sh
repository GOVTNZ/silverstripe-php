#!/bin/bash
docker image rm govtnz/silverstripe-web-search:1.0
docker build -t govtnz/silverstripe-web-search:1.0 .
