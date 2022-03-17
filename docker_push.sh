#!/bin/sh

docker tag webapp-v0.0.1 dwipam/rocketstreets:webapp-v0.0.1
docker push dwipam/rocketstreets:webapp-v0.0.1

docker tag engine-v0.0.1 dwipam/rocketstreets:engine-v0.0.1
docker push dwipam/rocketstreets:engine-v0.0.1

docker tag robin_api-v0.0.1 dwipam/rocketstreets:robin_api-v0.0.1
docker push dwipam/rocketstreets:robin_api-v0.0.1
