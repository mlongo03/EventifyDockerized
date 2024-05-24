FROM node:20 AS build

ARG SERVER_IP
ARG SERVER_PORT
ARG SERVER_PROT

ENV SERVER_IP=${SERVER_IP}
ENV SERVER_PORT=${SERVER_PORT}
ENV SERVER_PROT=${SERVER_PROT}

WORKDIR /app

COPY ./clientEventify/package*.json ./

RUN npm install

COPY ./clientEventify .

RUN sh ./docker-init.sh

RUN npm run build -- --configuration=production

FROM debian:bullseye

RUN mkdir -p /run/www/angular

COPY --from=build /app/dist/my_app /var/www/angular

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
