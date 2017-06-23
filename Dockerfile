FROM ubuntu:14.04
MAINTAINER Tony Lechner <tony.lechner@gmail.com>

RUN apt-get update &&\
    apt-get install -y easy-rsa &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./docker-entrypoint.sh /

VOLUME /pki

ENTRYPOINT ["/docker-entrypoint.sh"]
