FROM brettt89/silverstripe-web
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    wget \
    mariadb-client \
    software-properties-common

RUN apt-get install -y default-jre

EXPOSE 80
EXPOSE 8983

CMD ["apache2-foreground"]
