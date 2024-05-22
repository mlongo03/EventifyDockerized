FROM node:20 AS builder

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

CMD [ "tail", "-f", "/dev/null" ]
