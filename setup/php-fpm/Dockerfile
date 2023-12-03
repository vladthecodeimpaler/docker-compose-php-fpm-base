FROM php:8.2-fpm
WORKDIR /application

# SETUP ENV ARGS
ARG CUST_USER
ARG LARAVEL_VERSION

RUN apt-get update && apt-get -y --no-install-recommends install \
    git \
    unzip \
&& apt-get clean

# COMPOSER
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
&& php composer-setup.php --install-dir=/usr/local/bin \
&& php -r "unlink('composer-setup.php');"

RUN ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

# PHP EXTENSIONS
RUN pecl install redis-6.0.2 \
    && pecl install xdebug-3.2.2 \
    && docker-php-ext-enable redis xdebug

# SETUP CUSTOM USER, CREATE AND ADD TO ROOT GROUP (to avoid HOST root user file ownership and while keeping root permissions in docker)
# RUN useradd -s /bin/bash ${CUST_USER} -g root
RUN useradd -m $CUST_USER && adduser $CUST_USER root

# SET ACTIVE USER
USER ${CUST_USER}
