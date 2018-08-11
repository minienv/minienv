#!/bin/bash

docker_compose_path=${1}
echo "$(date) - node-alpine docker-compose path = ${docker_compose_path}"

# command
platform_command=""
if [[ -z ${MINIENV_PLATFORM_COMMAND} ]]; then
    if [[ -z ${MINIENV_NPM_PROXY_CACHE} ]]; then
        platform_command="npm install && npm install -g nodemon && nodemon --exec 'npm start'"
    else
        platform_command="npm config set proxy ${MINIENV_NPM_PROXY_CACHE} && npm config set https-proxy ${MINIENV_NPM_PROXY_CACHE} && npm config set strict-ssl false && npm install && npm install -g nodemon && nodemon --exec 'npm start'"
    fi
else
    platform_command="${MINIENV_PLATFORM_COMMAND}"
fi
sed -i -e 's/$command/'"$(echo ${platform_command} | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')"'/g' ${docker_compose_path}