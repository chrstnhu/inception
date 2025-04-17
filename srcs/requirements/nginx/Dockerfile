# Base of image
FROM    debian:bullseye

# Add metadata to the image
LABEL   author="chrhu" version="V1.0" date="2025-02-10"

# Update package lists, install dependencies
RUN     apt update -y && apt upgrade -y \
        && apt install -y \
            nginx \
            openssl \
            vim \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

# Expose port 443
EXPOSE  443

# Create a directory for SSL certificates
RUN     mkdir -p /etc/nginx/ssl

# Genereate a self-signed SSL certificats and key using OpenSSL
RUN     openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/OU=42/CN=chrhu.42.fr/UID=chrhu"

# Create a directory for Nginx process
RUN     mkdir -p /var/run/nginx

# Copy Nginx configuration files
COPY    conf/nginx.conf /etc/nginx/nginx.conf

COPY    conf/fastcgi-php.conf /etc/nginx/snippets

# Set permission to conf files
RUN     chmod 755 /var/www/html

# Change the ownership
RUN     chmod 755 /var/www/html \
        && chown -R www-data:www-data /var/www/html

# Run the Nginx server in the foreground
CMD     ["nginx", "-g", "daemon off;"]

