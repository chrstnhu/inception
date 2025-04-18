#!/bin/bash

# Read from docker secrets
echo "🔐 Reading secrets from files..."
DB_PASSWORD=$(cat "$DB_PASSWORD_FILE")
WP_ADM_USER=$(cat "$WP_ADM_USER_FILE")
WP_ADM_PASS=$(cat "$WP_ADM_PASS_FILE")
WP_ADM_MAIL=$(cat "$WP_ADM_MAIL_FILE")
WP_GUEST_USER=$(cat "$WP_GUEST_USER_FILE")
WP_GUEST_PASS=$(cat "$WP_GUEST_PASS_FILE")
WP_GUEST_MAIL=$(cat "$WP_GUEST_MAIL_FILE")
DB_HOST=$DB_HOST

echo "⏳ Waiting for initializing service..."
sleep 5


# Check required environment variables are set
echo "🔍 Checking required environment variables..."
if [ -z "$DB_DATABASE" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ] || [ -z "$DB_HOST" ]; then
    echo "Error: Required environment variables are not set."
    exit 1
fi


# Wait for MariaDB to be ready
echo "⌛ Waiting for MariaDB to be ready..."
until mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "USE $DB_DATABASE;" >/dev/null 2>&1; do
    echo "⏳ Waiting for real DB to be ready..."
    sleep 3
done


# Check if WordPress is already installed
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "🔧 Set permission /var/www/html..."
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
    
    echo "⬇️ WordPress isn't installed, download..."
    rm -rf /var/www/html/*
    wp core download --path="/var/www/html" --allow-root

    #echo "🔎 Debug info:"
    #echo "DB_HOST: $DB_HOST"
    #echo "DB_DATABASE: $DB_DATABASE"
    #echo "DB_USER: $DB_USER"
    #echo "Trying to connect with: mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD $DB_DATABASE"
    #mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "SHOW DATABASES;"

    # Check if wp-config.php is created
    echo "🛠️ Trying to create wp-config.php..."
    until wp config create --path="/var/www/html" --allow-root \
        --dbname="$DB_DATABASE" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="$DB_HOST"; do
        echo "❌ wp-config.php creation failed. Retrying in 5s..."
        sleep 5
    done

    echo "✅ wp-config.php created successfully!"

    echo "🚀 Installing WordPress..."
    wp core install --path="/var/www/html" --allow-root --url="$DOMAIN_NAME" --title="$SITE_NAME" --admin_user="$WP_ADM_USER" --admin_password="$WP_ADM_PASS" --admin_email="$WP_ADM_MAIL"

    echo "👤 Creating user..."
    wp user create "$WP_GUEST_USER" "$WP_GUEST_MAIL" --role="subscriber" --user_pass="$WP_GUEST_PASS" --allow-root --path="/var/www/html"
    echo "✅ Successfully installed WordPress!"

else 
    echo "✅ WordPress configuration exists, skipping installation."
fi

# Start PHP-FPM
echo "🚦 Starting PHP-FPM..."
mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F