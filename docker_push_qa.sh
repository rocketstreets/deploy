#!/bin/sh

echo "Pushing to docker hub version: "$1
docker login -u $DOCKER_USER --password $DOCKER_PWD
docker tag webapp-qa-$1 dwipam/rocketstreets:webapp-qa-$1
docker push dwipam/rocketstreets:webapp-qa-$1

docker tag engine-qa-$1 dwipam/rocketstreets:engine-qa-$1
docker push dwipam/rocketstreets:engine-qa-$1

docker tag news-qa-$1 dwipam/rocketstreets:news-qa-$1
docker push dwipam/rocketstreets:news-qa-$1

docker tag cron-qa-$1 dwipam/rocketstreets:cron-qa-$1
docker push dwipam/rocketstreets:cron-qa-$1

docker tag robin_api-qa-$1 dwipam/rocketstreets:robin_api-qa-$1
docker push dwipam/rocketstreets:robin_api-qa-$1

echo "##############################Done######################"
