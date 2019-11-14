FROM brettt89/silverstripe-web:7.3-debian
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    libfontconfig1 \
    libxrender1 \
    locales \
    mariadb-client \
    ruby ruby-dev \
    unzip \
    wget \
    zip \
    apt-transport-https \
    lsb-release \
    ; apt-get purge -y --auto-remove \
    ; rm -rf /var/lib/apt/lists/*

#
# Install node, npm
#
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh; \
    bash nodesource_setup.sh; \
    apt-get install nodejs; \
    chmod 777 /usr/lib/node_modules/; \
    chmod 777 /usr/bin

#
# Install WKHTMLTOPDF (https://wkhtmltopdf.org/)
#
RUN apt-get install -y wkhtmltopdf

#
# Temporarily enable jpeg and freetype in this docker file until PR23 is released
# see: https://github.com/brettt89/silverstripe-web/pull/23
#
RUN docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    --with-png-dir=/usr/include/ && docker-php-ext-install gd


#
# Add SSMTP configuration and PHP Mail configuration
#
COPY resources/conf/ssmtp.conf /etc/ssmtp/ssmtp.conf
COPY resources/conf/mail.ini /usr/local/etc/php/conf.d/mail.ini
COPY resources/conf/xdebug-profile.ini /usr/local/etc/php/conf.d/xdebug-profile.ini

#
# Supply a default .env file
#
COPY resources/scripts/sake.sh /usr/local/bin/sake
COPY resources/conf/.env /var/www/

#
# Add scripts and configuration
#
COPY resources/scripts/entrypoint.sh /
COPY resources/scripts/fork.sh /
COPY resources/scripts/shell.sh /usr/bin/shell
COPY resources/scripts/runas.sh /usr/bin/runas
COPY resources/scripts/behat.sh /usr/bin/behat
COPY resources/conf/000-default.conf /etc/apache2/sites-available
COPY resources/setup/* /var/www/setup/

#
# Modify permissions
#
RUN chmod 755 /usr/bin/behat; \
    chmod 755 /usr/local/bin/sake; \
    chmod 755 /entrypoint.sh; \
    chmod 755 /fork.sh; \
    chmod 755 /usr/bin/shell; \
    chmod 755 /usr/bin/runas

#
# Entry point
#
CMD ["/entrypoint.sh"]
