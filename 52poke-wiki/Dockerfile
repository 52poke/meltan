FROM php:stretch

RUN apt-get update && apt-get install -y apt-transport-https software-properties-common \
    gnupg git supervisor zip imagemagick \
    libpng-dev libsqlite3-dev libxml2-dev libjpeg62-turbo-dev libfreetype6-dev

RUN curl https://nginx.org/keys/nginx_signing.key | apt-key add - \
    && add-apt-repository https://nginx.org/packages/debian \
    && apt-get update && apt-get install -y nginx

RUN curl https://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add - \
    && add-apt-repository 'deb https://dl.hhvm.com/debian stretch-lts-3.24 main' \
    && apt-get update && apt-get install -y hhvm

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install bcmath exif gd \
    iconv \
    mysqli pdo_mysql \
    pdo_sqlite soap \
    sockets xmlrpc pcntl

RUN pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

COPY nginx.conf /etc/nginx/nginx.conf
COPY php.ini /usr/local/etc/php/
COPY hhvm.ini /etc/hhvm/hhvm.ini
COPY supervisord.conf /etc/supervisord.conf

RUN mkdir -p /home/52poke \
    && cd /home/52poke \
    && git clone --recurse-submodules -b 52w https://github.com/mudkipme/mediawiki.git wiki

RUN curl https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && cd /home/52poke/wiki/extensions/Elastica && composer install --no-dev \
    && cd /home/52poke/wiki/extensions/CirrusSearch && composer install --no-dev \
    && cd /home/52poke/wiki/extensions/AWS && composer install --no-dev \
    && cd /home/52poke/wiki/extensions/EventBus && composer install --no-dev

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
