start:
	docker compose up -d

build:
	docker build -t cursokafka .

server:
	docker run -it cursokafka

cleanup:
	docker rm -f $$(docker ps -aq)

stats:
	docker stats

du:
	du -h --max-depth=1 data/ 