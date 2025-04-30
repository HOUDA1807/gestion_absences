FROM ubuntu:20.04

# Mise à jour des paquets et installation de dépendances
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sshpass \
        curl \
        python3-pip \
        python3-apt \
        git && \
    pip3 cache purge && \  # Utilisation de pip3 pour Python 3
    pip3 install --no-cache-dir ansible && \
    apt-get clean
