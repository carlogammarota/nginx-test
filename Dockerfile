# Usa la imagen oficial de Nginx como base
FROM nginx

# Copia tu archivo de configuración nginx.conf al contenedor
# COPY nginx.conf /etc/nginx/nginx.conf

# Copia los archivos SSL a la ubicación predeterminada de Nginx
COPY ssl/cert.pem /etc/ssl/cert.pem
COPY ssl/key.pem /etc/ssl/key.pem

# Copia el script de inicio personalizado
# COPY docker-entrypoint.sh /docker-entrypoint.sh

# Cambia los permisos para que el script sea ejecutable
# RUN chmod +x /docker-entrypoint.sh

COPY argentinanoticias.armortemplate.site /etc/nginx/sites-enabled/argentinanoticias.armortemplate.site
# COPY index.html /var/www/argentinanoticias.armortemplate.site/index.html
# Exponer el puerto 80 y 443 para Nginx
EXPOSE 80
EXPOSE 443

# Comando para iniciar Nginx en segundo plano usando el script personalizado
# CMD ["/docker-entrypoint.sh"]

