# Init or join a swarm
docker swarm init

# Start the registry, API, and web
docker stack deploy -c localhost/docker-stack.yml minienv-stack

# Point web browser to
http://localhost:31111

