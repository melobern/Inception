# Tells the image to use
FROM alpine:3.20.5

# Author credits, replaces MAINTAINER (deprecated)
LABEL maintainer="mbernard@student.42lyon.fr"

# Installations + erases useless files to make the image smaller
RUN apk update --no-interactive && apk upgrade --no-interactive && apk add --no-interactive \
    mariadb-client \
    php7.4 \
    php-fpm \
    php-mysql \
    wget \
    && apk autoremove && rm -rf /var/lib/apt/lists/*

EXPOSE 9000

# PHP configuration 
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

ARG WP_SCRIPT=/usr/local/bin/wp_init.sh

# Wordpress configuration 
COPY ./tools/wp_init.sh ${WP_SCRIPT}
RUN chmod +x ${WP_SCRIPT}

ENTRYPOINT [${WP_SCRIPT}]
