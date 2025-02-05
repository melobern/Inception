# Use the official Alpine Linux image as a base image
FROM alpine:3.20.5

# Author credits, replaces MAINTAINER (deprecated)
LABEL maintainer="mbernard@student.42lyon.fr"

# Install dependencies
RUN apk update --no-cache --no-interactive && apk upgrade --no-cache --no-interactive && apk add --no-cache --no-interactive \
    mariadb-client \
    php \
    php-fpm \
    php-mysqli \
    php-mysqlnd \
    php-phar \
    wget \
    && rm -rf /var/cache/apk/*

# Expose the PHP-FPM port
EXPOSE 9000

# PHP configuration
COPY ./conf/www.conf /etc/php7/php-fpm.d/www.conf

# WordPress configuration
COPY ./tools/wp_init.sh /usr/local/bin/wp_init.sh
RUN chmod +x /usr/local/bin/wp_init.sh


ENTRYPOINT ["/usr/local/bin/wp_init.sh"]

#
#
# Tells the image to use
#FROM alpine:3.20.5

# Author credits, replaces MAINTAINER (deprecated)
#LABEL maintainer="mbernard@student.42lyon.fr"

# Installations + erases useless files to make the image smaller
#RUN apk update --no-cache --no-interactive && apk upgrade --no-cache --no-interactive && apk add --no-cache --no-interactive \
#    mariadb-client \
#    php \
#    php-fpm \
#    php-mysqli \
#    php-mysqlnd \
#    wget \
#    && rm -rf /var/cache/apk/*

#EXPOSE 9000

# PHP configuration 
#COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Wordpress configuration 
#COPY ./tools/wp_init.sh /usr/local/bin/wp_init.sh

#RUN chmod +x /usr/local/bin/wp_init.sh


#ENTRYPOINT ["/usr/local/bin/wp_init.sh"]
