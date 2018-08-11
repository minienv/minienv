#!/bin/bash

docker_compose_path=${1}
echo "$(date) - node-8-yarn docker-compose path = ${docker_compose_path}"

# command
platform_command=""
if [[ -z ${MINIENV_PLATFORM_COMMAND} ]]; then
    platform_command="yarn && yarn global add nodemon && nodemon --exec 'yarn start'"
else
    platform_command="${MINIENV_PLATFORM_COMMAND}"
fi
sed -i -e 's/$command/'"$(echo ${platform_command} | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')"'/g' ${docker_compose_path}