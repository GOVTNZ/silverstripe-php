FROM openjdk:6

RUN git clone https://github.com/silverstripe-archive/silverstripe-fulltextsearch-localsolr.git solr

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

EXPOSE 8983
ENTRYPOINT ["/entrypoint.sh"]

