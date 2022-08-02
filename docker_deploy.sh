#!/bin/sh

echo "Deploying version: "$1
sudo docker login -u $DOCKER_USER --password $DOCKER_PWD
echo "\n####################################Creating Subnet####################################"
sudo docker network create --subnet=172.0.0.1/16 rocketstreets_network

echo "\n####################################Starting Neo4j####################################"
sudo docker run --net rocketstreets_network --ip 172.0.0.2 --tty -d \
           --name neo4j -p7687:7687 -p7474:7474 -p7473:7473 \
           --env NEO4J_AUTH=neo4j/rs --env NEO4J_ACCEPT_LICENSE_AGREEMENT=yes neo4j

echo "\n####################################Starting Postgres####################################"
sudo docker run --name postgresql --net rocketstreets_network --ip 172.0.0.3 -p 5432:5432 -e POSTGRES_PASSWORD=rs -d postgres

#echo "\n####################################Starting Webapp####################################"
#sudo docker run --name webapp --net rocketstreets_network --ip 172.0.0.4 -d -p 5000:5000 dwipam/rocketstreets:webapp-$1

echo "\n####################################Starting Webapp_v2####################################"
sudo docker run --name webapp_v2  --net rocketstreets_network \
            -d -p 3000:3000 -e ENGINE_API_URL=http://172.0.0.6 \
            -e NEWS_API_URL=http://172.0.0.8 \
            -e ENGINE_PORT=5001 \
            -e NEWS_ENGINE_PORT=5003  dwipam/rocketstreets:webapp_v2-$1

echo "\n####################################Starting Robin API####################################"
sudo docker run --name robin_api --net rocketstreets_network --ip 172.0.0.5 -d -p 5002:5002 dwipam/rocketstreets:robin_api-$1

echo "\n####################################Starting Engine####################################"
sudo docker run --name engine --env SMTP_PWD=$SMTP_PWD --env TURN_OFF_OAUTH=True --net rocketstreets_network --ip 172.0.0.6 -d -p 5001:5001 dwipam/rocketstreets:engine-$1

echo "\n####################################Starting News####################################"
sudo docker run --name news --net rocketstreets_network --env TURN_OFF_OAUTH=True --ip 172.0.0.8 -d -p 5003:5003 dwipam/rocketstreets:news-$1

echo "\n####################################Starting Notify####################################"
sudo docker run --name notify --env SMTP_PWD=$SMTP_PWD --net rocketstreets_network --ip 172.0.0.9 -d -p 5005:5005 dwipam/rocketstreets:notify-$1

echo "\n####################################Initializing DB####################################"
sudo docker exec engine python initialize_db.py
sudo docker exec engine python tickers.py sample

echo "\n####################################Starting Cron####################################"
sudo docker run --name cron --net rocketstreets_network --ip 172.0.0.7 -d -p 5004:5004 dwipam/rocketstreets:cron-$1

echo "\n####################################Done####################################"