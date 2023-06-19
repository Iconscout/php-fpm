ARG PHP_VERSION=7.2
ARG SERVER_TYPE=fpm-alpine

FROM php:${PHP_VERSION}-${SERVER_TYPE}

# INSTALL SOME SYSTEM PACKAGES.
RUN apk --update --no-cache add ca-certificates \
    curl \
    wget \
    # Required for Healthcheck
    fcgi \
    bash

# INSTALL COMPOSER.
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Install php-extension-installer.
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN IPE_GD_WITHOUTAVIF=1 install-php-extensions \
    pdo_mysql \
    exif \
    pcntl \
    opcache \
    grpc \
    # Required for PHP Excel
    gd \
    zip

# EXPOSE PORTS!
EXPOSE 9000
