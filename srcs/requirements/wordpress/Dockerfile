FROM debian:bullseye

RUN apt update && \
    apt install -y php php-fpm wget

RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' /etc/php/7.4/fpm/pool.d/www.conf

CMD ["php-fpm7.4", "-F"]