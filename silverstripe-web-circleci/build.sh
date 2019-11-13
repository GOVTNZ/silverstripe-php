#!/bin/bash
declare -a phpVersions=("7.3", "7.1")
PUBLISH=0

for arg in "$@"
do
    if [ "$arg" == "--publish" ] || [ "$arg" == "-p" ]
    then
        PUBLISH=1
    fi
done

if [ "$PUBLISH" = 1 ]; then
	echo "Building and publishing images silverstripe-web-circleci"
else
	echo "Building images silverstripe-web-circleci"
	echo " to publish, use (--publish)"
fi

for version in "${phpVersions[@]}"
do
    echo "### Building govtnz/silverstripe-web-circleci:${version} ###"
    docker build -t "govtnz/silverstripe-web-circleci:${version}" "${version}"

	if [ "$PUBLISH" = 1 ]; then
		echo "### Building govtnz/silverstripe-web-circleci:${version} ###"
		docker push "govtnz/silverstripe-web-circleci:${version}"
	fi
done

## Force 7.3/platform to be latest build
echo "### Building govtnz/silverstripe-web-circleci:latest"
docker build -t "govtnz/silverstripe-web-circleci:latest" "7.3"
