FROM php:8.2-apache

# Instalar dependências
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf && \
    apt-get update && \
    apt-get install -y libicu-dev default-mysql-client git unzip && \
    docker-php-ext-install intl pdo pdo_mysql mysqli && \
    a2enmod rewrite

# Configurar Apache - DocumentRoot em /var/www/html
RUN cat > /etc/apache2/sites-available/000-default.conf <<'EOL'
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html
    ServerName localhost

    <Directory /var/www/html>
        Options +Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    <Directory /var/www/html/src>
        Options +Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

# Copiar TODO o conteúdo de src para /var/www/html/src
COPY ./src /var/www/html/src

# Criar pasta writable se não existir
RUN mkdir -p /var/www/html/src/writable/cache \
             /var/www/html/src/writable/logs \
             /var/www/html/src/writable/session \
             /var/www/html/src/writable/uploads \
             /var/www/html/src/writable/debugbar

# Ajustar permissões
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chmod -R 777 /var/www/html/src/writable

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalar dependências do CodeIgniter
WORKDIR /var/www/html/src
RUN if [ -f "composer.json" ]; then \
        composer install --no-dev --optimize-autoloader --no-interaction; \
    fi

EXPOSE 80

CMD ["apache2-foreground"]