COMPOSE_FILE = ./srcs/docker-compose.yml

all: up

up:
	mkdir -p $(HOME)/data/mariadb
	mkdir -p $(HOME)/data/wordpress
	mkdir -p $(HOME)/data/website
	docker compose -f $(COMPOSE_FILE) -p inception up --build -d

down:
	docker compose -f $(COMPOSE_FILE) -p inception down --remove-orphans 

stop:
	docker compose -f $(COMPOSE_FILE) -p inception stop

logs:
	docker compose -f $(COMPOSE_FILE) -p inception logs

ps:
	docker compose -f $(COMPOSE_FILE) -p inception ps

config:
	docker compose -f $(COMPOSE_FILE) -p inception config

clean:
	docker system prune -f -a --volumes

fclean: clean
	rm -rf $(HOME)/data

re: fclean
	all

totalClean:
	docker stop $$(docker ps -qa)
	docker rm $$(docker ps -qa)
	docker rmi -f $$(docker images -qa)
	docker volume rm $$(docker volume ls -q)
	docker network rm $$(docker network ls -q) 2>/dev/null

.PHONY: up down stop logs ps config clean fclean totalClean
