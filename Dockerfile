FROM php:7.4-fpm

WORKDIR /var/www/html/
# 复制必要的文件
COPY ./src ./composer.json ./composer.lock ./
COPY ./conf/php.ini $PHP_INI_DIR/php.ini
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
# 安装依赖
RUN sed -i 's#http://deb.debian.org#https://mirrors.163.com#g' /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && apt-get upgrade -y \
    # https://github.com/docker-library/php/issues/618#issuecomment-379034024
    && apt-get install -y libpq-dev zip unzip \ 
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql \
    && mkdir -p templates_c cache && chmod -R 777 templates_c cache \
    && composer config repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && composer install
