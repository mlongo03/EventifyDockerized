FROM debian:bullseye

RUN apt update \
 && apt install nginx -y \
 && apt install vim -y \
 && apt install curl -y \
 && mkdir -p /etc/nginx/ssl \
 && apt install openssl -y \
 && mkdir -p /var/run/nginx \
 && chmod 755 /var/www/ \
 && chown -R www-data:www-data /var/www/

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/nginx.sh /

RUN chmod +x /nginx.sh

CMD [ "/nginx.sh" ]
