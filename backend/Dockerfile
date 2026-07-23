# Offizielles Node.js-Image als Basis
FROM node:18-alpine

# Arbeitsverzeichnis im Container festlegen
WORKDIR /app

# Abhängigkeiten kopieren und installieren
COPY package*.json ./
RUN npm install

# Quellcode kopieren
COPY . .

# Port freigeben
EXPOSE 5000

# Anwendung starten
CMD ["node", "server.js"]