FROM sagebind/nginx:latest
MAINTAINER Stephen Coakley <me@stephencoakley.com>

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    apk --no-cache add php7 php7-fpm

COPY root /
