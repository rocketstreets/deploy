#!/bin/sh

echo "Pushing to docker hub version: "$1
docker login -u $DOCKER_USER --password $DOCKER_PWD

docker tag webapp-$1 dwipam/rocketstreets:webapp-$1
docker push dwipam/rocketstreets:webapp-$1

docker tag webapp_v2-$1 dwipam/rocketstreets:webapp_v2-$1
docker push dwipam/rocketstreets:webapp_v2-$1

docker tag engine-$1 dwipam/rocketstreets:engine-$1
docker push dwipam/rocketstreets:engine-$1

docker tag news-$1 dwipam/rocketstreets:news-$1
docker push dwipam/rocketstreets:news-$1

docker tag cron-$1 dwipam/rocketstreets:cron-$1
docker push dwipam/rocketstreets:cron-$1

docker tag robin_api-$1 dwipam/rocketstreets:robin_api-$1
docker push dwipam/rocketstreets:robin_api-$1

docker tag notify-$1 dwipam/rocketstreets:notify-$1
docker push dwipam/rocketstreets:notify-$1

echo "##############################Done######################"
