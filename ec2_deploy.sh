#!/bin/sh

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
git clone https://github.com/rocketstreets/deploy.git
cd deploy
export DOCKER_USER=$DOCKER_USER
export DOCKER_PWD=$DOCKER_PWD
export SMTP_PWD=$SMTP_PWD
sh docker_deploy_qa.sh v0.0.0
