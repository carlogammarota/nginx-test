#!/bin/sh

# Copiar la configuración de Nginx y los archivos SSL
# cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
# cp ./nginx.conf /etc/nginx/nginx.conf
# cp -r ./ssl/* /etc/nginx/ssl/

# Copiar el sitio web al directorio de sitios habilitados
cp subdominioprobando.armortemplate.site /etc/nginx/sites-enabled/

# Iniciar Nginx en segundo plano
nginx -g "daemon off;"
