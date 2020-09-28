FROM php:7.4-fpm

COPY ./composer.json ./composer.lock /var/www/html/
COPY ./route /var/www/html/route
COPY ./app /var/www/html/app
COPY ./templates /var/www/html/templates
COPY ./conf/php.ini $PHP_INI_DIR/php.ini
# COPY ./conf/xdebug.ini $PHP_INI_DIR/conf.d/xdebug.ini
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
# RUN pecl install xdebug-2.8.1  \
#      && docker-php-ext-enable xdebug
RUN docker-php-ext-install pdo pdo_mysql
# RUN docker-php-ext-install pdo pdo_mysql \
#     && pecl install xdebug \
#     && docker-php-ext-enable xdebug
WORKDIR /var/www/html/
RUN mkdir -p templates_c cache && chmod -R 777 templates_c cache
# 安装依赖
RUN sed -i 's#http://deb.debian.org#https://mirrors.163.com#g' /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install zip unzip -y \
    && composer config repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && composer install
