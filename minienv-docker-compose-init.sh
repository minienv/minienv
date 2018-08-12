#!/bin/bash

docker_compose_path=${1}
echo "$(date) - init docker-compose path = ${docker_compose_path}"

if [[ -z ${MINIENV_PLATFORM} ]]; then
    if [ ! -f ${docker_compose_path} ]; then
        mv /dc/docker-compose.yaml ${docker_compose_path}
    fi
fi