#!/bin/sh

sudo docker login -u$DOCKER_USER --password $DOCKER_PWD
echo "\n####################################Creating Subnet####################################"
sudo docker network create --subnet=172.0.0.1/16 rocketstreets_network

echo "\n####################################Starting Neo4j####################################"
sudo docker run --net rocketstreets_network --ip 172.0.0.2 --tty -d \
           --name neo4j -p7687:7687 -p7474:7474 -p7473:7473 \
           --env NEO4J_AUTH=neo4j/rs --env NEO4J_ACCEPT_LICENSE_AGREEMENT=yes neo4j

echo "\n####################################Starting Postgres####################################"
sudo docker run --name postgresql --net rocketstreets_network --ip 172.0.0.3 -p 5432:5432 -e POSTGRES_PASSWORD=rs -d postgres

echo "\n####################################Starting Webapp####################################"
sudo docker run --name webapp --net rocketstreets_network --ip 172.0.0.4 -d -p 5000:5000 dwipam/rocketstreets:webapp-v0.0.0

echo "\n####################################Starting Robin API####################################"
sudo docker run --name robin_api --net rocketstreets_network --ip 172.0.0.5 -d -p 5002:5002 dwipam/rocketstreets:robin_api-v0.0.0

echo "\n####################################Starting Engine####################################"
sudo docker run --name engine --net rocketstreets_network --ip 172.0.0.6 -d -p 5001:5001 dwipam/rocketstreets:engine-v0.0.0

echo "\n####################################Initializing DB####################################"
sudo docker exec engine python initialize_db.py

echo "\n####################################Done####################################"