#!/bin/bash
set -e

HOST_UID=$(id -u)
HOST_GID=$(id -g)
export COMPOSER_HOME=/home/container/.composer

echo "INFO: Forked web-container... ($HOST_UID:$HOST_GID)"

if [ ! -f "composer.json" ]; then
  echo "ERROR: The working directory doesn't look like a valid Silverstripe project. Perhaps you forgot to mount it?"
  exit 255
fi


#
# Run composer install if the framework directory is missing
#
if [ ! -d "framework" ]; then
  echo "INFO: Missing framework directory, running composer install..."
  composer install
fi


#
# Fetch dependencies if lockfile out of date
#
#if [ -f "composer.json" ] && [ -f "composer.lock" ]; then
#  set +e
#  pwd
#  cat composer.lock | grep '"content-hash":'
#  cat composer.lock | grep '"content-hash":' | cut -d'"' -f4
#  md5sum composer.json | cut -d ' ' -f1
#  COMPOSER_IN_SYNC=$(expr "`cat composer.lock | grep '"content-hash":' | cut -d'"' -f4`" = "`md5sum composer.json | cut -d ' ' -f1`")
#  set -e
#  if [ "$COMPOSER_IN_SYNC" -eq "0" ]; then
#    echo "INFO: composer.lock is out of sync, updating (this might take a while)..."
#    composer update
#  fi
#fi


#
# Build database
#
if [ -d "framework" ]; then
  echo "INFO: Generating database..."
  sake dev/build
  echo "INFO: Done"
fi


#
# Configure and reindex SOLR
#
if [ ! -d "/index/data" ]; then
  echo "INFO: Not configuring SOLR (missing '/index' volume)"
fi

if [ -d "/index/data" ]; then
  echo "INFO: Configuring SOLR and reindexing..."
  sake dev/tasks/Solr_Configure
  sake dev/tasks/Solr_Reindex
  echo "INFO: Done"
fi

echo "INFO: Starting apache..."

#
# Start apache
#
exec gosu 0:0 /usr/local/bin/apache2-foreground
