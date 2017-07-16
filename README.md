### What is minienv?
minienv is a web application and collection of backend services that allow you to quickly spin up Docker Compose environments
in the cloud that you can access from your web browser.

minienv also includes an online editor that allows you to edit source code or data files included in your Docker Compose
environments. This helps make minienv a great tool for learning (or teaching) new programming languages, databases, and
other technologies right from your browser.

### Why was minienv created?
minienv was created to help make it easier to deliver sample applications and developer tutorials that connect to databases
and other backend services. If you want to learn javascript and frontend web development there are a lot of really great
web-based tools available, like CodePen and JSFiddle, but what if you want to learn how to connect a Node.js application
with MongoDB, or a Jupyter notebook with Apache Spark? With minienv users get their own mini Docker Compose environments
where they can experiment with just about any technology, as long as it can run in a container.

### Watch the Video
Watch this video for an overview on how minienv works:<br />
[https://youtu.be/PtvYWO_5pFk](https://youtu.be/PtvYWO_5pFk)

### How do I set up minienv?
minienv runs inside Kubernetes as a set of Daemon Sets and Deployments (Docker Swarm support in development).
You can find instructions for setting up minienv in your own Kubernetes cluster [here](https://github.com/minienv/minienv/tree/master/kubernetes).

Also, you can watch this video for an overview on how minienv runs in Kubernetes:<br />
[https://youtu.be/uVQZPdleE1o](https://youtu.be/uVQZPdleE1o)

### Can I try it out?
You can try minienv at [http://bx.minienv.com:31111](http://bx.minienv.com:31111) or [http://gke.minienv.com:31111](http://gke.minienv.com:31111). The former is running on a free
single-node Kubernetes cluster in the Bluemix Container Service and can run up to 4 environments (instances of a sample applications).
The latter is running on a 2-node cluster on Google Container Engine (g1-small) and can run up to 6 environments.
When you run minienv you specify the number of environments you want to provision.
In these cases I am running on fairly lightweight hardware, so I’ve only provisioned minienv to run a handful of environments.

Please note: Since only a limited number of environments are available it is possible that they may all be used up
and you will not be able to try out minienv. Please let me know if you encounter any issues. You can also watch the videos
below to see minienv in action.
