# Utilise une image de base contenant Python 3
FROM python:3.11-slim

# Mise à jour des paquets, installation de dépendances, et installation d'Ansible
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sshpass \
        curl \
        git && \
    pip3 install --no-cache-dir ansible && \
    apt-get clean
