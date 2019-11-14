#!/bin/bash

#
# Handles building and publishing tags.
# Usage: `./build.sh silverstripe-web --publish`
#
PUBLISH=0
declare -a BUILD_FOLDERS

for arg in "$@"
do
    if [ "$arg" == "--publish" ] || [ "$arg" == "-p" ]
    then
        PUBLISH=1
	else
		# arg is a path
		if [ -d "$arg" ]; then
			BUILD_FOLDERS+="$arg"
		fi
    fi
done


if [ "$PUBLISH" = 1 ]; then
	echo "Building and publishing images: "
	for i in "${BUILD_FOLDERS[*]}"; do echo " $i"; done
else
	echo "Building images, not publishing. To publish use --publish: "
	for i in "${BUILD_FOLDERS[*]}"; do echo " $i"; done
fi

echo ""

for FOLDER in "${BUILD_FOLDERS[@]}"
do
	find "$FOLDER" -type d | while IFS= read -r d; do
		# convert /7.3 to :7.3
		NAME=${d//\//\:}
		IMAGE="govtnz/${NAME}"
		VERSION=""

		# if resources folder then skip
		if [[ $string == *":resources:"* ]]; then
  			continue
		fi

		# calculate version string
		IFS='/'
		read -ra ADDR <<< "$IMAGE"
		for i in "${ADDR[@]}"; do
			VERSION="$i"
		done
		IFS=' '

		if [ "$VERSION" == "" ]; then
			continue;
		fi

		if [ "$VERSION" == $FOLDER ]; then
			continue;
		fi

        echo "### Removing existing ${IMAGE} ###"
		docker image rm -f "${IMAGE}"

		echo "### Building ${IMAGE} ###"
    	docker build -t "${IMAGE}" "${d}"

		if [ "$PUBLISH" = 1 ]; then
			echo "### Publishing {$IMAGE}"
			docker push "${IMAGE}"
		fi
    done
done
