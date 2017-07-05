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

### Create npm proxy cache daemonset
kubectl create -f ./daemonset-npm-proxy-cache.yml

### Create API deployment and service
kubectl create -f ./minikube.dev/deployment-api.yml<br />
kubectl create -f ./service-api.yml

### Create web deployment and service
kubectl create -f ./minikube.dev/deployment-web.yml<br />
kubectl create -f ./service-web.yml

### Point web browser to
http://minikube.dev:31111
