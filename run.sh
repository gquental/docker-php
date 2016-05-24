#!/bin/bash

# Set X-Debug remote host
if [ "$XDEBUG_HOST_IP" ]; then
    echo "xdebug.remote_host=$XDEBUG_HOST_IP" >> /etc/php5/fpm/conf.d/20-xdebug.ini
    echo "xdebug.remote_enable=1" >> /etc/php5/fpm/conf.d/20-xdebug.ini
    echo "xdebug.remote_handler=dbgp" >> /etc/php5/fpm/conf.d/20-xdebug.ini
    echo "xdebug.remote_autostart=1" >> /etc/php5/fpm/conf.d/20-xdebug.ini
    if [ "$XDEBUG_HOST_PORT" ]; then
        echo "xdebug.remote_port=$XDEBUG_HOST_PORT" >> /etc/php5/fpm/conf.d/20-xdebug.ini
    else
        echo "xdebug.remote_port=9001" >> /etc/php5/fpm/conf.d/20-xdebug.ini
    fi
else
    apt-get -y remove php5-xdebug
fi

if [ "$TIMEZONE" ]; then
    echo "date.timezone = '$TIMEZONE'" > /etc/php5/fpm/conf.d/docker.ini
    echo "date.timezone = '$TIMEZONE'" > /etc/php5/cli/conf.d/docker.ini
fi

# Restart PHP FPM
echo "Starting PHP5-FPM..."
service php5-fpm restart

echo "Starting memcached..."
memcached -u memcache -d -m 30 -l 0.0.0.0 -p 11211

# Attach a tail -f for docker persistance
tail -f /var/log/php5-fpm.log
