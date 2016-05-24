FROM debian:jessie

MAINTAINER Alexandre Moraes <http://github.com/alcmoraes>

RUN apt-get update && apt-get install -y curl php5-common php5-xdebug php5-cli php5-fpm php5-mcrypt php5-mysql php5-apcu php5-gd php5-imagick php5-memcached php5-curl php5-intl memcached

ADD docker.ini /etc/php5/fpm/conf.d/
ADD docker.ini /etc/php5/cli/conf.d/
COPY php.ini /etc/php5/fpm/php.ini 

VOLUME /var/www

ADD run.sh /
RUN chmod +x /run.sh

ADD docker.pool.conf /etc/php5/fpm/pool.d/

RUN usermod -u 1000 www-data

CMD ["/run.sh"]

EXPOSE 9000
