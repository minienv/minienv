Warning: Docker Swarm support is experimental and may not run properly!

**Important: Currently Docker Swarm can only run on a single node.**

Note: the very first time you run minienv it will provision at least
one environment and download the container images defined in the MINIENV_PROVISION_IMAGES
variable. This may take a few minutes. You can change these settings in the docker-compose.yml file.

#### Init or join a swarm
docker swarm init

#### Deploy the stack
docker stack deploy -c localhost/docker-stack.yml minienv-stack

#### Point web browser to
http://localhost:31111

