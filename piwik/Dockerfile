FROM sagebind/php-nginx:latest
MAINTAINER Stephen Coakley <me@stephencoakley.com>

ARG PIWIK_VERSION=2.16.5

RUN apk --no-cache add \
        php7-ctype \
        php7-dom \
        php7-gd \
        php7-iconv \
        php7-pdo_mysql \
        wget && \
    wget -q http://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz && \
    tar -xzf piwik-${PIWIK_VERSION}.tar.gz && \
    rm piwik-${PIWIK_VERSION}.tar.gz && \
    mv piwik/* . && \
    rm -r piwik && \
    wget -q http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz && \
    gunzip GeoLiteCity.dat.gz && \
    mv GeoLiteCity.dat misc/GeoIPCity.dat

COPY root /
