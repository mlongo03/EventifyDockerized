FROM debian:bullseye

ARG CERT_FILE
ARG KEY_FILE
ARG CERTS_
ARG KEYS_

ENV CERT_FILE=${CERT_FILE}
ENV KEY_FILE=${KEY_FILE}
ENV CERTS_=${CERTS_}
ENV KEYS_=${KEYS_}

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
COPY conf/${CERT_FILE} ${CERTS_}
COPY conf/${KEY_FILE} ${KEYS_}

RUN chmod +x /nginx.sh

CMD [ "/nginx.sh" ]
