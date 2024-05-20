#!/bin/bash

openssl req -x509 -nodes -out $CERTS_ -keyout $KEYS_ -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=$DOMAIN_NAME/UID=mlongo"

sed -i -r "s#first#$CERTS_#g"    /etc/nginx/nginx.conf

sed -i -r "s#second#$KEYS_#g"    /etc/nginx/nginx.conf

chmod 755 /var/www/angular/
chown -R www-data:www-data /var/www/angular/

nginx -g "daemon off;"
