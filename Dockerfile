FROM ubuntu:16.04
#FROM openjdk:8-jre-alpine3.9
#FROM nimmis/java:openjdk-8-jdk

MAINTAINER nimmis <kjell.havneskold@gmail.com>

# SPIGOT_HOME         default directory for SPIGOT-server
# SPIGOT_VER          default minecraft version to compile
# SPIGOT_AUTORESTART  set to yes to restart if minecraft stop command is executed
ENV SPIGOT_HOME=/minecraft \
    SPIGOT_VER=latest \
    SPIGOT_AUTORESTART=yes

# add extra files needed
COPY rootfs /

RUN mkdir -p /etc/BUILDS

RUN apt-get update && \

    # upgrade OS
    apt-get -y dist-upgrade && \

    # get apt-utils
    apt-get install -y apt-utils && \

    # Make info file about this build
    printf "Build of nimmis/spigot:latest, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` > /etc/BUILDS/spigot && \

    # install application
    apt-get install -y wget git && \

    # install screen
    apt-get intall -y screen && \

    # Make special user for minecraft to run in
    /usr/sbin/useradd -s /bin/bash -d /minecraft -m minecraft && \

    # remove apt cache from image
    apt-get clean all


# expose minecraft port
EXPOSE 25565


