# Stage 1: Build
FROM node:18-alpine AS build

WORKDIR /app

# Copier les fichiers package et installer les dépendances
COPY package.json package-lock.json ./
RUN npm ci

# Copier tout le reste du projet et construire
COPY . .
RUN npm run build

# Stage 2: Serve
FROM nginx:alpine

# Copier le build de React vers Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Commande pour lancer Nginx
CMD ["nginx", "-g", "daemon off;"]
