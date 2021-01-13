FROM php:7.0.33-fpm-alpine3.7
RUN apk update && apk add --no-cache shadow c-client libpng gettext freetype expat libssl1.0 libcrypto1.0 libblkid libuuid libfdisk libmount libverto libldap libsasl db libjpeg-turbo imagemagick-libs libintl icu-libs libmcrypt libxslt libgomp libstdc++ libgcc libbz2 file isl libatomic libmagic binutils-libs binutils && apk add --no-cache --virtual .build-dependencies gmp mpfr3 mpc1 pkgconf libpng-dev gettext-dev icu-dev libmcrypt-dev libxml2-dev libxslt-dev musl-dev libc-dev dpkg-dev dpkg autoconf m4  perl make re2c gcc g++ imap-dev openssl-dev krb5-dev freetype-dev libpng-dev libjpeg-turbo-dev imagemagick-dev && docker-php-ext-configure imap --with-kerberos --with-imap-ssl && docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && yes '' | pecl install imagick && docker-php-ext-install bcmath calendar exif gd gettext intl mcrypt shmop soap wddx pcntl sockets sysvmsg sysvsem sysvshm xsl zip opcache pdo_mysql mysqli iconv imap xmlrpc && docker-php-ext-enable imagick && apk del .build-dependencies && chmod -R 777 /usr/bin && chmod -R 777 /usr/lib && chmod -R 755 /usr/local/lib/php/extensions/ && rm -rf /tmp/* /var/cache/* /root/.cache && rm -rf /root/.ash_history && usermod -u 1033 www-data && groupmod -g 1033 www-data && chown -R www-data:www-data /var/www/html && mkdir -p /etc/pki/tls/certs/ && chown -R www-data:www-data /etc/pki/ && mkdir /logs && chmod 777 /logs && chmod 777 /run
COPY --chown=www-data:www-data ./cacert.pem /etc/pki/tls/certs/ca-bundle.crt
COPY --chown=www-data:www-data ./php.ini /usr/local/etc/php/php.ini
USER www-data
