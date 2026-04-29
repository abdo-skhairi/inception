#!/bin/bash

set -e

echo "Starting MariaDB..."

# start MariaDB in safe mode
mysqld_safe --datadir=/var/lib/mysql &

sleep 5

echo "Configuring database..."

# use root WITHOUT password (initial bootstrap mode)
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;
EOF

echo "Securing root user..."

mysql -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo "MariaDB ready."

# keep container alive
wait