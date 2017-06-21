export EXUP_LOG_PORT=30081
export EXUP_EDITOR_PORT=30082
export EXUP_PROXY_PORT=30083
docker-compose -f ./dc/docker-compose.yml -f ./docker-compose.yml up
