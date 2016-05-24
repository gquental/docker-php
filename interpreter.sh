#!/usr/bin/env bash

# Run PHP through Docker
docker run -i --rm -v "${PWD}":"${PWD}" -v /tmp/:/tmp/ -w ${PWD} --net=host --sig-proxy=true --pid=host php:7.0 php "$@"
