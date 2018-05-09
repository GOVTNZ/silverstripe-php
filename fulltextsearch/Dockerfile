FROM openjdk:6

RUN git clone https://github.com/silverstripe-archive/silverstripe-fulltextsearch-localsolr.git solr

COPY entrypoint.sh /
EXPOSE 8983

RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

