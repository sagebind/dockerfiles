FROM sagebind/nginx:latest
MAINTAINER Stephen Coakley <me@stephencoakley.com>

RUN apk --no-cache add \
        php7 \
        php7-ctype \
        php7-dom \
        php7-fpm \
        php7-json \
        php7-mbstring \
        php7-openssl \
        php7-phar \
        php7-posix \
        php7-session \
        php7-simplexml \
        php7-sockets \
        php7-xml \
        php7-xmlreader \
        php7-xmlwriter \
        php7-zlib

COPY root /
