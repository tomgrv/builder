FROM microsoft/dotnet:2.2.2-runtime-alpine3.8

ARG GITVERSION=5.2.4
ARG DOTNET_FW=netcoreapp2.1

# Install linux dependencies
RUN apk add --no-cache \
    bash \
    git \
    nodejs \
    nodejs-npm \
    ca-certificates \
    openssh-client \
    util-linux

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

# Install Composer
RUN apk add --no-cache \
    composer

# Install GitVersion
RUN wget -O /tmp/GitVersion.nupkg https://www.nuget.org/api/v2/package/GitVersion.Tool/${GITVERSION} \
    && unzip /tmp/GitVersion.nupkg -d /usr/local/ \
    && ln -s /usr/local/tools/${DOTNET_FW}/any/runtimes/alpine-x64/native/libgit2-*.so /usr/lib \
    && rename 'libgit2-' 'git2-' /usr/lib/libgit2-*  \
    && echo -e '#!/bin/sh\ndotnet /usr/local/tools/${DOTNET_FW}/any/gitversion.dll $*' > /usr/bin/gitversion \
    && chmod +x /usr/bin/gitversion

## Install pecl packages
#RUN pecl install imagick

# Install pear packages
RUN pear install PHP_CodeSniffer

# Setup working directory
WORKDIR /var/run
