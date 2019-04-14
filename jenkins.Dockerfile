FROM jenkins/jenkins:lts

# Enable root user to do our magic
USER root

# https://medium.com/@manav503/how-to-build-docker-images-inside-a-jenkins-container-d59944102f30
USER root
RUN apt-get update -qq \
   && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
   && apt-get install docker-ce awscli -y
RUN usermod -aG docker jenkins

# drop back to the regular jenkins user - good practice
USER jenkins1