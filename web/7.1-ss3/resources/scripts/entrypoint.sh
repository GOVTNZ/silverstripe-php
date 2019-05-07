#!/bin/bash

HOST_UID=$(stat -c %u /var/www/html)
HOST_GID=$(stat -c %g /var/www/html)
export COMPOSER_HOME=/cache/.composer

echo "INFO: Starting web-container..."

groupadd container
useradd -d /home/container -m -s /bin/bash -g container container

groupadd host_group --gid $HOST_GID
useradd host_user --gid $HOST_GID --uid $HOST_UID

#
# Test for valid Silverstripe project
#
if [ ! -f "composer.json" ]; then
  echo "FATAL: The working directory doesn't look like a valid Silverstripe project. Perhaps you forgot to mount it?"
  exit 255
fi


#
# Make sure that /cache is mounted
#
if [ ! -d "/cache" ]; then
  echo "WARNING: /cache volume NOT mounted, creating directories but disabled caching"
  mkdir /cache
fi


#
# Change permissions on assets folder
#
mkdir /var/www/html/assets
chown -R www-data:www-data /var/www/html/assets


#
# Change permissions on .profile folder
#
mkdir /var/www/html/.profile
chown -R www-data:www-data /var/www/html/.profile


#
# Create needs-setup file to trigger the setup-page
#
touch /var/www/html/assets/.needs-setup
chown www-data:www-data /var/www/html/assets/.needs-setup


#
# Change permissions on /cache
#
chmod 777 /cache


#
# Add symbolic link to wkhtml2pdf
#
ln -s /usr/local/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf_12


exec gosu $HOST_UID:$HOST_GID /fork.sh