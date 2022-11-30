bootstrap-server = broker1:9092,broker2:9092,broker3:9092

start: ## start private network context
	docker compose up -d

start-local: ## start localhost context
	docker compose -f local.yaml up -d

start-all-in-one: ## start confluentic all in one
	docker compose -f all-in-one.yaml up -d

restart: ## restart private network context
	docker compose restart

restart-local: ## restart localhost context
	docker compose -f local.yaml restart	

services-start: ## start services
	docker compose -f services.yaml up -d

stop: ## stop all containers
	docker compose down --remove-orphans

tools: ## deploy new container with operations tools
	docker compose -f tools.yaml run --rm tools 

build: ## build docker images
	docker compose build

cleanup: ## make containers cleanup
	docker rm -f $$(docker ps -aq)

destroy: ## destroy data state of brokers and zookeeker 
	docker compose -f tools.yaml run --rm tools bash -c \
		"rm -Rf /data/*"

stats: ## show docker stats
	docker stats

du: ## show disk used
	du -h --max-depth=1 data/ 

create-topic: ## create a new topic
	@read -p "Enter a topic name: " topic; \
	read -p "Enter partitions number: " partitions; \
	read -p "Enter replication factor: " replication; \
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --create --topic $$topic --partitions $$partitions --replication-factor $$replication"

list-topic:  ## show topic list
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --list"

delete-topic:  ## delete a topic
	@read -p "Enter a topic name: " topic; \
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --delete --topic $$topic"

describe-topic:  ## describe a topic
	@read -p "Enter a topic name: " topic; \
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --describe --topic $$topic"

describe-groups: ## describe all groups 
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-consumer-groups.sh --bootstrap-server $(bootstrap-server) --describe --all-groups"

console-producer: ## deploy new console producer
	@read -p "Enter a topic name: " topic; \
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-console-producer.sh --bootstrap-server $(bootstrap-server) --topic $$topic"

console-consumer: ## deploy new console consumer 
	@read -p "Enter a topic name: " topic; \
	read -p "Enter a consumer group name: " group; \
	docker compose -f tools.yaml run --rm tools bash -c \
		"./bin/kafka-console-consumer.sh --bootstrap-server $(bootstrap-server) --group $$group --topic $$topic --from-beginning"


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'