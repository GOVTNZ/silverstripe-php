FROM brettt89/silverstripe-web:7.3-debian-stretch
RUN mkdir -p /usr/share/man/man1
RUN apt-get update && apt-get install -y \
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

EXPOSE 8983
EXPOSE 80

CMD ["apache2-foreground"]