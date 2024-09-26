FROM brettt89/silverstripe-web:8.3-apache

RUN apt-get update && apt-get upgrade -y && apt-get install -y software-properties-common

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
    ant

# Install composer
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 8983
EXPOSE 80

CMD ["apache2-foreground"]
