FROM alpine:3.20.5

LABEL maintainer="mbernard@student.42lyon.fr"

RUN apk update --no-interactive && apk upgrade --no-interactive && apk add --no-cache --no-interactive \
    mariadb-client \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-mysqlnd \
    php83-phar \
    php83-iconv \
    wget \
    && rm -rf /var/cache/apk/*

RUN addgroup -S www-data || true && adduser -S www-data -G www-data || true

EXPOSE 9000

COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY ./tools/wp_init.sh /usr/local/bin/wp_init.sh
RUN chmod +x /usr/local/bin/wp_init.sh

ENTRYPOINT ["/usr/local/bin/wp_init.sh"]
