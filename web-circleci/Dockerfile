FROM brettt89/silverstripe-web:7.1-platform
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    wget \
    mysql-client \
    vim \
    git \
    openjdk-7-jdk \
    openssh-server

RUN mkdir /usr/java && ln -s /usr/lib/jvm/java-7-openjdk-amd64 /usr/java/default

EXPOSE 8983
EXPOSE 80

CMD ["apache2-foreground"]