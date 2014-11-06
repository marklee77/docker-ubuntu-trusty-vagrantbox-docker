FROM marklee77/ubuntu-trusty-vagrantbox:latest
MAINTAINER Mark Stillwell <mark@stillwell.me>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install apt-transport-https software-properties-common && \
    apt-key adv --recv-key --keyserver hkp://keyserver.ubuntu.com:80 \
        36A1D7869245C8950F966E92D8576A8BA88D21E9 && \
    apt-add-repository 'deb https://get.docker.io/ubuntu docker main' && \
    apt-get update && \
    apt-get -y install lxc-docker && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN curl -s https://bootstrap.pypa.io/get-pip.py | python -
RUN pip install docker-py

RUN mkdir -p /etc/my_init.d && \
    echo '#!/bin/sh\nservice docker start\n' > /etc/my_init.d/10-docker && \
    chmod 0755 /etc/my_init.d/10-docker

RUN usermod -aG docker vagrant

VOLUME /var/lib/docker
