FROM debian:wheezy
MAINTAINER Adrian Ursu <ursu.c.adrian88@gmail.com>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 && \
    echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list && \
    apt-get update && \
    apt-get install -y adduser pwgen mongodb-org mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools && \
    echo 'mongodb-org hold' | dpkg --set-selections && \
    echo 'mongodb-org-server hold' | dpkg --set-selections && \
    echo 'mongodb-org-shell hold' | dpkg --set-selections && \
    echo 'mongodb-org-mongos hold' | dpkg --set-selections && \
    echo 'mongodb-org-tools hold' | dpkg --set-selections

VOLUME /data/db

ENV AUTH yes
ENV JOURNALING yes

ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh

EXPOSE 27017 28017

CMD ["/run.sh"]