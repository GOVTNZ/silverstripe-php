FROM brettt89/silverstripe-web:7.1-platform
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    wget \
    mysql-client \
    vim \
    git \
    openssh-server

EXPOSE 80

CMD ["apache2-foreground"]