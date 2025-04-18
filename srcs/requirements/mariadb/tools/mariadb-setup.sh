#!/bin/bash

# Reading password in secret file
echo "🔐 Reading secrets from files..."
DB_ROOT_PASSWORD=$(cat "$DB_ROOT_PASSWORD_FILE")
DB_PASSWORD=$(cat "$DB_PASSWORD_FILE")

# Starting the MariaDB service
echo "🚀 Starting the MariaDB service..."
service mariadb start

# Waiting to ensure MariaDB has fully started
echo "⏳ Waiting for MariaDB to initialize..."
sleep 5

# Creating the database if it doesn't already exist
echo "🛠️  Setting up the database and user..."
mysql -u root -p${DB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${DB_DATABASE}\`;"
mysql -u root -p${DB_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -u root -p${DB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${DB_DATABASE}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -u root -p${DB_ROOT_PASSWORD} -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${DB_ROOT_PASSWORD}');"
mysql -u root -p${DB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Shutting down MariaDB after changing
echo "🛑 Shutting down MariaDB safely..."
mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown

# Starting MariaDB in 'safe' mode
echo "🧯 Starting MariaDB in safe mode..."
su  mysql
exec mysqld_safe