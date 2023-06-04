FROM php:5-fpm-alpine

RUN apk update && apk add --update --no-cache libpng-dev libjpeg-turbo-dev \
    libmcrypt-dev sqlite-dev libxml2-dev nginx supervisor
RUN docker-php-ext-install bcmath exif gd \
    iconv mcrypt mysql \
    mysqli pdo_mysql \
    pdo_sqlite soap \
    sockets xmlrpc
RUN mkdir -p /run/nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY php.ini /usr/local/etc/php/
COPY supervisord.conf /etc/supervisord.conf

EXPOSE 80
VOLUME ["/var/www/html"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]