FROM php:7.4-fpm

WORKDIR /var/www/html/
# 复制必要的文件
COPY ./src ./composer.json ./composer.lock ./
COPY ./conf/php.ini $PHP_INI_DIR/php.ini
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
# 安装依赖
RUN docker-php-ext-install pdo pdo_mysql \
    && mkdir -p templates_c cache && chmod -R 777 templates_c cache \
    && sed -i 's#http://deb.debian.org#https://mirrors.163.com#g' /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install zip unzip -y \
    && composer config repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && composer install
