FROM ubuntu:14.04
MAINTAINER Tony Lechner <tony.lechner@gmail.com>

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update &&\
    apt-get install -y easy-rsa &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./docker-entrypoint.sh /

VOLUME /pki

ENTRYPOINT ["/docker-entrypoint.sh"]
