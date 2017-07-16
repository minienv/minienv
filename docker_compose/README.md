Warning: Docker Compose support is experimental and may not run properly!

Note: the very first time you run minienv it will provision at least
one environment and download the container images defined in the MINIENV_PROVISION_IMAGES
variable. This may take a few minutes. You can change these settings in the docker-compose.yml file.

**Known Issue:** You must remove all minienv-provisioner images prior to running docker-compose up:
 
`docker stop $(docker ps -a | grep minienv-provisioner | awk '{print $1}')`

`docker rm $(docker ps -a | grep minienv-provisioner | awk '{print $1}')`

#### Run docker-compose up
`docker-compose up --force-recreate`

#### Point web browser to
http://localhost:31111

### Development
#### To run a specific repo locally without the web/api interface
GIT_REPO=<GIT_REPO> docker-compose -f docker-compose-dev.yml up<br />

Example:<br />
GIT_REPO=https://github.com/markwatsonatx/tutorial-rethinkdb-nodejs-rps docker-compose -f docker-compose-dev.yml up

#### Point web browser to 
Log: http://localhost:30081<br />
Editor: http://localhost:30082<br />
Repo Container Port: http://port-exposed-through-dockercompose.localhost:30083<br />
Example: http://33000.localhost:30083
