FROM php:7.4-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    git \
    unzip \
    libzip-dev \
    zip \
    && docker-php-ext-install pgsql pdo_pgsql zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Download SuiteCRM
WORKDIR /var/www/html
RUN curl -L https://suitecrm.com/files/162/SuiteCRM-8.4/707/SuiteCRM-8.4.3.zip -o suitecrm.zip \
    && unzip suitecrm.zip && mv SuiteCRM-8.4.3/* . && rm -rf suitecrm.zip SuiteCRM-8.4.3

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Start Apache
CMD ["apache2-foreground"]
