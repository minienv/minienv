#!/bin/sh
/usr/local/bin/dockerd-entrypoint.sh --registry-mirror=$EXUP_REGISTRY_MIRROR &
git clone $EXUP_GIT_REPO /dc
cd /dc
docker-compose up -d
docker run -d -e EXUP_DIR="/dc" -v /dc:/dc -p$EXUP_EDITOR_PORT:80 markwatsonatx/exampleup-editor:latest
docker run -d -e EXUP_TARGET_HOST="dind" --add-host=dind:`ip route show | grep docker0 | awk '{print $5}'` -p$EXUP_PROXY_PORT:80 markwatsonatx/exampleup-proxy:latest
while true; do sleep 1000; done
