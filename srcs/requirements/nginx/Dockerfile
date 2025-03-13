FROM debian:latest

RUN apt update && apt upgrade -y && apt install -y nginx

COPY default /etc/nginx/sites-availables/.

CMD ["nginx", "-g", "daemon off;"]
