FROM php:7.1-fpm-alpine

MAINTAINER Mudkip "<i@mudkip.me>"

RUN apk update && apk add --update nginx libpng-dev libjpeg-turbo-dev libmcrypt-dev sqlite-dev libxml2-dev
RUN docker-php-ext-install bcmath exif gd \
                           iconv mcrypt \
                           mysqli pdo_mysql \
                           pdo_sqlite soap \
                           sockets xmlrpc

COPY php.ini /usr/local/etc/php/

VOLUME ["/home/plaza"]
