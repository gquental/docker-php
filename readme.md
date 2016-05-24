# PHP 7.0

## Mounting

To mount this image, execute the following command inside this folder:

    docker build -t php:7.0 .

## Serving

Just execute the following command line to execute ```php:7.0``` image

    docker run --name php7 -v /path/to/your/www:/var/www -d php:7.0

## Xdebug

In order to make Xdebug work properly, set ```XDEBUG_HOST_IP``` ```ENV``` on ```run```, like this:

    docker run --name php7 -p 9000:9000 -e XDEBUG_HOST_IP=YOUR_LOCAL_IP -v /path/to/your/www:/var/www -d php:7.0  

Where **YOUR_LOCAL_IP** should be replaced by your local network IP (e.g. 192.168.1.28)

By default, Xdebug is set-up to send data through port ```9001```.
You can change it by setting also a ```XDEBUG_HOST_PORT``` ```ENV``` on ```run``` command.

After that, you can configure Xdebug on your IDE.

## Using it with compose

    php:
        image: php:7.0
        environment:
            XDEBUG_HOST_IP: YOUR_LOCAL_IP
            XDEBUG_HOST_PORT: 9001
        ports:
            - 9000:9000
        volumes:
            - /path/to/your/www:/var/www

## Interpreter

You may want to use this PHP container as an interpreter for other programs (like PHPStorm).

To do so, use the ```interpreter.sh``` file inside this folder. (Use it like an alias for the "php" command)

    bash interpreter.sh -v

It will echo the PHP version because it's the same as ```php -v```

## Logging

You can follow ```php:7.0``` container log by executing:

    docker logs -f php7
