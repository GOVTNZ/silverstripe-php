#!/bin/bash
set -e

HOST_UID=$(id -u)
HOST_GID=$(id -g)
export COMPOSER_HOME=/cache/.composer

echo "INFO: Forked web-container... ($HOST_UID:$HOST_GID)"

#
# Create composer cache directory in cache volume
#
echo COMPOSER_HOME has been set to: ${COMPOSER_HOME}
if [ ! -d "$COMPOSER_HOME" ]; then
  echo "INFO: created composer cache directory"
  mkdir $COMPOSER_HOME
  chmod 777 $COMPOSER_HOME
fi


#
# Run composer install if the framework directory is missing
#
#if [ ! -d "framework" ]; then
#  echo "INFO: Missing framework directory, running composer install..."
#  composer install
#fi


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
#if [ -d "framework" ]; then
#  echo "INFO: Generating database - this can take a while..."
#  sake dev/build
#  echo "INFO: Done"
#fi


#
# Configure and reindex SOLR
#
#if [ ! -d "/index/data" ]; then
#  echo "WARNING: Not configuring SOLR because of missing '/index' volume"
#else
#  echo "INFO: Configuring SOLR and reindexing..."
#  sake dev/tasks/Solr_Configure
#  sake dev/tasks/Solr_Reindex
#  echo "INFO: Done"
#fi


#
# Start apache
#
echo "INFO: Starting apache..."
exec gosu 0:0 /usr/local/bin/apache2-foreground
