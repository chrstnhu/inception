# Base of image
FROM    debian:bullseye

# Add metadata to the image
LABEL   author="chrhu" version="V1.0" date="2025-02-10"

# Update package lists, install dependencies
RUN     apt update -y && apt upgrade -y \
            && apt-get install -y wget

# Install PHP, Mariadb for Wordpress
RUN     apt-get install -y php7.4\
            php7.4-fpm \
            php7.4-mysql \
            php7.4-cli \
            mariadb-client \
            vim \
            && apt-get clean \
            && rm -rf /var/lib/apt/lists/*

# Download WP-CLI (WordPress Command Line Interface), manage WordPress installations 
RUN     wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
        && chmod +x /usr/local/bin/wp

# Create directory and set permission for Wordpress files
RUN     mkdir -p /var/www/html \
        && chmod 755 /var/www/html \
        && chown -R www-data:www-data /var/www/html

# Copy PHP configuration files
COPY    ./conf/php.ini /etc/php/7.4/fpm/

COPY    ./conf/www.conf /etc/php/7.4/fpm/pool.d

# Set permission to conf files
RUN     chmod 755 /etc/php/7.4/fpm/pool.d \
        && chown -R www-data:www-data /etc/php/7.4/fpm/pool.d/www.conf

# Expose port 9000
EXPOSE  9000

# Create directory for storing auto-conf script
RUN     mkdir -p /var/wp-auto-config/

# Copy auto-config
COPY    /tools/auto-config.sh /var/wp-auto-config/

# Set permission to auto-config
RUN     chmod 755 /var/wp-auto-config/auto-config.sh \
        && chown -R root:root /var/wp-auto-config/auto-config.sh

# Set the working directory
WORKDIR /var/www/html

# Execute auto-config.sh script with bash
ENTRYPOINT     ["bash", "/var/wp-auto-config/auto-config.sh"]