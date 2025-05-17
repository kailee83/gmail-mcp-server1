FROM node:20-slim

# Crée le dossier de travail
WORKDIR /app

# Affiche le contenu du dossier (pour debug - optionnel)
RUN ls -la /app

# Copie les fichiers de dépendances
COPY package.json package-lock.json* ./

# Vérifie que les fichiers ont bien été copiés (pour debug - optionnel)
RUN ls -la /app

# Installe les dépendances
RUN npm ci

# Copie les autres fichiers nécessaires
COPY tsconfig.json ./
COPY src ./src
COPY gcp-oauth.keys.json ./gcp-oauth.keys.json

# Compile le projet TypeScript
RUN npm run build

# (Optionnel) Crée un dossier pour les credentials
RUN mkdir -p /gmail-server

# Variables d'environnement
ENV NODE_ENV=production

# Port exposé pour Render
EXPOSE 3000

# Commande de démarrage
CMD ["node", "dist/index.js"]



