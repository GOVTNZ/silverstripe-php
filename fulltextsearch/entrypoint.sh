#!/bin/bash
set -e

if [ ! -d "/index" ]; then
  echo ERROR: directory \'/index\' doesn\'t exist. Perhaps you forgot to mount a volume?
  exit 255
fi

if [ -d "/index/data" ]; then
  echo INFO: directory \'/index/data\' already exists. Removing existing data.
  rm -rf /index/data
fi

if [ ! -d "/index/data" ]; then
  echo INFO: created \'/index/data\'
  mkdir /index/data
  chmod 777 /index/data
fi

cd /solr/server
exec java -jar start.jar
