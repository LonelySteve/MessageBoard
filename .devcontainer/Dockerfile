FROM php:7.4-fpm

WORKDIR /var/www/html/
# 拷贝必要的文件
COPY ./src ./composer.json ./composer.lock ./
COPY ./conf/php.ini $PHP_INI_DIR/php.ini
COPY ./conf/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
# 安装依赖
RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && docker-php-ext-install pdo pdo_mysql \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && mkdir -p templates_c cache && chmod -R 777 templates_c cache \
    && sed -i 's#http://deb.debian.org#https://mirrors.163.com#g' /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install zip unzip git-all openssh-server -y \
    && composer config repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && composer install
