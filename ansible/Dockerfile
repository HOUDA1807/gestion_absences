FROM ubuntu:20.04

# Mise à jour des paquets et installation de dépendances
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sshpass \
        curl \
        python3-pip \
        python3-apt \
        git && \
    pip cache purge && \  # Ajout de la commande pour purger le cache pip
    pip install --no-cache-dir ansible && \
    apt-get clean
