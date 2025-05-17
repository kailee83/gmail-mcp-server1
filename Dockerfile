FROM node:20-slim

# Crée le dossier de travail
WORKDIR /app

# Copie les fichiers de dépendances
COPY package.json package-lock.json* ./

# Crée un tsconfig.json avec les paramètres corrects
RUN echo '{\
  "compilerOptions": {\
    "target": "ES2015",\
    "module": "commonjs",\
    "lib": ["ES2015", "DOM"],\
    "declaration": true,\
    "outDir": "./dist",\
    "strict": true,\
    "esModuleInterop": true,\
    "skipLibCheck": true,\
    "forceConsistentCasingInFileNames": true\
  },\
  "include": ["src/**/*"],\
  "exclude": ["node_modules", "dist"]\
}' > tsconfig.json

# Copie les fichiers source
COPY src ./src

# Installe les dépendances
RUN npm ci

# Copie les fichiers de configuration
COPY gcp-oauth.keys.json ./gcp-oauth.keys.json

# Crée le dossier pour les credentials
RUN mkdir -p /gmail-server
COPY credentials.json /gmail-server/credentials.json

# Compile le projet TypeScript
RUN npm run build

# Variables d'environnement
ENV NODE_ENV=production

# Port exposé pour Render
EXPOSE 3000

# Commande de démarrage
CMD ["node", "dist/index.js"]