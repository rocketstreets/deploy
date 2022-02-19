#!/bin/sh

docker tag webapp-v0.0.0 dwipam/rocketstreets:webapp-v0.0.0
docker push dwipam/rocketstreets:webapp-v0.0.0

docker tag engine-v0.0.0 dwipam/rocketstreets:engine-v0.0.0
docker push dwipam/rocketstreets:engine-v0.0.0

docker tag robin_api-v0.0.0 dwipam/rocketstreets:robin_api-v0.0.0
docker push dwipam/rocketstreets:robin_api-v0.0.0
