#!/bin/bash

HOST_UID=$(stat -c %u /var/www/html)
HOST_GID=$(stat -c %g /var/www/html)
export COMPOSER_HOME=/cache/.composer

exec gosu $HOST_UID:$HOST_GID /bin/bash