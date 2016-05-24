FROM debian:jessie

RUN \
  apt-get update && \
  apt-get install -y \
  curl \
  wget \
  git

RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
    echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
    wget -O- http://www.dotdeb.org/dotdeb.gpg | apt-key add -

RUN \
  apt-get update && \
  apt-get install -y \
  vim \
  locales \
  iptables \
  php7.0-fpm \
  php7.0-mysql \
  php7.0-gd \
  php7.0-imagick \
  php7.0-xdebug \
  php7.0-dbg \
  php7.0-dev \
  php7.0-curl \
  php7.0-opcache \
  php7.0-cli \
  php7.0-sqlite \
  php7.0-intl \
  php7.0-tidy \
  php7.0-imap \
  php7.0-json \
  php7.0-phpdbg \
  php7.0-pspell \
  php7.0-recode \
  php7.0-common \
  php7.0-sybase \
  php7.0-sqlite3 \
  php7.0-bz2 \
  php7.0-mcrypt \
  php7.0-common \
  php7.0-apcu \
  php7.0-memcached \
  php7.0-redis \
  memcached \
  git


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require hirak/prestissimo

RUN usermod -u 1000 www-data

COPY php.ini    /etc/php/7.0/fpm/conf.d/
COPY php.ini    /etc/php/7.0/cli/conf.d/
COPY www.conf   /etc/php/7.0/fpm/pool.d/
ADD  run.sh /tmp/run.sh

RUN chmod +x /tmp/run.sh

CMD ["bash", "/tmp/run.sh"]
