FROM ubuntu:20.04

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt update && DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata && apt -y install software-properties-common && add-apt-repository -y ppa:ondrej/php && apt update && apt -y install supervisor php7.0 php7.0-cli php7.0-bcmath php7.0-bz2 php7.0-dom php7.0-sqlite3 php7.0-xml php7.0-xmlrpc php7.0-xsl php7.0-common php7.0-curl php7.0-fpm php7.0-gd php7.0-imagick php7.0-imap php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-redis php7.0-soap php7.0-zip && mkdir /run/php && apt-get remove --purge -y software-properties-common python-software-properties && apt-get autoremove -y && apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf

EXPOSE 9000

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start-container /usr/local/bin/start-container
RUN chmod +x /usr/local/bin/start-container

ENTRYPOINT ["start-container"]
