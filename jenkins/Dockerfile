ARG JENKINS_VERSION
FROM jenkins/jenkins:${JENKINS_VERSION}
USER root
RUN apt update \
 && apt install -y apt-transport-https ca-certificates curl gnupg lsb-release \
 && mkdir -p /etc/apt/keyrings \
 && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
 && apt update && apt install -y docker-ce-cli \
 && groupadd -g 998 docker && usermod -a -G docker jenkins \
 && apt clean -y
USER jenkins
