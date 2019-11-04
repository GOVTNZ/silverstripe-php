FROM brettt89/silverstripe-web:7.3-debian-stretch
RUN mkdir -p /usr/share/man/man1
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils
RUN apt-get upgrade -y && apt-get install -y \
    wget \
    mysql-client \
    vim \
    git \
    openjdk-8-jdk \
    openssh-server \
    xvfb \
    libfontconfig \
    wkhtmltopdf
RUN mkdir /usr/java && ln -s /usr/lib/jvm/java-8-openjdk-amd64 /usr/java/default
RUN pecl install xdebug \
    && echo "zend_extension=\"$(php-config --extension-dir)/xdebug.so\"" > $PHP_INI_DIR/conf.d/xdebug.ini
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 8983
EXPOSE 80

CMD ["apache2-foreground"]