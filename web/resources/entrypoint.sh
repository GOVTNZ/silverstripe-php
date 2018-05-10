#!/bin/bash

HOST_UID=$(stat -c %u /var/www/html)
HOST_GID=$(stat -c %g /var/www/html)

echo "INFO: Starting web-container..."

groupadd container
useradd -d /home/container -m -s /bin/bash -g container container

groupadd host_group --gid $HOST_GID
useradd host_user --gid $HOST_GID --uid $HOST_UID

exec gosu $HOST_UID:$HOST_GID /fork.sh