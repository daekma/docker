FROM php:7.4-apache

RUN apt-get update

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer

RUN apt-get install -y git autotools-dev automake autoconf libtool
RUN apt-get install -y iputils-ping
RUN apt-get install -y ffmpeg

RUN apt-get install -y --no-install-recommends \
    zlib1g-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libwebp-dev

RUN apt-get install -y x265 \
    && cd /usr/local/src \
    && git clone https://github.com/strukturag/libde265.git \
    && cd libde265 \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf libde265

RUN cd /usr/local/src \
    && git clone https://github.com/strukturag/libheif.git \
    && cd libheif \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    && cd .. \
    && rm -rf libheif

RUN cd /usr/local/src \
    && git clone https://github.com/ImageMagick/ImageMagick.git \
    && cd ImageMagick \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf ImageMagick

RUN apt-get install -y libmagick++-dev --no-install-recommends \
    && cd /usr/local/src \
    && git clone https://github.com/mkoppanen/imagick.git \
    && cd imagick \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && docker-php-ext-enable imagick \
    && cd ../ \
    && rm -rf imagick

RUN docker-php-ext-configure gd --enable-gd \
    --with-jpeg=/usr/include/ \
    --with-freetype=/usr/include/ \
    --with-webp=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install exif
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pcntl
RUN apt-get install -y libzip-dev
RUN docker-php-ext-install zip

RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN apt-get install -y unixodbc-dev
RUN pecl install sqlsrv pdo_sqlsrv
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN pecl install redis
RUN docker-php-ext-enable redis

RUN apt-get install -y libzip-dev
RUN docker-php-ext-install zip

RUN docker-php-ext-install opcache

RUN pecl install apcu
RUN docker-php-ext-enable apcu

RUN docker-php-ext-install pcntl

RUN docker-php-ext-install intl

RUN npm -g install npm \
    && npm cache clean --force

RUN rm -f /tmp/.apt-update \
    && apt-get autoremove -y -f \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && find /tmp/ /var/log/ -mindepth 1 -delete \
    && rm -rf /root/.cache

RUN a2enmod rewrite
RUN a2enmod headers

WORKDIR /var/www

COPY 7.4/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
