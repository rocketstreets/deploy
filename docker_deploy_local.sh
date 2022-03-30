#!/bin/sh

echo "Deploying version: "$1

echo "\n####################################Creating Subnet####################################"
docker network create --subnet=172.0.0.1/16 rocketstreets_network

echo "\n####################################Starting Neo4j####################################"
docker run --net rocketstreets_network --ip 172.0.0.2 --tty -d \
           --name neo4j -p7687:7687 -p7474:7474 -p7473:7473 \
           --env NEO4J_AUTH=neo4j/rs --env NEO4J_ACCEPT_LICENSE_AGREEMENT=yes neo4j

echo "\n####################################Starting Postgres####################################"
docker run --name postgresql --net rocketstreets_network --ip 172.0.0.3 -p 5432:5432 -e POSTGRES_PASSWORD=rs -d postgres

echo "\n####################################Starting Webapp####################################"
docker run --name webapp --net rocketstreets_network --ip 172.0.0.4 -d -p 5000:5000 webapp-$1

echo "\n####################################Starting Robin API####################################"
docker run --name robin_api --net rocketstreets_network --ip 172.0.0.5 -d -p 5002:5002 robin_api-$1

echo "\n####################################Starting Engine####################################"
docker run --name engine --net rocketstreets_network --ip 172.0.0.6 -d -p 5001:5001 engine-$1

echo "\n####################################Starting Cron####################################"
docker run --name cron --net rocketstreets_network --ip 172.0.0.7 -d -p 5004:5004 cron-$1

echo "\n####################################Initializing DB####################################"
docker exec engine python initialize_db.py
docker exec engine python tickers.py sample

echo "\n####################################Done####################################"