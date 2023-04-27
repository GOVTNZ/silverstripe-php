FROM brettt89/silverstripe-web:8.1-apache

RUN apt-get update && apt-get upgrade -y && apt-get install -y software-properties-common

# add repo for pulling in legacy openjdk-8-jdk (Temurin) from Adoptium which is required for Solr
# See https://adoptium.net/installation/linux/#_deb_installation_on_debian_or_ubuntu
RUN apt install -y wget apt-transport-https
RUN mkdir -p /etc/apt/keyrings
RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
RUN echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
RUN apt update && apt install -y \
	mariadb-client \
    vim \
    openssh-server \
    xvfb \
    zip \
    unzip \
    git \
    libfontconfig \
    wkhtmltopdf \
    temurin-8-jdk \
    ant

# Install composer
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 8983
EXPOSE 80

CMD ["apache2-foreground"]
