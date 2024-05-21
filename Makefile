all : up

clean : down

re : clean up

restart : stop start

up:
	@sudo docker-compose -f docker-compose.yml up -d --build

down:
	@sudo docker-compose -f docker-compose.yml down -v --rmi all

stop:
	@sudo docker-compose -f docker-compose.yml stop

start:
	@sudo docker-compose -f docker-compose.yml start

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
