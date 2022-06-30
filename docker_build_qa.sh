#!/bin/sh

echo "Building version: "$1
echo "\n####################################Building Webapp####################################"
cd ../webapp
docker build -f Dockerfile --tag webapp-qa-$1 .

#echo "\n####################################Building Webapp_v2####################################"
#cd ../webapp_v2
#docker build -f Dockerfile --tag webapp_v2-qa-$1 .

echo "\n####################################Building Engine####################################"
cd ../engine
docker build -f Dockerfile --tag engine-qa-$1 .

echo "\n####################################Building Cron####################################"
docker build -f Dockerfile_cron --tag cron-qa-$1 .

echo "\n####################################Building Notify####################################"
cd notification
docker build -f Dockerfile --tag notify-qa-$1 .

echo "\n####################################Building Robin API(QA)####################################"
cd ../../robinhood_faker
docker build -f Dockerfile --tag robin_api-qa-$1 .

echo "\n####################################Building News API####################################"
cd ../news
docker build -f Dockerfile --tag news-qa-$1 .

cd ..
echo "\n####################################Done####################################"
