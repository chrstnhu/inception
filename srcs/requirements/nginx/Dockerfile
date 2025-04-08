# Base image: Utiliser une version d'Alpine (ou Debian) stable pour NGINX
FROM alpine:latest

# Ajouter des métadonnées à l'image
LABEL maintainer="chrhu" version="V1.0" date="2025-04-10"

# Installer NGINX et OpenSSL (nécessaire pour la gestion de TLS)
RUN apk update && apk add --no-cache \
    nginx \
    openssl \
    && rm -rf /var/cache/apk/*

# Créer les répertoires nécessaires pour NGINX
RUN mkdir -p /etc/nginx/ssl /etc/nginx/conf.d /var/www/html

# Copier la configuration NGINX dans le conteneur
COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY conf/ssl.conf /etc/nginx/conf.d/ssl.conf

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf  # Si besoin de config MySQL

# Copier les certificats SSL (préalablement générés ou fournis)
COPY certs/ssl.crt /etc/nginx/ssl/ssl.crt

COPY certs/ssl.key /etc/nginx/ssl/ssl.key

# Exposer les ports nécessaires pour HTTPS
EXPOSE 443

# Configurer le point d'entrée (entrée pour démarrer NGINX)
CMD ["nginx", "-g", "daemon off;"]
