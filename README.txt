----------

PREREQUISITES

- docker and docker-compose correctly installed
- terminal to execute commands that will start the application
- internet connection

----------

CONFIGURATION

- you can insert your credentials and data by changing environmental
  variables in .env file
  -- change client ip, port
  -- change server ip, port
  -- change database (postgres) credentials
  -- change eventify utilities
  -- change backend ssl certification by changing ssl keystore file putting the new one in springboot/serverEventify/src/main/resources
     resplacing the oldest one (default one is eventify.jks), and then if needed by changing properly environmental Backend ssl keystore
     credential variables in .env file
  -- change frontend ssl certification by replacing oldest .crt and .key files in nginx/conf (default are eventify.crt and eventify.key)
     and then if needed by properly changing the environmental Frontend ssl files credential variables in .env file

----------

STARTING THE APPLICATION

- you have to enter from terminal in the root of the project repository
-- run "make" or "make up"
  this command will automatically build containers images, run them, create volumes and create the network

after that you can enjoy the application on the client ip address (i.e https://localhost:443)

----------

OTHER FEATURES

- run "make clean" or "make down" if you want to shutdown containers eliminate their images, network and volumes
- run "make re" if you want to shutdown containers eliminate their images, network and volumes and restart the application
- run "make restart" if you want to shutdown containers and restart the them
- run "make stop" if you want to shutdown containers
- run "make start" if you want to start containers
- run "make angular" or "make springboot" or "make nginx" or "make postgres" if you want to enter by terminal in one of the containers available
- run "sudo docker exec -it postgres psql postgres://<postgres user>:<postgres password>@<postgres ip>:<postgres port>/<postgres database>" or
      "sudo docker exec -it postgres psql -U <postgres user> -d <postgres datbase> -W" and then you enter the <postgres passord> in order to enter
      directly in postgres

