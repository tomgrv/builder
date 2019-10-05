FROM microsoft/dotnet:2.2.2-runtime-alpine3.8

# Install linux dependencies
RUN apk add --no-cache \
    bash \
    curl \
    git \
#   imagemagick \
    nodejs \
    nodejs-npm \
    ca-certificates \
    unzip \
    readline \
    openssh-client

## Install devpmt dependencies
#RUN apk add --no-cache \
#    make \
#    gcc \
#    g++ \
#    libc-dev

# Install php dependencies
RUN apk add --no-cache \
    php7 \
    php7-common \
    php7-openssl \
    php7-apcu \
    php7-json \
    php7-mbstring \
    php7-opcache \
    php7-xml \
    php7-zip \
    php7-phar \
    php7-pear \
    php7-curl \
    php7-iconv \
    php7-mbstring \
    php7-pdo \
    php7-pdo_mysql \
    php7-pdo_pgsql \
    php7-pdo_sqlite \
    php7-pcntl \
    php7-tokenizer \
    php7-xmlwriter \
    php7-simplexml \
    php7-gd \
    php7-fileinfo\
    php7-dom

# Install GitVersion 
RUN wget -O /tmp/GitVersion.nupkg https://www.nuget.org/api/v2/package/GitVersion.CommandLine.DotNetCore/5.0.2-beta1.71 \
    && unzip /tmp/GitVersion.nupkg -d /usr/local/ \
    && ln -s /usr/local/tools/runtimes/alpine-x64/native/libgit2-7ce88e6.so /usr/lib/git2-7ce88e6.so \
    && echo -e '#!/bin/sh\ndotnet /usr/local/tools/GitVersion.dll $*' > /usr/bin/gv \
    && chmod +x /usr/bin/gv

# Install Composer
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="./vendor/bin:$PATH"

## Install pecl packages
#RUN pecl install imagick

# Install pear packages
RUN pear install PHP_CodeSniffer

# Setup working directory
WORKDIR /var/run
