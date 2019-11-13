FROM brettt89/silverstripe-web:7.1-platform
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    chromedriver \
    libfontconfig1 \
    libxrender1 \
    locales \
    mysql-client \
    ruby ruby-dev \
    ssmtp \
    unzip \
    wget \
    zip \
    apt-transport-https \
    lsb-release \
    ; apt-get purge -y --auto-remove \
    ; rm -rf /var/lib/apt/lists/*

#
# Symlink Chrome Driver in
#
RUN ln -s /usr/lib/chromium/chromedriver /usr/bin/;

#
# Install GOSU, see https://github.com/tianon/gosu for more details
#
ENV GOSU_VERSION 1.10
RUN set -ex; \
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	chmod +xs /usr/local/bin/gosu; \
	gosu nobody true


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
RUN set -ex; \
    wget -O /tmp/wkhtmltopdf.tar.gz "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz"

RUN cd /tmp; \
    tar -xf /tmp/wkhtmltopdf.tar.gz; \
    mv /tmp/wkhtmltox /opt; \
    ls -l /opt/wkhtmltox/bin; \
    ln -s /opt/wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf; \
    chmod 555 /usr/local/bin/wkhtmltopdf; \
    /usr/local/bin/wkhtmltopdf -h


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
# Install composer, sake and supply a default _ss_environment file
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
