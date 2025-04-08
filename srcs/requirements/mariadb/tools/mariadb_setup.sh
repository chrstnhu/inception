#!/bin/bash

# Attendre que MariaDB soit complètement initialisé
echo "Attente de l'initialisation de MariaDB..."
while ! mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" ping --silent; do
    sleep 1
done

# Si la base de données n'est pas initialisée, la créer
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initialisation de la base de données MariaDB..."
    mysqld --initialize --user=mysql
fi

# Démarrage du service MariaDB (en arrière-plan)
echo "Démarrage de MariaDB..."
mysqld_safe --user=mysql &

# Attendre que MariaDB soit démarré et prêt à recevoir des connexions
echo "Attente que MariaDB démarre..."
while ! mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" ping --silent; do
    sleep 1
done

# Créer la base de données et les utilisateurs si nécessaire
echo "Création de la base de données et des utilisateurs..."

mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOF

# Vérification de la création de la base et des utilisateurs
echo "Vérification des bases et utilisateurs..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW DATABASES;"

# Terminer le script en gardant le service MariaDB en cours d'exécution
echo "MariaDB configuré et prêt à l'emploi."
tail -f /dev/null
