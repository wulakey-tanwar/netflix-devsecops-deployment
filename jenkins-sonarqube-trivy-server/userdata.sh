#!/bin/bash

# install git
sudo apt-get update -y
sudo apt install git -y

# install jenkins
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt install openjdk-19-jre-headless 
sudo apt-get install jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# install docker
sudo apt install docker.io -y
sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker jenkins
sudo chmod 777 /var/run/docker.sock
sudo systemctl enable docker
sudo systemctl start docker

# install trivy
sudo apt-get install wget gnupg
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy


# Run sonarqube image
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community



