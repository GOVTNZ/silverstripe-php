#!/bin/bash
declare -a phpVersions=("7.3", "7.1")

for version in "${phpVersions[@]}"
do
    echo "### Building govtnz/silverstripe-web-circleci:${version} ###"
    docker build -t "govtnz/silverstripe-web-circleci:${version}" "${version}"
done

## Force 7.3/platform to be latest build
echo "### Building govtnz/silverstripe-web-circleci:latest"
docker build -t "govtnz/silverstripe-web-circleci:latest" "7.3"
