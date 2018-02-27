FROM brettt89/silverstripe-web
RUN apt-get update && apt-get install -y zip unzip wget vim mysql-client git openssh-server

COPY resources/install-composer.sh /tmp/
COPY resources/sake /usr/local/bin/
COPY resources/_ss_environment.php /var/www/

RUN chmod 700 /usr/local/bin/sake && chmod 700 /tmp/install-composer.sh && /tmp/install-composer.sh
