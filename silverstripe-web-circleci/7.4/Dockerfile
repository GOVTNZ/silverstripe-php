FROM brettt89/silverstripe-web:7.4-apache-buster
RUN apt-get update && apt-get install -y software-properties-common

RUN mkdir -p /usr/share/man/man1

# RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update && apt-get install -y \
    wget \
	mariadb-client \
    vim \
    openssh-server \
    xvfb \
    zip \
    unzip \
    git \
    libfontconfig \
    wkhtmltopdf

# Install java
# RUN apt-get update && apt-get install -y apt-utils

RUN apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main' && \
    apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Install composer
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# RUN apt-get install -y openjdk
# The repository 'http://ppa.launchpad.net/openjdk-r/ppa/ubuntu focal Release' does not have a Release file.
# RUN mkdir /usr/java && ln -s /usr/lib/jvm/java-7-openjdk-amd64 /usr/java/default

EXPOSE 8983
EXPOSE 80

CMD ["apache2-foreground"]
