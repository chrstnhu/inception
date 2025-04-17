# Base of image
FROM    debian:bullseye

# Add metadata to the image
LABEL   author="chrhu" version="V1.0" date="2025-02-10"

# Update package lists, install dependencies
RUN apt update -y && apt upgrade -y \
    && apt install -y vim \
    && apt-get install mariadb-server -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for MySQL (MariaDB) 
RUN     mkdir -p /run/mysqld \
        && chmod 755 /run/mysqld \
        && chown -R mysql:mysql /run/mysqld

# Expose port 3306,
EXPOSE  3306

# Copy MariaDB configuration files
COPY    conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Set permission to conf files
RUN     chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf \
        && chown -R mysql:mysql /run/mysqld

# Set the correct ownership of the MariaDB
RUN     chown -R mysql:mysql /var/lib/mysql

# Copy MariaDB setup script
COPY    tools/mariadb-setup.sh /var/mariadb_setup/mariadb-setup.sh

# Set permission to conf files
RUN     chmod 755 /var/mariadb_setup/mariadb-setup.sh \
        && chown -R mysql:mysql /var/mariadb_setup/mariadb-setup.sh

        # Execute the MariaDB setup script
CMD     ["bash", "/var/mariadb_setup/mariadb-setup.sh"]

