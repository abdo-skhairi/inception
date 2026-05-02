FROM debian:bullseye

RUN apt update && \
    apt install -y \
        php \
        php-fpm \
        php-mysql \
        php-curl \
        php-gd \
        php-mbstring \
        php-xml \
        php-zip \
        wget \
        curl \
        default-mysql-client && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' \
        /etc/php/7.4/fpm/pool.d/www.conf

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp

RUN mkdir -p /run/php /var/www/html

COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/init.sh"]