# Usa una imagen base que contiene Node.js y Nginx
FROM node:18

# Crea un directorio de trabajo para la aplicación Node
WORKDIR /app

# Copia los archivos necesarios al directorio de trabajo
COPY package.json /app/
COPY . /app

# Instala las dependencias de la aplicación Node
RUN npm install

# Exponer el puerto en el que se ejecutará la aplicación Node
EXPOSE 8787

# Inicia la aplicación Node con Express (puedes cambiar esto según tu aplicación)
CMD ["node", "app.js"]

# Copia la configuración de Nginx y SSL
COPY argentinanoticias.armortemplate.site /etc/nginx/sites-enabled/argentinanoticias.armortemplate.site
COPY ssl/cert.pem /etc/ssl/cert.pem
COPY ssl/key.pem /etc/ssl/key.pem

# Exponer los puertos 80 y 443 de Nginx
EXPOSE 80
EXPOSE 443

# Inicia Nginx
CMD ["nginx", "-g", "daemon off;"]
