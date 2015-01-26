# use a Ubuntu Trusty base image
FROM ubuntu:14.04
MAINTAINER Stephen Coakley <me@stephencoakley.com>

# install packages for Apache and for compiling PHP
RUN apt-get update && apt-get install -y \
    apache2-mpm-prefork \
    apache2-prefork-dev \
    aufs-tools \
    automake \
    bison \
    btrfs-tools \
    build-essential \
    curl \
    git \
    libbz2-dev \
    libcurl4-openssl-dev \
    libmcrypt-dev \
    libxml2-dev \
    re2c

# get the latest PHP source from master branch
RUN git clone https://github.com/php/php-src.git /usr/local/src/php

# we're going to be working out of the PHP src directory for the compile steps
WORKDIR /usr/local/src/php

# configure the build
RUN PHP_DIRECTORY=/usr/local/php ./buildconf && ./configure --prefix=$PHP_DIRECTORY --with-config-file-path=$PHP_DIRECTORY --with-config-file-scan-dir=$PHP_DIRECTORY/conf.d --with-apxs2=/usr/bin/apxs2 --with-libdir=/lib/x86_64-linux-gnu

# compile and install
RUN make && make install

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# configure Apache for prefork and start server
EXPOSE 80
RUN a2dismod mpm_event && a2enmod mpm_prefork && service apache2 restart

# By default, simply start apache.
CMD /usr/sbin/apache2ctl -D FOREGROUND
