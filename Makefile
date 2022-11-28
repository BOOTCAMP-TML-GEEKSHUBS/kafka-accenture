build:
	docker build -t cursokafka .

server:
	docker run -it cursokafka

cleanup:
	docker rm -f $$(docker ps -aq)