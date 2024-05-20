FROM node:20 AS builder

WORKDIR /app

COPY ./clientEventify/package*.json ./

RUN npm install

COPY ./tools .

RUN npm run build -- --configuration=production

CMD [ "tail", "-f", "/dev/null" ]
