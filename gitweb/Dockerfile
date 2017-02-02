FROM sagebind/nginx:latest
MAINTAINER Stephen Coakley <me@stephencoakley.com>

RUN apk --no-cache add fcgiwrap git-gitweb highlight perl-cgi perl-cgi-fast perl-fcgi-procmanager

COPY root /

VOLUME /var/git
