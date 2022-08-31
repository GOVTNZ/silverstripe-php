FROM brettt89/silverstripe-web:8.1-apache

RUN apt-get update && apt-get upgrade -y && apt-get install -y software-properties-common

# add repo for pulling in legacy openjdk-8-jdk for solr
RUN apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main'
RUN apt-get update && apt-get install -y wget \
	mariadb-client \
    vim \
    openssh-server \
    xvfb \
    zip \
    unzip \
    git \
    libfontconfig \
    wkhtmltopdf \
    openjdk-8-jdk \
    ant

# Install composer
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 8983
EXPOSE 80

CMD ["apache2-foreground"]
