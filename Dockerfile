FROM ubuntu:14.04
MAINTAINER Tony Lechner

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update &&\
    apt-get install -y easy-rsa &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /pki

ADD ./scripts /scripts
ADD ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ['easy-rsa']
