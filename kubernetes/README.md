## Running minienv on Kubernetes

To run minienv on Kubernetes you will need to install the following yml files:

1. namespace.yml - This is the namespace minienv will use to launch all environments
2. daemonset-registry.yml - This is a Docker Registry pull through cache for caching docker images used in environments
3. daemonset-npm-proxy-cache.yml - This is a NPM proxy cache for caching npm modules used in environments
4. minikube.dev/deployment-api.yml - This is the minienv API. It contains the logic for provisioning and launching environments. You will need to customize this yml file for your environment. See below for more details.
5. service-api.yml - This expose the minienv API on a NodePort, by default port 31112
6. minikube.dev/deployment-web.yml - This is the minienv web application
7. service-web.yml - This expose the minienv web application on a NodePort, by default port 31111

### Custom Configuration

All of the yml files can be used as-is except the deployment-api.yml file. There are changes you will need to make
before deploying this file to your Kubernetes environment.

#### `MINIENV_NODE_HOST_NAME`

You must set up a DNS server to point to one of the nodes in your cluster. Accessing via an IP
address will not work. To use the root domain (i.e. mydomain.com) do the following:

1. Create an `A` record with a name of `@` and a value of one of your node IP addresses.

To use a subdomain (i.e. minienv.mydomain.com):

1. Create an `A` record with a name of your subdomain (i.e. `minienv`) and a value of one of your node IP addresses.
2. Create a second `A` record with a name of your *.subdomain (i.e. `*.minienv`) and the same value as the previous record.

After configuring your DNS change the `MINIENV_NODE_HOST_NAME` value in your deployment-api.yml file to your domain name
(i.e. mydomain.com or minienv.mydomain.com).

#### `MINIENV_ALLOW_ORIGIN`

After you have configured DNS and set up your `MINIENV_NODE_HOST_NAME` be sure to update the `MINIENV_ALLOW_ORIGIN` value.
This should be set to `http://` + `MINIENV_NODE_HOST_NAME` + `:31111`. For example:

`http://minienv.mydomain.com:31111`

Other values may need to be changed based on where and how you are running Kubernetes. See below for more details:

### Running on a Multi-Node Cluster
 
Use the deployment-api.yml file in template/multi-node-storage-class as a guide for configuring minienv to run in a multi-node cluster.
You may need to change the following:

1. `MINIENV_VOLUME_STORAGE_CLASS` - Find the persistent volume storage classes available in your environment and set this to the storage class you would like to use.  

### Running on a Single Node Cluster
 
Use the deployment-api.yml file in template/single-node-host-path as a guide for configuring minienv to run in a multi-node cluster.

### Examples

See the examples folder for examples running minienv in Bluemix and Google Container Engine.

### Running in Minikube

Minikube support is still in progress. These instructions may or may not work. Since minienv requires a domain name you must
configure a DNS server on your local machine. Here are instructions for Mac:

#### Configure DNS
On Mac follow the instructions for setting up Local DNS at  http://fullybaked.co.uk/articles/setting-up-a-local-dns-server-on-osx<br />
Add the following entry to /usr/local/etc/dnsmasq.conf:<br />
`address=/minikube.dev/192.168.99.100`

#### Start Minikube
minikube start

#### Point web browser to
http://minikube.dev:31111
