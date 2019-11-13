#!/bin/bash
declare -a phpVersions=("7.3", "7.1" "5.6" "7.1-ss3")
PUBLISH=0

for arg in "$@"
do
    if [ "$arg" == "--publish" ] || [ "$arg" == "-p" ]
    then
        PUBLISH=1
    fi
done

if [ "$PUBLISH" = 1 ]; then
	echo "Building and publishing images silverstripe-web-container"
fi

for version in "${phpVersions[@]}"
do
    echo "### Building govtnz/silverstripe-web-container:${version} ###"
    docker build -t "govtnz/silverstripe-web-container:${version}" "${version}"

	if [ "$PUBLISH" = 1 ]; then
		echo "### Building govtnz/silverstripe-web-container:${version} ###"
		docker push "govtnz/silverstripe-web-container:${version}"
	fi
done

## Force 7.3/platform to be latest build
echo "### Building govtnz/silverstripe-web-container:latest"
docker build -t "govtnz/silverstripe-web-container:latest" "7.3"
