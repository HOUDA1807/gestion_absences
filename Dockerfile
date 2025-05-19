# Utilise une image Python officielle légère
FROM python:3.11-slim

# Installer wget, unzip, et les dépendances pour Chrome et ChromeDriver
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    gnupg \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Installer Chrome stable
RUN curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Installer ChromeDriver (version compatible avec Chrome)
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` \
    && wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip \
    && unzip /tmp/chromedriver.zip -d /usr/local/bin/ \
    && rm /tmp/chromedriver.zip \
    && chmod +x /usr/local/bin/chromedriver

# Copier les fichiers requirements.txt (optionnel)
COPY requirements.txt .

# Installer selenium
RUN pip install --no-cache-dir -r requirements.txt

# Copier tout le dossier de l’application/tests
COPY . /app

# Se positionner dans /app
WORKDIR /app

# Variable d'environnement pour Chrome en mode headless
ENV CHROME_BIN=/usr/bin/google-chrome
ENV DISPLAY=:99

# Lancer le test automatiquement
CMD ["python3", "tests/test_google.py"]
