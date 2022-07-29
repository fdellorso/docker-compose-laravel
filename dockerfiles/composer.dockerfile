# FROM composer:2
FROM php:7.4-fpm-alpine

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

WORKDIR /var/www/html

# MacOS staff group's gid is 20, so is the dialout group in alpine linux. We're not using it, let's just remove it.
RUN delgroup dialout

RUN addgroup -g ${GID} --system laravel
RUN adduser -G laravel --system -D -s /bin/sh -u ${UID} laravel

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
