#!/bin/bash

HOST_UID=$(stat -c %u /var/www/html)
HOST_GID=$(stat -c %g /var/www/html)

exec gosu $HOST_UID:$HOST_GID php vendor/bin/behat $@