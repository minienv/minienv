#!/bin/sh

# Start Docker
storage_driver=${MINIENV_STORAGE_DRIVER}
if [[ -z  ${storage_driver} ]]; then
    storage_driver="vfs"
fi
if [[ ! -z ${MINIENV_NODE_NAME_OVERRIDE} ]]; then
    export MINIENV_NPM_PROXY_CACHE=http://$MINIENV_NODE_NAME_OVERRIDE:5001
    registryMirror="http://$MINIENV_NODE_NAME_OVERRIDE:5000"
    /usr/local/bin/dockerd-entrypoint.sh --storage-driver=${storage_driver} --registry-mirror=${registryMirror} &
elif [[ ! -z ${NODE_NAME} ]]; then
    export MINIENV_NPM_PROXY_CACHE=http://$NODE_NAME:5001
    registryMirror="http://$NODE_NAME:5000"
    /usr/local/bin/dockerd-entrypoint.sh --storage-driver=${storage_driver} --registry-mirror=${registryMirror} &
else
    /usr/local/bin/dockerd-entrypoint.sh --storage-driver=${storage_driver} &
fi

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
git clone ${MINIENV_GIT_REPO} /dc
if [ ! -f /dc/docker-compose.yml ]; then
    if [ -f /dc/docker-compose.yaml ]; then
        mv /dc/docker-compose.yaml /dc/docker-compose.yml
    fi
fi
echo "$(date) - Getting DIND_IP_ADDRESS..."
export DIND_IP_ADDRESS="$(ip route show | grep docker0 | awk '{print $NF}')"
if [[ -z ${DIND_IP_ADDRESS} ]]; then
    echo "$(date) - Unable to obtain DIND_IP_ADDRESS from ip route, using default..."
    export DIND_IP_ADDRESS="172.17.0.1"
fi
echo "$(date) - DIND_IP_ADDRESS = $DIND_IP_ADDRESS"
version=$(sed -n "s/^.*version.*\:.*\([0-9]\).*$/\1/p" /dc/docker-compose.yml)
mv ./minienv-docker-compose-v${version}.yml ./minienv-docker-compose.yml
docker-compose -f ./dc/docker-compose.yml -f ./minienv-docker-compose.yml up --force-recreate
