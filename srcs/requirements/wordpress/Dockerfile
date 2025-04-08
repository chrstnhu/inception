# Base image: Utiliser une version stable de Debian ou Alpine avec PHP et WordPress
FROM php:7.4-fpm

# Ajouter des métadonnées à l'image
LABEL maintainer="chrhu" version="V1.0" date="2025-04-10"

# Installer les dépendances nécessaires pour WordPress (extensions PHP, etc.)
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Télécharger et installer WordPress
RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar -zxvf latest.tar.gz \
    && mv wordpress/* /var/www/html/ \
    && rmdir wordpress \
    && rm latest.tar.gz

# Copier le script d'installation pour la configuration de WordPress
COPY tools/wordpress-setup.sh /usr/local/bin/wordpress-setup.sh

# Donner les permissions au script et définir les bonnes permissions pour les fichiers WordPress
RUN chmod +x /usr/local/bin/wordpress-setup.sh \
    && chown -R www-data:www-data /var/www/html

# Configurer le point d'entrée du conteneur avec le script d'installation
CMD ["/usr/local/bin/wordpress-setup.sh"]
