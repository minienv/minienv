#!/bin/sh
export EXUP_REGISTRY_MIRROR=http://$NODE_NAME:5000
/usr/local/bin/dockerd-entrypoint.sh --storage-driver=$EXUP_STORAGE_DRIVER --registry-mirror=$EXUP_REGISTRY_MIRROR &
docker pull markwatsonatx/exampleup-log:latest
docker pull markwatsonatx/exampleup-editor:latest
docker pull markwatsonatx/exampleup-proxy:latest
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
git clone $EXUP_GIT_REPO /dc
cd /dc
docker-compose up -d --force-recreate
docker run -d -e EXUP_DIR="/dc" -v /var/run/docker.sock:/var/run/docker.sock -v /dc:/dc -p$EXUP_LOG_PORT:8080 markwatsonatx/exampleup-log:latest
docker run -d -e EXUP_DIR="/dc" -v /dc:/dc -p$EXUP_EDITOR_PORT:80 markwatsonatx/exampleup-editor:latest
docker run -d -e EXUP_TARGET_HOST="dind" --add-host=dind:`ip route show | grep docker0 | awk '{print $5}'` -p$EXUP_PROXY_PORT:80 markwatsonatx/exampleup-proxy:latest
while true; do sleep 1000; done
