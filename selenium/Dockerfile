FROM ubuntu:17.10

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    default-jre \
    dirmngr \
    openssl \
    unzip \
    wget \
    # chrome dependencies
    fonts-liberation \
    libappindicator1 \
    libgtk-3-0 \
    libxss1 \
    lsb-release \
    xdg-utils \
    ; apt-get purge -y --auto-remove \
    ; rm -rf /var/lib/apt/lists/*


#
# Install GOSU, see https://github.com/tianon/gosu for more details
#
ENV GOSU_VERSION 1.10
RUN set -ex; \
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget --no-check-certificate -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget --no-check-certificate -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	chmod +x /usr/local/bin/gosu; \
	gosu nobody true


#
# Install selenium-server-standalone, see https://github.com/sveneisenschmidt/selenium-server-standalone
#

RUN wget --no-check-certificate -O /selenium.tar.gz https://github.com/sveneisenschmidt/selenium-server-standalone/archive/3.11.0.tar.gz && \
    tar -xf /selenium.tar.gz && \
    mv /selenium-server-standalone-3.11.0 /selenium-server-standalone && \
    rm /selenium.tar.gz

#
# Install chromedriver, see https://sites.google.com/a/chromium.org/chromedriver/downloads
#

RUN wget --no-check-certificate -O /chromedriver.zip https://chromedriver.storage.googleapis.com/2.37/chromedriver_linux64.zip && \
    unzip /chromedriver.zip && \
    rm /chromedriver.zip

#
# Install Chrome, see https://discuss.circleci.com/t/installing-chrome-inside-of-your-docker-container/9067
#
RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update && \
  apt-get install -y google-chrome-stable dbus-x11 packagekit-gtk3-module libcanberra-gtk-module && \
  rm -rf /var/lib/apt/lists/*

COPY resources/entrypoint.sh /
EXPOSE 4444

RUN chmod 755 /entrypoint.sh

#ENTRYPOINT ["/entrypoint.sh"]