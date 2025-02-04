# Tells the image to use
FROM alpine:3.20.5

# Author credits, replaces MAINTAINER (deprecated)
LABEL maintainer="mbernard@student.42lyon.fr"

# Installations + erases useless files to make the image smaller
RUN apk update --no-interactive && apk upgrade --no-interactive && apk add --no-interactive \
    mariadb \
    iputils-ping \
    && rm -rf /var/cache/apk/*

# PHP configuration 
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

ARG MARIADB_SCRIPT=/usr/local/bin/mariadb_init.sh

# Wordpress configuration 
COPY ./tools/mariadb_init.sh ${MARIADB_SCRIPT}
RUN chmod +x ${MARIADB_SCRIPT}

ENTRYPOINT [${MARIADB_SCRIPT}]
