#!/bin/bash

# Start Docker
storage_driver=${MINIENV_STORAGE_DRIVER}
if [[ -z  ${storage_driver} ]]; then
    storage_driver="vfs"
fi
npm_proxy_cache=""
registry_mirror=""
if [[ ! -z ${MINIENV_NODE_NAME_OVERRIDE} ]]; then
    npm_proxy_cache=http://${MINIENV_NODE_NAME_OVERRIDE}:5001
    export MINIENV_NPM_PROXY_CACHE=http://${MINIENV_NODE_NAME_OVERRIDE}:5001
    registry_mirror="http://${MINIENV_NODE_NAME_OVERRIDE}:5000"
    /usr/local/bin/dockerd-entrypoint.sh --storage-driver=${storage_driver} --registry-mirror=${registry_mirror} &
elif [[ ! -z ${NODE_NAME} ]]; then
    npm_proxy_cache=http://${NODE_NAME}:5001
    export MINIENV_NPM_PROXY_CACHE=http://${NODE_NAME}:5001
    registry_mirror="http://${NODE_NAME}:5000"
    /usr/local/bin/dockerd-entrypoint.sh --storage-driver=${storage_driver} --registry-mirror=${registry_mirror} &
else
    /usr/local/bin/dockerd-entrypoint.sh --storage-driver=${storage_driver} &
fi
echo "$(date) - Storage Driver = ${storage_driver}"
echo "$(date) - NPM Proxy Cache = ${npm_proxy_cache}"
echo "$(date) - Registry Mirror = ${registry_mirror}"


# Wait for Docker to start
docker info > /dev/null 2>&1
code=$?
while [ ${code} -gt 0 ]; do
    echo "$(date) - Docker exited with code $code. Waiting for docker to start..."
    sleep 3
    docker info > /dev/null 2>&1
    code=$?
done

# Stop all containers
docker stop $(docker ps -aq)

# Remove all containers
docker rm $(docker ps -aq)

# Clone repo
rm -rf /dc
if [[ -z ${MINIENV_GIT_BRANCH} ]]; then
    git clone --single-branch ${MINIENV_GIT_REPO} --depth 1 /dc
else
    git clone -b ${MINIENV_GIT_BRANCH} --single-branch ${MINIENV_GIT_REPO} --depth 1 /dc
fi
docker_compose_path="/dc/docker-compose.yml"
if [[ -z ${MINIENV_PLATFORM} ]]; then
    if [ ! -f ${docker_compose_path} ]; then
        mv /dc/docker-compose.yaml ${docker_compose_path}
    fi
else
    echo "$(date) - Using built-in template ${MINIENV_PLATFORM}..."
    cp /platforms/${MINIENV_PLATFORM}/docker-compose.yml ${docker_compose_path}
    sed -i -e 's,$port,'${MINIENV_PLATFORM_PORT}',g' ${docker_compose_path}
    bash /platforms/${MINIENV_PLATFORM}/config.sh  ${docker_compose_path}
fi
echo "$(date) - docker-compose path = ${docker_compose_path}"
echo "$(date) - Getting DIND_IP_ADDRESS..."
export DIND_IP_ADDRESS="$(ip route show | grep docker0 | awk '{print $NF}')"
if [[ -z ${DIND_IP_ADDRESS} ]]; then
    echo "$(date) - Unable to obtain DIND_IP_ADDRESS from ip route, using default..."
    export DIND_IP_ADDRESS="172.17.0.1"
fi
echo "$(date) - DIND_IP_ADDRESS = $DIND_IP_ADDRESS"
version=$(sed -n "s/^.*version.*\:.*\([0-9]\).*$/\1/p" ${docker_compose_path})
mv ./minienv-docker-compose-v${version}.yml ./minienv-docker-compose.yml
docker-compose -f ${docker_compose_path}  -f ./minienv-docker-compose.yml up --force-recreate