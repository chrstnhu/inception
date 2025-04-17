NAME = inception

all:
	docker compose -f srcs/docker-compose.yml up -d --build

$(NAME): all

start:
	@echo "🔧 Construct services..."
	docker compose -f srcs/docker-compose.yml up -d

stop:
	@echo "🛑 Stop services..."
	docker compose -f srcs/docker-compose.yml down -v

clean:
	sudo docker compose -f ./srcs/docker-compose.yml down --rmi all -v

fclean: clean
	sudo docker system prune -a

	@if [ -d "/home/chrhu/data/wordpress" ]; then \
		sudo rm -rf /home/chrhu/data/wordpress/* && \
		echo "🧹 Successfully removed all contents from /home/chrhu/data/wordpress/"; \
	fi;

	@if [ -d "/home/chrhu/data/mariadb" ]; then \
		sudo rm -rf /home/chrhu/data/mariadb/* && \
		echo "🧹 Successfully removed all contents from /home/chrhu/data/mariadb/"; \
	fi;

re: clean all

reset: fclean all

ls:
	sudo docker image ls
	sudo docker ps

.PHONY: all start stop clean re ls
