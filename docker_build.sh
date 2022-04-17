#!/bin/sh

echo "Building version: "$1
echo "\n####################################Building Webapp####################################"
cd ../webapp
docker build -f Dockerfile --tag webapp-$1 .

echo "\n####################################Building Engine####################################"
cd ../engine
docker build -f Dockerfile --tag engine-$1 .

echo "\n####################################Building Cron####################################"
docker build -f Dockerfile_cron --tag cron-$1 .

echo "\n####################################Building Robin API####################################"
cd ../robin_api
docker build -f Dockerfile --tag robin_api-$1 .

echo "\n####################################Building News API####################################"
cd ../news
docker build -f Dockerfile --tag news-$1 .

cd ..
echo "\n####################################Done####################################"