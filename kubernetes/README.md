### Configure DNS
On Mac follow the instructions for setting up Local DNS at  http://fullybaked.co.uk/articles/setting-up-a-local-dns-server-on-osx<br />
Add the following entry to /usr/local/etc/dnsmasq.conf:<br />
`address=/minikube.dev/192.168.99.100`

### Start minikube
minikube start

### Create namespace
kubectl create -f ./namespace.yml

### Create registry daemonset
kubectl create -f ./daemonset-registry.yml

### Create API deployment and service
kubectl create -f ./minikube.dev/deployment-api.yml<br />
kubectl create -f ./service-api.yml

### Create web deployment and service
kubectl create -f ./minikube.dev/deployment-web.yml<br />
kubectl create -f ./service-web.yml

### Run a single deployment & service at runtime for each user/docker-compose sample
kubectl create -f ./examples/deployment-example-1.yml --namespace=minienv<br />
kubectl create -f ./examples/service-example-1.yml --namespace=minienv

### Point web browser to
http://minikube.dev:31111
