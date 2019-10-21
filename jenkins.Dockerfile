FROM jenkins/jenkins:lts

# Enable root user to do our magic
USER root

# https://medium.com/@manav503/how-to-build-docker-images-inside-a-jenkins-container-d59944102f30
RUN apt-get update -qq \
   && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common zip \
   && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
   && add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable" \
   && apt-get update  -qq \
   && apt-get install docker-ce awscli jq expect -y \
   && usermod -aG docker jenkins

# drop back to the regular jenkins user - good practice
USER jenkins
