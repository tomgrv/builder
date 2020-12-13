# Image args
ARG DOTNET_VERSION=2.1

# Image
FROM mcr.microsoft.com/dotnet/core/sdk:$DOTNET_VERSION-alpine

# Tools args
ARG GITTOOL_VERSION=5.5.1
ARG PHPUNIT_VERSION=8

# Install linux dependencies
RUN apk add --no-cache \
    bash \
    git \
    rsync \
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
    php7-dom \
    php7-session \
    php7-bcmath \
    php7-ctype

# Install Composer
RUN apk add --no-cache \
    composer

# Install Developpent tools
#RUN apk add --no-cache \
#    python \
#    make \
#    g++

# Install GitVersion
RUN dotnet tool install -g --version "${GITTOOL_VERSION}" gitversion.tool \
    && /root/.dotnet/tools/dotnet-gitversion /version

ENV PATH="${PATH}:/root/.dotnet/tools"

## Install PHPUnit
RUN wget -O /usr/bin/phpunit "https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar" \
    && chmod +x /usr/bin/phpunit  \
    && phpunit --version

# Install pear packages
RUN pear install PHP_CodeSniffer \
    && phpcs --version

# Setup working directory
WORKDIR /var/run
