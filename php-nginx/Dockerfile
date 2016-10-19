FROM sagebind/nginx:latest
MAINTAINER Stephen Coakley <me@stephencoakley.com>

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    apk --no-cache add \
        php7 \
        php7-fpm \
        php7-json \
        php7-mbstring \
        php7-openssl \
        php7-phar \
        php7-posix \
        php7-session \
        php7-sockets \
        php7-zlib

COPY root/ /
