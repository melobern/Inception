#!/bin/sh

mkdir -p /var/www/html
cd /var/www/html

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

sleep 10

if [ ! -e /var/www/html/wp-config.php ]; then
        echo "WP NOT INSTALLED !"
        wp core download --allow-root

        wp core config \
            --dbname="${SQL_DATABASE}" \
            --dbuser="${SQL_USER}" \
            --dbpass="${SQL_PASSWORD}" \
            --dbhost='mariadb:3306' \
            --allow-root

        wp core install \
            --url="${DOMAIN_NAME}" \
            --title="${SITE_TITLE}" \
            --admin_user="${WP_ADMIN}" \
            --admin_password="${WP_ADMIN_PASSWORD}" \
            --admin_email="${WP_ADMIN_EMAIL}" \
            --allow-root 

        wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
            --role=author \
            --user_pass="${WP_USER_PASSWORD}" \
            --allow-root

        #php config
#        wp config create --dbname="${SQL_DATABASE}" --dbuser="${SQL_USER}" --dbpass="${SQL_PASSWORD}" --dbhost="mariadb:3306" --allow-root

fi

# Set ownership and permissions
chown -R www-data:www-data /var/www/html || true
chmod -R 755 /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;
# Set wp-content to writable (for redis cache)
chown -R www-data:www-data /var/www/html/wp-content || true
chmod -R 775 /var/www/html/wp-content

mkdir -p /run/php
chown www-data:www-data /run/php
chmod 755 /run/php

# Start PHP-FPM
# exec $PHP_FPM_BIN -F
# exec /usr/sbin/php-fpm83  -F || exec php-fpm8  -F || exec /usr/sbin/php-fpm  -F ||  exec php-fpm83  -F
exec php-fpm83 -F