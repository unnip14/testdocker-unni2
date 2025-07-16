FROM php:8.2-apache

# Enable Apache Rewrite Module
RUN a2enmod rewrite

# Copy app files
COPY index.php /var/www/html/
