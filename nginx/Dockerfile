FROM sagebind/base:latest
MAINTAINER Stephen Coakley <me@stephencoakley.com>

RUN apk --no-cache add nginx && \
    mv /var/lib/nginx/html /var/www

COPY root /

EXPOSE 80 443
