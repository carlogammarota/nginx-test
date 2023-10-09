# Usa una imagen base de Node.js para construir la aplicación Node
FROM node:18

# Crea un directorio de trabajo para la aplicación Node
WORKDIR /app

# Copia los archivos necesarios al directorio de trabajo
COPY package.json /app/

# Instala las dependencias de la aplicación Node
RUN npm install

# Copia la aplicación Node al directorio de trabajo
COPY . /app

# Exponer el puerto en el que se ejecutará la aplicación Node
EXPOSE 3000

# Inicia la aplicación Node con Express
CMD ["node", "app.js"]


FROM nginx

COPY argentinanoticias.armortemplate.site /etc/nginx/sites-enabled/argentinanoticias.armortemplate.site

# Copia los archivos SSL a la ubicación predeterminada de Nginx
COPY ssl/cert.pem /etc/ssl/cert.pem
COPY ssl/key.pem /etc/ssl/key.pem

# Exponer el puerto 80 de Nginx
EXPOSE 80
# Inicia Nginx
CMD ["nginx", "-g", "daemon off;"]
