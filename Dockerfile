FROM brettt89/silverstripe-web
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    build-essential \
    ca-certificates \
    git \
    lsb-release \
    mysql-client \
    openssh-server \
    ruby ruby-dev \
    unzip \
    vim \
    wget \
    zip \
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
	chmod +x /usr/local/bin/gosu; \
	gosu nobody true


#
# Install node, npm, webpack
#
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh; \
    bash nodesource_setup.sh; \
    apt-get install nodejs; \
    npm install -g webpack; \
    npm install -g webpack-cli


#
# Install compass
#
RUN gem install sass -v 3.4.25; \
    gem install compass



#
# Install composer, sake and supply a default _ss_environment file
#
COPY resources/install-composer.sh /tmp/
COPY resources/sake /usr/local/bin/
COPY resources/_ss_environment.php /var/www/

RUN chmod 755 /usr/local/bin/sake && \
    chmod 755 /tmp/install-composer.sh && \
    /tmp/install-composer.sh
