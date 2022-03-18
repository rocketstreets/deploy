#!/bin/sh

echo "Pushing to docker hub version: "$1
docker login -u $DOCKER_USER --password $DOCKER_PWD
docker tag webapp-$1 dwipam/rocketstreets:webapp-$1
docker push dwipam/rocketstreets:webapp-$1

docker tag engine-$1 dwipam/rocketstreets:engine-$1
docker push dwipam/rocketstreets:engine-$1

docker tag robin_api-$1 dwipam/rocketstreets:robin_api-$1
docker push dwipam/rocketstreets:robin_api-$1

echo "##############################Done######################"
