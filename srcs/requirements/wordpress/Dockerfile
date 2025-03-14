FROM debian:latest

RUN apt update && apt upgrade -y && apt install -y \
    php-fpm php-mysql php-mbstring php-xml php-gd php-curl php-cli php-common php-json

COPY www.conf /etc/php/8.2/fpm/pool.d/.

CMD ["php-fpm8.2", "-F"]
