#!/bin/bash

if [ "$XDEBUG_HOST_IP" ]; then
    echo "xdebug.remote_host=$XDEBUG_HOST_IP" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
    echo "xdebug.remote_enable=on" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
    echo "xdebug.remote_connect_back=1" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
    echo "xdebug.remote_autostart=1" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
    echo "xdebug.auto_trace=1" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
    if [ "$XDEBUG_HOST_PORT" ]; then
        echo "xdebug.remote_port=$XDEBUG_HOST_PORT" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
    else
        echo "xdebug.remote_port=9001" >> /etc/php/7.0/fpm/conf.d/20-xdebug.ini
    fi
else
    apt-get -y remove php7.0-xdebug
fi

if [ "$TIMEZONE" ]; then
    echo "date.timezone = '$TIMEZONE'" >> /etc/php/7.0/fpm/conf.d/php.ini
    echo "date.timezone = '$TIMEZONE'" >> /etc/php/7.0/cli/conf.d/php.ini
else
    echo "date.timezone = 'UTC'" >> /etc/php/7.0/fpm/conf.d/php.ini
    echo "date.timezone = 'UTC'" >> /etc/php/7.0/cli/conf.d/php.ini
fi

/usr/sbin/php-fpm7.0 --allow-to-run-as-root -c /etc/php/7.0/fpm

memcached -u memcache -d -m 30 -l 0.0.0.0 -p 11211

tail -f /var/log/php.log