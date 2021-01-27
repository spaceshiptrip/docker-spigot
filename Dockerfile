FROM ubuntu:16.04

MAINTAINER spaceshiptrip <4379326+spaceshiptrip@users.noreply.github.com>

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
    apt-get install -y screen && \

    # install java
    apt-get install -y openjdk-8-jdk && \
	apt-get install -y ant && \

    # Make special user for minecraft to run in
    /usr/sbin/useradd -s /bin/bash -d /minecraft -m minecraft && \

    # remove apt cache from image
    apt-get clean all && \


    # clean up
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer;


# Grab the latest BuildTools and build spigot
RUN cd /usr/games/spigot
RUN java -Xmx1024M -jar BuildTools.jar --rev latest


# expose minecraft port
EXPOSE 25565


