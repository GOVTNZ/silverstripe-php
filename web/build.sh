#!/bin/bash
declare -a phpVersions=("7.3", "7.1" "5.6" "7.1-ss3")

for version in "${phpVersions[@]}"
do
    echo "### Building govtnz/silverstripe-web-container:${version} ###"
    docker build -t "govtnz/silverstripe-web-container:${version}" "${version}"
done

## Force 7.3/platform to be latest build
echo "### Building govtnz/silverstripe-web-container:latest"
docker build -t "govtnz/silverstripe-web-container:latest" "7.3"
