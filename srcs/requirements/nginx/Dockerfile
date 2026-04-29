FROM debian:bullseye

RUN apt update && \
    apt install -y nginx openssl

CMD ["nginx", "-g", "daemon off;"]