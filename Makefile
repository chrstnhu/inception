NAME = inception

all:
	docker compose -f srcs/docker-compose.yml up -d --build

$(NAME): all

start:
	docker compose -f srcs/docker-compose.yml up -d

stop:
	docker compose -f srcs/docker-compose.yml down -v

clean:
	make stop
	docker system prune -af

re: clean all

.PHONY: all start stop clean re