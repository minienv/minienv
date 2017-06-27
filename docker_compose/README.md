### Run docker-compose up
docker-compose up

### Point web browser to
http://localhost:31111

## Development
### To run a specific repo locally without the web/api interface
cd dev<br />
GIT_REPO=<GIT_REPO> docker-compose -f docker-compose-dev.yml up<br />

Example:<br />
GIT_REPO=https://github.com/markwatsonatx/tutorial-rethinkdb-nodejs-rps docker-compose -f docker-compose-dev.yml up

### Point web browser to 
Log: http://localhost:30081<br />
Editor: http://localhost:30082<br />
Repo Container Port: http://port-exposed-through-dockercompose.localhost:30083<br />
Example: http://33000.localhost:30083
