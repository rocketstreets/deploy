curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
git clone https://github.com/rocketstreets/deploy.git
cd deploy
sh docker_deploy.sh