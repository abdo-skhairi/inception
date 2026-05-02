#!/bin/bash

set -e

echo "Waiting for MariaDB..."

until mysqladmin ping -h mariadb -u"${MYSQL_USER}" --password="${MYSQL_PASSWORD}" --silent; do
    sleep 2
done

echo "MariaDB ready"

cd /var/www/html

if [ ! -f "wp-config.php" ]; then
    echo "Installing WordPress..."

    wp core download --allow-root

    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost=mariadb \
        --allow-root

    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root

    echo "WordPress installed."
else
    echo "WordPress already configured, skipping install."
fi

echo "Starting PHP-FPM..."
exec php-fpm7.4 -F