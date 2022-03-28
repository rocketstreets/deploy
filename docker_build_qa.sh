#!/bin/sh

echo "Building version: "$1
echo "\n####################################Building Webapp####################################"
cd ../webapp
docker build -f Dockerfile --tag webapp-$1 .

echo "\n####################################Building Engine(QA)####################################"
cd ../QA
docker build -f Dockerfile --tag engine-qa-$1 .

echo "\n####################################Done####################################"