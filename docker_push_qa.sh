#!/bin/sh

echo "Pushing to docker hub version: "$1
docker login -u $DOCKER_USER --password $DOCKER_PWD

docker tag webapp-qa-$1 dwipam/rocketstreets:webapp-qa-$1
docker push dwipam/rocketstreets:webapp-qa-$1

#docker tag webapp_v2-qa-$1 dwipam/rocketstreets:webapp_v2-qa-$1
#docker push dwipam/rocketstreets:webapp_v2-qa-$1

docker tag engine-qa-$1 dwipam/rocketstreets:engine-qa-$1
docker push dwipam/rocketstreets:engine-qa-$1

docker tag news-qa-$1 dwipam/rocketstreets:news-qa-$1
docker push dwipam/rocketstreets:news-qa-$1

docker tag robin_api-qa-$1 dwipam/rocketstreets:robin_api-qa-$1
docker push dwipam/rocketstreets:robin_api-qa-$1

docker tag notify-qa-$1 dwipam/rocketstreets:notify-qa-$1
docker push dwipam/rocketstreets:notify-qa-$1

echo "##############################Done######################"
