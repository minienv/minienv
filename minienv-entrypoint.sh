#!/bin/sh

# Start Docker
storage_driver=${MINIENV_STORAGE_DRIVER}
if [[ -z  ${storage_driver} ]]; then
    storage_driver="vfs"
fi
if [[ ! -z ${NODE_NAME} ]]; then
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
export DIND_IP_ADDRESS="$(ip route show | grep docker0 | awk '{print $5}')"
version=$(sed -n "s/^.*version.*\:.*\([0-9]\).*$/\1/p" /dc/docker-compose.yml)
mv ./minienv-docker-compose-v${version}.yml ./minienv-docker-compose.yml
docker-compose -f ./dc/docker-compose.yml -f ./minienv-docker-compose.yml up --force-recreate
