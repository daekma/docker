FROM php:7-apache

RUN apt-get update

RUN apt-get -y install git autotools-dev automake autoconf libtool

RUN apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libwebp-dev
RUN docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-webp-dir=/usr/include/ \
    && docker-php-ext-install gd
RUN docker-php-ext-install exif
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pcntl
RUN apt-get install -y libzip-dev \
    && docker-php-ext-install zip

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN apt-get install -y ffmpeg

RUN apt-get -y install x265 \
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

RUN apt-get install -y iputils-ping

RUN apt-get install -y unzip

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN a2enmod rewrite \
    && a2enmod headers

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]