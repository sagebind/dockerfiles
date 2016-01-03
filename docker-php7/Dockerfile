# Use the latest Ubuntu base image
FROM ubuntu:latest
MAINTAINER Stephen Coakley <me@stephencoakley.com>

# Silence debconf's endless prattle
ENV DEBIAN_FRONTEND noninteractive

# Install and set up packages we will need to compile PHP
RUN apt-get update && apt-get install -y \
    apache2-mpm-prefork \
    apache2-prefork-dev \
    aufs-tools \
    automake \
    btrfs-tools \
    build-essential \
    curl \
    enchant \
    git \
    libbz2-dev \
    libcurl4-openssl-dev \
    libedit-dev \
    libenchant-dev \
    libfreetype6-dev \
    libgmp-dev \
    libicu-dev \
    libjpeg8-dev \
    libmcrypt-dev \
    libpng12-dev \
    libpspell-dev \
    libreadline-dev \
    libsnmp-dev \
    libssl-dev \
    libt1-dev \
    libtidy-dev \
    libvpx-dev \
    libxml2-dev \
    libxslt1-dev \
    mcrypt \
    re2c && \
    ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h
RUN curl -O http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb && \
    curl -O http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb && \
    dpkg -i libbison-dev_2.7.1.dfsg-1_amd64.deb && \
    dpkg -i bison_2.7.1.dfsg-1_amd64.deb && \
    apt-mark hold libbison-dev && apt-mark hold bison

# Clone the PHP source repository
RUN git clone https://github.com/php/php-src.git /usr/local/src/php

# Compile PHP7 right now to bootstrap everything else
RUN cd /usr/local/src/php && ./buildconf && ./configure \
    --prefix=/usr/local/php70 \
    --with-config-file-path=/usr/local/php70 \
    --with-config-file-scan-dir=/usr/local/php70/conf.d \
    --with-apxs2=/usr/bin/apxs2 \
    --with-libdir=/lib/x86_64-linux-gnu \
    --enable-fpm \
    --without-pear \
    --with-openssl \
    --with-curl && \
    make && make install

# Set up Rasmus's handy PHP scripts
COPY makephp /usr/bin/makephp
COPY newphp /usr/bin/newphp
RUN chmod +x /usr/bin/makephp /usr/bin/newphp

# set up Apache environment variables
ENV APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_LOCK_DIR=/var/lock/apache2 \
    APACHE_PID_FILE=/var/run/apache2.pid

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# configure Apache for prefork and start server
RUN a2dismod mpm_event && a2enmod mpm_prefork && service apache2 restart
EXPOSE 80

# Reconfigure the installed PHP version
RUN /usr/bin/newphp 7

# Set up composer variables
ENV COMPOSER_BINARY=/usr/local/bin/composer \
    COMPOSER_HOME=/usr/local/composer
ENV PATH $PATH:$COMPOSER_HOME

# Install composer system-wide
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar $COMPOSER_BINARY && \
    chmod +x $COMPOSER_BINARY

# Set up global composer path
RUN mkdir $COMPOSER_HOME && chmod a+rw $COMPOSER_HOME

# start httpd
RUN service apache2 start

CMD /bin/bash
