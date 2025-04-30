FROM python:3.11-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sshpass \
        curl \
        python3-pip \
        python3-apt \
        git && \
    pip install --no-cache-dir ansible && \
    apt-get clean

WORKDIR /ansible
