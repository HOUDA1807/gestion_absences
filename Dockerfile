FROM jenkins/jenkins:lts

# Installer Docker dans le conteneur
USER root
RUN apt-get update && apt-get install -y \
    docker.io \
    && apt-get clean

# Revenir à l'utilisateur Jenkins
USER jenkins