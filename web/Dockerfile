FROM brettt89/silverstripe-web
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
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
# Install sass and compass
#
RUN gem install sass -v 3.4.25; \
    gem install compass


#
# Set the default locale (needed for compass)
#
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && \
    locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8


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
COPY resources/ssmtp.conf /etc/ssmtp/ssmtp.conf
COPY resources/mail.ini /usr/local/etc/php/conf.d/mail.ini


#
# Install composer, sake and supply a default _ss_environment file
#
COPY resources/sake /usr/local/bin/
COPY resources/_ss_environment.php /var/www/
RUN chmod 755 /usr/local/bin/sake


#
# Add scripts
#
COPY resources/entrypoint.sh /
RUN chmod 755 /entrypoint.sh

COPY resources/fork.sh /
RUN chmod 755 /fork.sh

COPY resources/shell.sh /usr/bin/shell
RUN chmod 755 /usr/bin/shell

COPY resources/runas.sh /usr/bin/runas
RUN chmod 755 /usr/bin/runas

COPY resources/behat.sh /usr/bin/behat
RUN chmod 755 /usr/bin/behat

COPY resources/000-default.conf /etc/apache2/sites-available
COPY resources/setup/* /var/www/setup/

CMD ["/entrypoint.sh"]