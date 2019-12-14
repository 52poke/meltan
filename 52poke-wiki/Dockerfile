FROM php:7.4-fpm

RUN apt-get update && apt-get install -y git supervisor zip imagemagick nginx \
    libpng-dev libsqlite3-dev libxml2-dev libjpeg62-turbo-dev libfreetype6-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install bcmath exif gd \
    iconv \
    mysqli pdo_mysql \
    pdo_sqlite soap \
    sockets xmlrpc pcntl

RUN echo '' | pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

COPY nginx.conf /etc/nginx/nginx.conf
COPY php.ini /usr/local/etc/php/
COPY supervisord.conf /etc/supervisord.conf

RUN mkdir -p /home/52poke \
    && cd /home/52poke \
    && git clone --recurse-submodules -b 52w https://github.com/mudkipme/mediawiki.git wiki

RUN curl https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && cd /home/52poke/wiki/extensions/Elastica && composer install --no-dev \
    && cd /home/52poke/wiki/extensions/CirrusSearch && composer install --no-dev \
    && cd /home/52poke/wiki/extensions/AWS && composer install --no-dev \
    && cd /home/52poke/wiki/extensions/EventBus && composer install --no-dev

RUN chown -R www-data:www-data /home/52poke/wiki

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
