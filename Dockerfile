# Utilise une image officielle Node.js
FROM node:18-alpine

# Crée et utilise le répertoire de travail
WORKDIR /app

# Copie les fichiers package.json et package-lock.json
COPY app/package*.json ./

# Installe les dépendances
RUN npm install --production

# Copie le reste de l'application
COPY app/ .

# Expose le port 8080
EXPOSE 8080

# Commande de démarrage de l'application
CMD ["npm", "start"]
