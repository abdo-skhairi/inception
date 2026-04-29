FROM debian:bullseye

RUN apt update && apt install -y mariadb-server
ENTRYPOINT ["/init.sh"]

COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 3306
