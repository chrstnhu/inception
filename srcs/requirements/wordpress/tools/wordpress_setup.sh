#!/bin/bash

# Variables d'environnement
DB_NAME=${MYSQL_DATABASE}
DB_USER=${MYSQL_USER}
DB_PASSWORD=${MYSQL_PASSWORD}
DB_HOST=${MYSQL_HOST}

# Vérification si la base de données est déjà configurée
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Configuration de WordPress..."

    # Copie du fichier de configuration de base de WordPress
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

    # Remplacer les variables dans le fichier wp-config.php
    sed -i "s/database_name_here/${DB_NAME}/g" /var/www/html/wp-config.php
    sed -i "s/username_here/${DB_USER}/g" /var/www/html/wp-config.php
    sed -i "s/password_here/${DB_PASSWORD}/g" /var/www/html/wp-config.php
    sed -i "s/localhost/${DB_HOST}/g" /var/www/html/wp-config.php

    # Génération des clés de sécurité WordPress (optionnel mais recommandé)
    curl -s https://api.wordpress.org/secret-key/1.1/salt/ | tee -a /var/www/html/wp-config.php

    echo "WordPress configuré avec succès!"
fi

# Démarrer PHP-FPM
php-fpm
