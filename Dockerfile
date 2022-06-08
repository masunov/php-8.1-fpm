FROM php:8.1-fpm

RUN apt-get update && apt-get install -qy \
    git \
    curl \
    wget \
    zip \
    zlib1g-dev \
    libicu-dev \
    libzip-dev \
    libcurl4-openssl-dev \
    libssl-dev libmcrypt-dev \
    libfreetype6-dev \
    libxml2-dev \
    libjpeg62-turbo-dev libpq-dev \
    postgresql-client \
    libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg\
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql pdo_pgsql \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install soap \
    && docker-php-ext-install opcache \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && wget https://getcomposer.org/installer \
    && php installer --install-dir=/usr/local/bin --filename=composer \
    && pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis
EXPOSE 9000

CMD ["php-fpm"]