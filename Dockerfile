FROM phusion/baseimage:latest
MAINTAINER Mark Stillwell <mark@stillwell.me>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install \
        curl \
        git \
        python-httplib2 \
        python-jinja2 \
        python-keyczar \
        python-paramiko \
        python-pkg-resources \
        python-setuptools \
        python-yaml && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN curl -s https://bootstrap.pypa.io/get-pip.py | python -
RUN pip install ansible

RUN mkdir -p /etc/ansible && \
    echo '[local]\nlocalhost ansible_connection=local\n' > /etc/ansible/hosts
