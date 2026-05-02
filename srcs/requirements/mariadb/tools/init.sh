#!/bin/bash

set -e

# Start MariaDB in background first
mysqld_safe --skip-networking &

# Wait until it's actually ready
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

# Only configure if not already done
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Configuring database..."

    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    echo "Database configured."
else
    echo "Database already configured, skipping..."
fi

# Shutdown background instance
mysqladmin -u root --password="${MYSQL_ROOT_PASSWORD}" shutdown

sleep 2

# Start in foreground
exec mysqld_safe