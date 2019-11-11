FROM brettt89/silverstripe-web:7.3-debian
RUN apt-get update && apt-get install -y  software-properties-common
# RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update && apt-get install -y \
    wget \
	mariadb-client \
    vim \
    openssh-server \
    xvfb \
    libfontconfig \
    wkhtmltopdf
# RUN apt-get install -y openjdk
# The repository 'http://ppa.launchpad.net/openjdk-r/ppa/ubuntu focal Release' does not have a Release file.
# RUN mkdir /usr/java && ln -s /usr/lib/jvm/java-7-openjdk-amd64 /usr/java/default

EXPOSE 8983
EXPOSE 80

CMD ["apache2-foreground"]
