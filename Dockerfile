FROM ubuntu:20.04
MAINTAINER Jung JinYoung <callsign.core@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --force-yes --no-install-recommends dpkg-dev nginx inotify-tools supervisor python-gevent \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ADD supervisord.conf /etc/supervisor/
ADD nginx.conf /etc/nginx/sites-enabled/default
ADD startup.sh /
ADD scan.py /

ENV DISTS buster
ENV ARCHS amd64,armhf
EXPOSE 80
VOLUME /data
ENTRYPOINT ["/startup.sh"]
