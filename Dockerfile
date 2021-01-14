FROM ubuntu:18.04

ENV LANG C.UTF-8

ENV DEBIAN_FRONTEN noninteractive

RUN apt update && apt-get -y install tzdata && apt -y install software-properties-common && add-apt-repository -y ppa:ondrej/php && apt update && apt -y install supervisor php7.0 php7.0-cli php7.0-bcmath php7.0-bz2 php7.0-dom php7.0-sqlite3 php7.0-xml php7.0-xmlrpc php7.0-xsl php7.0-common php7.0-curl php7.0-fpm php7.0-gd php7.0-imagick php7.0-imap php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-redis php7.0-soap php7.0-zip && \
    sed -i -e "s/short_open_tag = Off/short_open_tag = On/g" /etc/php/7.0/cli/php.ini && \
    sed -i -e "s/max_execution_time = 30/max_execution_time = 300/g" /etc/php/7.0/cli/php.ini && \
    sed -i -e "s/error_reporting = E_ALL \& \~E_DEPRECATED \& \~E_STRICT/error_reporting = E_ALL \& \~E_NOTICE/g" /etc/php/7.0/cli/php.ini && \
    sed -i -e "s/post_max_size = 8M/post_max_size = 50M/g" /etc/php/7.0/cli/php.ini && \
    sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/g" /etc/php/7.0/cli/php.ini && \
    sed -i -e "s/upload_max_filesize = 2M/upload_max_filesize = 100M/g" /etc/php/7.0/cli/php.ini && \
    sed -i -e "s/max_file_uploads = 20/max_file_uploads = 200/g" /etc/php/7.0/cli/php.ini && \
    sed -i -e "s/;date.timezone =/date.timezone = PRC/g" /etc/php/7.0/cli/php.ini && \
    sed -i -e "s/session.gc_probability = 0/session.gc_probability = 1/g" /etc/php/7.0/cli/php.ini && \
    sed -i -e "s/session.gc_maxlifetime = 1440/session.gc_maxlifetime = 86400/g" /etc/php/7.0/cli/php.ini && \
    sed -i -e "s/;curl.cainfo =/curl.cainfo = \/etc\/pki\/tls\/certs\/ca-bundle.crt/g" /etc/php/7.0/cli/php.ini && \
    sed -i -e "s/;openssl.cafile=/openssl.cafile=\/etc\/pki\/tls\/certs\/ca-bundle.crt/g" /etc/php/7.0/cli/php.ini && \
    sed -i -e "s/short_open_tag = Off/short_open_tag = On/g" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/max_execution_time = 30/max_execution_time = 300/g" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/memory_limit = 128M/memory_limit = 2000M/g" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/error_reporting = E_ALL \& \~E_DEPRECATED \& \~E_STRICT/error_reporting = E_ALL \& \~E_NOTICE/g" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/post_max_size = 8M/post_max_size = 50M/g" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/g" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/upload_max_filesize = 2M/upload_max_filesize = 100M/g" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/max_file_uploads = 20/max_file_uploads = 200/g" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/;date.timezone =/date.timezone = PRC/g" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/session.gc_probability = 0/session.gc_probability = 1/g" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/session.gc_maxlifetime = 1440/session.gc_maxlifetime = 86400/g" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/;curl.cainfo =/curl.cainfo = \/etc\/pki\/tls\/certs\/ca-bundle.crt/g" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/;openssl.cafile=/openssl.cafile=\/etc\/pki\/tls\/certs\/ca-bundle.crt/g" /etc/php/7.0/fpm/php.ini && \
    mkdir /run/php /logs && apt-get remove --purge -y software-properties-common python-software-properties && \
    apt-get autoremove -y && apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000

COPY php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start-container /usr/local/bin/start-container
RUN chmod +x /usr/local/bin/start-container

ENTRYPOINT ["start-container"]
