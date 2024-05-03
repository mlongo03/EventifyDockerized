all : up

clean : down

re : vclean up

reboot : down up

restart : stop start

vclean: down
	@sudo rm -rf /home/manuele/data/postgres/*
	@sudo rm -rf /home/manuele/data/angular/*

up:
	@if [ ! -f srcs/.env ]; then \
	touch srcs/.env ; \
	echo CERTS_=/etc/nginx/ssl/inception.crt >> srcs/.env; \
	echo KEYS_=/etc/nginx/ssl/inception.key >> srcs/.env; \
	echo SQL_ROOT_PASSWORD=1234 >> srcs/.env; \
	echo USERDOCKER=${USER} >> srcs/.env; \
	echo POSTGRES_PASSWORD=1234 >> srcs/.env; \
	echo POSTGRES_DB=eventify >> srcs/.env; \
	fi
	@if [ ! -d /home/${USER}/data ]; then \
	mkdir /home/${USER}/data; \
	mkdir /home/${USER}/data/postgres; \
	mkdir /home/${USER}/data/angular; \
	fi
	@if [ ! -d /home/${USER}/data/postgres ]; then \
	mkdir /home/${USER}/data/postgres; \
	fi
	@if [ ! -d /home/${USER}/data/angular ]; then \
	mkdir /home/${USER}/data/angular; \
	fi
	@sudo docker-compose -f srcs/docker-compose.yml up -d --build

down:
	@sudo docker-compose -f srcs/docker-compose.yml down -v --rmi all

stop:
	@sudo docker-compose -f srcs/docker-compose.yml stop

start:
	@sudo docker-compose -f srcs/docker-compose.yml start

status:
	@sudo docker ps -a

image:
	@sudo docker image ls

volume:
	@sudo docker volume ls

network:
	@sudo docker network inspect srcs_eventify

logs:
	@echo "\nlogs of springbootn\n--------------------------------------------\n"
	@sudo docker logs springboot
	@echo "\nlogs of postgres\n--------------------------------------------\n"
	@sudo docker logs postgres
	@echo "\nlogs of angular\n--------------------------------------------\n"
	@sudo docker logs angular

nginx:
	@sudo docker exec -it nginx /bin/bash

angular:
	@sudo docker exec -it angular /bin/bash

postgres:
	@sudo docker exec -it postgres /bin/bash

springboot:
	@sudo docker exec -it springboot /bin/bash

postgres_address:
	sudo docker inspect postgres | grep IPAddress
