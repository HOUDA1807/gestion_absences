# Image de base avec Docker CLI
FROM docker:24.0.5-cli

# Installer python3, pip, Node.js, npm, Ansible et docker-compose
RUN apk add --no-cache \
      python3 py3-pip nodejs npm openssh-client git \
    && pip3 install --no-cache-dir ansible docker-compose \
    && npm install -g npm@latest

# Répertoire de travail (facultatif)
WORKDIR /workspace
