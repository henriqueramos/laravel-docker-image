###
# Apache and PHP
#
# Repository: PHP
# Image: Apache
# Version: 7.3.14
# Strategy: PHP From PHP-Alpine Repository
# Base distro: php:7.3.14-alpine3.11
#
FROM php:7.3.14-alpine3.11

# Repository/Image Maintainer
LABEL maintainer="Henrique Ramos <henrique@henriqueramos.eti.br>"

LABEL com.custom_httpd.version="1.0"
LABEL com.custom_httpd.release-date="2020-01-28"

RUN set -x && \
    apk update && \
    apk add openssl && \
    apk add bash && \
    apk add libintl && \
    apk add --virtual build_deps gettext &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

RUN docker-php-ext-install pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Application directory
WORKDIR "/var/www/html"

# Expose webserver port
EXPOSE 80