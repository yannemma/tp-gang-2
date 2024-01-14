# Utiliser une image légère d'un serveur web Nginx
FROM nginx:alpine

# Copier le contenu local (le site web) dans le répertoire de travail du serveur web
COPY ./ /usr/share/nginx/html

# Exposer le port 80 pour permettre l'accès au serveur web
EXPOSE 80

# Commande à exécuter lorsque le conteneur démarre
CMD ["nginx", "-g", "daemon off;"]
