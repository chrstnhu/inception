# Base image - Debian stable version
FROM    debian:bullseye

# Add metadata to the image
LABEL   author="chrhu" version="V1.0" date="2025-02-10"

# Update package lists and install dependencies (MariaDB and other utilities)
RUN     apt update -y && apt upgrade -y && apt install -y \
            vim \
            mariadb-server \
            curl \
            bash \
            && apt clean

# Create the MySQL directory and set correct permissions
RUN     mkdir -p /run/mysqld && chmod 755 /run/mysqld && chown -R mysql:mysql /run/mysqld

# Expose the MariaDB port
EXPOSE  3306

# Copy the custom MariaDB configuration file
COPY    conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Set correct permissions for the configuration file
RUN     chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf && chown -R mysql:mysql /etc/mysql/mariadb.conf.d/50-server.cnf

# Set ownership for MySQL data directory
RUN     chown -R mysql:mysql /var/lib/mysql

# Copy setup script for MariaDB
COPY    tools/mariadb-setup.sh /var/mariadb_setup/mariadb-setup.sh

# Set execution permissions for the setup script
RUN     chmod 755 /var/mariadb_setup/mariadb-setup.sh && chown -R mysql:mysql /var/mariadb_setup/mariadb-setup.sh

# Define the command to run the setup script on container start
CMD     ["bash", "/var/mariadb_setup/mariadb-setup.sh"]
