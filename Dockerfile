ROM php:7.0.33-fpm-alpine3.7
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update && apk add --no-cache shadow libpng gettext libintl icu-libs libmcrypt lib
xslt libgomp libstdc++ libgcc && apk add --no-cache --virtual .build-dependencies pkgconf libpng-dev gettext-dev icu-dev libmcrypt-dev libxml2-dev libxslt-dev m4 libbz2
perl gmp isl binutils-libs binutils make re2c gcc g++ file musl-dev libc-dev libatomic mpfr3 mpc1 libmagic autoconf dpkg-dev dpkg && docker-php-ext-install bcmath calend
ar exif gd gettext intl mcrypt shmop soap wddx pcntl sockets sysvmsg sysvsem sysvshm xsl zip opcache pdo_mysql mysqli && apk del .build-dependencies && rm -rf /var/cache
/* && rm -rf /root/.cache && rm -rf /root/.ash_history && usermod -u 1033 www-data && groupmod -g 1033 www-data
COPY --chown=www-data:www-data . /var/www/html
USER www-data