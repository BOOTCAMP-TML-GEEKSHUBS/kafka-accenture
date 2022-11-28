start:
	docker compose up -d

tools:
	docker compose -f tools.yaml run tools 

build:
	docker compose build

server:
	docker run -it cursokafka

cleanup:
	docker rm -f $$(docker ps -aq)

stats:
	docker stats

du:
	du -h --max-depth=1 data/ 