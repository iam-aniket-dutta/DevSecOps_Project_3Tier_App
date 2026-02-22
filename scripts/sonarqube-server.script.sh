# Update dependancies..
sudo apt-get update -y
# Install docker
sudo apt install docker.io -y
# Add permission for running docker commands
sudo chmod 666 /var/run/docker.sock
# Run sonar qube as a docker container..
docker run -d -p 9000:9000 --name sonarqube sonarqube:lts-community
