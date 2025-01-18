# Tells the image to use
FROM alpine:3.20.5

# Author credits, replaces MAINTAINER (deprecated)
LABEL maintainer="mbernard@student.42lyon.fr"

# Installations + erases useless files to make the image smaller
RUN apk update --no-interactive && apk upgrade --no-interactive && apk add --no-interactive \
    openssl \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Configure TSL/SSL
RUN mkdir -p /etc/nginx/ssl
# x509 == auto-signed certificate and not a demand to an autority
# -nodes == no DES == no Data Encryption Standard
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=AURA/L=Lyon/O=42/OU=42/CN=mbernard.42.fr/UID=mbernard"

# Create directories for nginx + copy the good conf file to nginx location
RUN mkdir -p /var/run/nginx
COPY ./conf/nginx.conf /etc/nginx.nginx.conf

# Port to expose
EXPOSE 443

# For the website/Wordpress
RUN chmod -R /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Nginx must not demonize : if it did, Docker would stop
ENTRYPOINT ["nginx", "-g", "daemon off;"]
