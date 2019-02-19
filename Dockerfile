FROM ubuntu:16.04
LABEL maintainer="Tony Lechner <tony@tony-lechner.com>"

RUN apt-get update &&\
    apt-get install -y easy-rsa &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
