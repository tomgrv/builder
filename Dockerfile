FROM microsoft/dotnet:2.2.104-sdk-alpine3.8

# Install linux dependencies
RUN apk add --no-cache \
    bash \
    git \
    nodejs \
    nodejs-npm \
    ca-certificates \
    openssh-client

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
RUN dotnet tool install --global --no-cache gitversion.tool
ENV PATH="~/.dotnet/tools:${PATH}"

## Install pecl packages
#RUN pecl install imagick

# Install pear packages
RUN pear install PHP_CodeSniffer

# Setup working directory
WORKDIR /var/run
