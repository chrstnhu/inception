all:
	@sudo hostsed add 127.0.0.1 chrhu.42.fr && echo "successfully added chrhu.42.fr to /etc/hosts"
	sudo docker compose -f ./srcs/docker-compose.yml up -d 

clean:
	sudo docker compos -f ./srcs/docker-compose.yml down --rmi all -v

fclean: clean
	@sudo hostsed rm 127.0.0.1 chrhu.42.fr && echo "successfully removed chrhu.42.fr from /etc/hosts"
	@if [ -d "/home/chrhu/data/wordpress" ];
	then sudo rm -rf /home/chrhu/data/wordpress/* && \
	echo "successfully rm all contents from /home/chrhu/data/wordpress/"; \
	fi

	@if [ -d "/home/chrhu/data/mariadb" ]; then \
	sudo rm -rf /home/chrhu/data/mariadb/* && \
	echo "successfully removed all contents from /home/chrhu/data/mariadb/"; \
	fi;

re : fclean all

.PHONY: all clean fclean re