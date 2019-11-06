FROM php:7.3.11-fpm


# 为调试方便添加国内源
RUN echo 'deb http://mirrors.aliyun.com/debian buster main contrib non-free \n\
deb http://mirrors.aliyun.com/debian buster-proposed-updates main contrib non-free \n\
deb http://mirrors.aliyun.com/debian buster-updates main contrib non-free \n\
deb http://mirrors.aliyun.com/debian-security/ buster/updates main non-free contrib' > /etc/apt/sources.list

EXPOSE 80

# 安装基础依赖
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libpq-dev libfreetype6-dev  \
    libwebp-dev libjpeg62-turbo-dev libxpm-dev iputils-ping libmagickwand-dev \
    vim procps nginx \
    && apt-get clean && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 安装php扩展
RUN docker-php-ext-install gd pdo_mysql pdo_pgsql pgsql exif mysqli bcmath \
    && printf "\n" | pecl install redis && docker-php-ext-enable redis \
    && pecl install msgpack && docker-php-ext-enable msgpack \
    && printf "\n" | pecl install swoole && docker-php-ext-enable swoole \
    && pecl install imagick-beta && docker-php-ext-enable imagick \
    && docker-php-ext-configure gd --with-gd --with-webp-dir --with-jpeg-dir \
    --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir \
    && docker-php-ext-install gd 

# 准备依赖文件
COPY php/php.ini /usr/local/etc/php/php.ini
COPY nginx/conf.d /etc/nginx/conf.d
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

# 项目结构在镜像中预设好
RUN mkdir /data && cd /data && mkdir logs \
&& chgrp -R www-data /data && chmod -R g+w /data \
&& ln -s /var/www/html /data/zc8 \
&& chmod a+x /entrypoint.sh

# 启动脚本
CMD [ "/entrypoint.sh" ]

