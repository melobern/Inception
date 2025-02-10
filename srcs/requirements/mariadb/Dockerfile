FROM alpine:3.20.5

LABEL maintainer="mbernard@student.42lyon.fr"

RUN apk update --no-interactive && apk upgrade --no-interactive && apk add --no-cache --no-interactive \
    mariadb \
    mariadb-client \
    mysql \
    iputils-ping \
    && rm -rf /var/cache/apk/*

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./tools/mariadb_init.sh /usr/local/bin/mariadb_init.sh

RUN mkdir -p /run/mysqld /var/log/mysql /var/lib/mysql
RUN touch /var/log/mysql/error.log /var/log/mysql/query.log /var/log/mysql/slow_query.log
RUN chown -R mysql /var/lib/mysql /var/log/mysql /run/mysqld /etc/my.cnf.d/

EXPOSE 3306

RUN chmod +x /usr/local/bin/mariadb_init.sh

ENTRYPOINT ["/usr/local/bin/mariadb_init.sh"]

