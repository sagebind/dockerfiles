FROM sagebind/php-nginx:latest
LABEL maintainer="Stephen Coakley <me@stephencoakley.com>"

ARG VERSION=latest

RUN apk --no-cache add \
        php7-ctype \
        php7-dom \
        php7-gd \
        php7-iconv \
        php7-pdo_mysql \
        php7-simplexml \
        wget && \
    wget -q http://builds.piwik.org/piwik-${VERSION}.tar.gz && \
    tar -xzf piwik-${VERSION}.tar.gz && \
    rm piwik-${VERSION}.tar.gz ./*.html && \
    mv piwik/* . && \
    rm -r piwik && \
    wget -qO - https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz | tar -xzf - && \
    mv GeoLite2-City*/GeoLite2-City.mmdb misc/GeoLite2-City.mmdb && \
    rm -r GeoLite2-City*

COPY root /
