bootstrap-server = broker1:9092,broker2:9092,broker3:9092

start:
	docker compose up -d

tools:
	docker compose -f tools.yaml run --rm tools 

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

create-topic:
	@read -p "Enter a topic name: " topic; \
	read -p "Enter partitions number: " partitions; \
	read -p "Enter replication factor: " replication; \
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --create --topic $$topic --partitions $$partitions --replication-factor $$replication"