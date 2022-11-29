bootstrap-server = broker1:9092,broker2:9092,broker3:9092

start:
	docker compose up -d

start-local:
	docker compose -f local.yaml up -d

restart:
	docker compose restart

restart-local:
	docker compose -f local.yaml restart	

services-start:
	docker compose -f services.yaml up -d

stop:
	docker compose down --remove-orphans

tools:
	docker compose -f tools.yaml run --rm tools 

build:
	docker compose build

cleanup:
	docker rm -f $$(docker ps -aq)

destroy:
	docker compose -f tools.yaml run --rm tools bash -c \
		"rm -Rf /data/*"

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

list-topic:
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --list"

delete-topic:
	@read -p "Enter a topic name: " topic; \
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --delete --topic $$topic"

describe-topic:
	@read -p "Enter a topic name: " topic; \
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --describe --topic $$topic"

describe-groups:
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-consumer-groups.sh --bootstrap-server $(bootstrap-server) --describe --all-groups"

console-producer:
	@read -p "Enter a topic name: " topic; \
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-console-producer.sh --bootstrap-server $(bootstrap-server) --topic $$topic"

console-consumer:
	@read -p "Enter a topic name: " topic; \
	read -p "Enter a consumer group name: " group; \
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-console-consumer.sh --bootstrap-server $(bootstrap-server) --group $$group --topic $$topic --from-beginning"