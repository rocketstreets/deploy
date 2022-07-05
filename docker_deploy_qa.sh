#!/bin/sh

echo "Deploying version: "$1
sudo docker login -u $DOCKER_USER --password $DOCKER_PWD
echo "\n####################################Creating Subnet####################################"
sudo docker network create --subnet=172.0.0.1/16 rocketstreets_network

echo "\n####################################Starting Neo4j####################################"
sudo docker run --net rocketstreets_network --ip 172.0.0.2 --tty -d \
           --name neo4j-qa -p7687:7687 -p7474:7474 -p7473:7473 \
           --env NEO4J_AUTH=neo4j/rs --env NEO4J_ACCEPT_LICENSE_AGREEMENT=yes neo4j

echo "\n####################################Starting Postgres####################################"
sudo docker run --name postgresql-qa --net rocketstreets_network --ip 172.0.0.3 -p 5432:5432 -e POSTGRES_PASSWORD=rs -d postgres

echo "\n####################################Starting Webapp####################################"
sudo docker run --name webapp-qa --net rocketstreets_network --ip 172.0.0.4 -d -p 5000:5000 dwipam/rocketstreets:webapp-qa-$1

#echo "\n####################################Starting Webapp_v2####################################"
#sudo docker run --name webapp_v2-qa --net rocketstreets_network --ip 172.0.0.10 -d -p 3000:3000 dwipam/rocketstreets:webapp_v2-qa-$1

echo "\n####################################Starting Robin (QA) API####################################"
sudo docker run --name robin_api-qa --net rocketstreets_network --ip 172.0.0.5 -d -p 5002:5002 dwipam/rocketstreets:robin_api-qa-$1

echo "\n####################################Starting Engine####################################"
sudo docker run --name engine-qa --net rocketstreets_network --ip 172.0.0.6 -d -p 5001:5001 dwipam/rocketstreets:engine-qa-$1

echo "\n####################################Starting News####################################"
sudo docker run --name news-qa --env TURN_OFF_OAUTH=True --net rocketstreets_network --ip 172.0.0.8 -d -p 5003:5003 dwipam/rocketstreets:news-qa-$1

echo "\n####################################Starting Notify####################################"
sudo docker run --name notify-qa --env IS_QA=True --net rocketstreets_network --ip 172.0.0.9 -d -p 5005:5005 dwipam/rocketstreets:notify-qa-$1

echo "\n####################################Initializing DB####################################"
sudo docker exec engine-qa python initialize_db.py
sudo docker exec engine-qa python tickers.py sample

#echo "\n####################################Starting Cron####################################"
#sudo docker run --name cron-qa --net rocketstreets_network --ip 172.0.0.7 -d -p 5004:5004 dwipam/rocketstreets:cron-qa-$1


echo "\n####################################Done####################################"