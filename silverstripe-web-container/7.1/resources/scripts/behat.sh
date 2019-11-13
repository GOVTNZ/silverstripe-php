#!/bin/bash

HOST_UID=$(stat -c %u /var/www/html)
HOST_GID=$(stat -c %g /var/www/html)
export COMPOSER_HOME=/cache/.composer

cd /var/www/html

if [ -f "assets/.needs-setup" ]; then
  rm assets/.needs-setup
fi

if [ -f "behat-docker.yml" ]; then
  exec gosu $HOST_UID:$HOST_GID php vendor/bin/behat -c behat-docker.yml $@
else
  exec gosu $HOST_UID:$HOST_GID php vendor/bin/behat $@
fi

