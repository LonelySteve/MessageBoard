FROM php:7.4-fpm

WORKDIR /var/www/html/
# 拷贝必要的文件
COPY ./composer.json ./composer.lock ./
COPY ./conf/php.ini $PHP_INI_DIR/php.ini
COPY ./conf/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
# 安装依赖
RUN sed -i 's#http://deb.debian.org#https://mirrors.163.com#g' /etc/apt/sources.list \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && apt-get clean \
    && apt-get update \
    && apt-get upgrade -y \
    # https://github.com/docker-library/php/issues/618#issuecomment-379034024
    && apt-get install -y libpq-dev zip unzip git-all openssh-server \ 
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql
RUN pecl channel-update pecl.php.net && pecl install http://pecl.php.net/get/xdebug-2.9.8.tgz
RUN docker-php-ext-enable xdebug \
    && mkdir -p templates_c cache && chmod -R 777 templates_c cache \
    && composer config repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && composer install
