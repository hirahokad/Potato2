# Potato 2 - Final Project: Kubernetes
Senior Design Final Project: Kubernetes on EC2 Instances


## Tools/technology being used
- Kubernetes
- Kops
- Docker
- AWS
- Git
- Nginx

## Current Status of Project
Using AWS S3 buckets we create configuration files that we will need to create the cluster. After creating the cluster we are able to install the dashboard and use the external ip to connect to it.

After the cluster is able to display Nginx after running a deployment and creating a container that holds Nginx inside.

I wanted to be able to run a MEAN stack originally but then a LAMP stack but wasn't able to get the pods running correctly. I would be able to create all the pods but some of them weren't able to successfully create the containers.

Using **kops** and **kubectl** I was able to create the cluster and run an Nginx container as well as the Front end of the Guestbook.

~~Docker-compose is being setup so I can see if everything runs correctly using our Frontend and Backend.~~

~~After setting up Docker compose I'll be running each Docker file on it's own to create different containers for each service.~~

~~I will then call those containers using Kubectl to be part of my Cluster that I'm running in Minikube.~~

~~The pod should then be running the containers needed for the MEAN stack and with a proper configuration file should communicate with each other. The diagram gives an idea of what that should look like.~~


## How to Execute Code
The main directory that I worked in was:
```
Potato2/Daniel/PodLamp/
```
#### Kubernetes Cluster Setup
Since we are using kops we need to create a bucket that can keep track of the kubernetes cluster state and the configuration:
```
aws s3api create-bucket --bucket name-kops-state-store --region us-east-1
```
replacing "name" in the "-kops-state-store" you can name the bucket whatever you wanted

To enable versioning on the bucket so you're able to go back and forth to different states:
```
aws s3api put-bucket-versioning --bucket name-kops-state-store --versioning-configuration Status=Enabled
```

There are 2 scripts in here that we are going to run to setup our Kubernetes Cluster
```
clustersetup.sh
clusterpostsetup.sh
```
###### clustersetup.sh
```
#! /bin/bash
KOPS_CLUSTER_NAME=" "
KOPS_STATE_STORE=" "

kops create cluster --node-count=2 --node-size=t2.micro --zones=us-east-1a
kops update cluster --name ${KOPS_CLUSTER_NAME} --yes
```
The first two lines create environmental variables that kops will use.

**kops create cluster:** will create two nodes which can be editted in the "node-count" flag that are t2.micro in the availability zone declared. If you look on AWS you will see the EC2 node instances.

**kops update cluster:** will update the clusters name with the one you declared


#### Kubernetes Cluster Setup

###### clusterpostsetup.sh
```
#! /bin/bash
# Displays nodes of the Cluster
kubectl get nodes

# Creates Dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

# Gives cluster info 
kubectl cluster-info

# For Dashboard access
kops get secrets kube --type secret -oplaintext
kops get secrets admin --type secret -oplaintext
```
**kubectl get nodes:** displays some information of your nodes and lists them

**kubectl apply:** will create the the dashboard for your kubernetes cluster

**kubectl cluster-info:** displays information of the cluster, such as IP

The secret section will be needed when you try to login to the Dashboard. The kube secret is the password for the admin login and the admin secret is the token needed for the dashboard


#### NGINX Setup on the Master Node
I wasn't able to setup my deployment without being having to be inside the Master node. Otherwise after exposing it I wasn't able to access using it the external IP

So we need to SSH into the master node. Go to the AWS EC2 and copy the Public IP that is associated to the Master Node
```
ssh -i ~/.ssh/id_rsa admin@123.456.789
```
Replacing the IP with the IP that is associated with the Master Node

After connecting we can check to see if we are in the Master Node
```
kubectl get svc
```
This command should work and you'll be able to see that the IP is local host.

Open another Terminal that is on your machine and we will want to copy some files over to the Master node.
```
scp -i ~/.ssh/id_rsa test-nginx.yaml admin@123.456.789/home/admin/
```
This should copy the file from your local machine to the master node.

Back to the SSH terminal we will activate the deployment
```
kubectl apply -f test-nginx.yaml
```

To see the deployments that we have just created
```
kubectl get deployments
```

We then want to expose the service
```
kubectl expose nginx-deployment --port=80 --type=LoadBalancer
```

After exposing wait around 80 seconds and then we should see the welcome page for NGINX on the External IP we saw before.


#### The Frontend Guestbook
While in the SSH session you should delete the service and the deployment
```
kubectl delete deployment nginx-deployment
kubectl delete svc nginx-depoyment
```
Then exit the session, the NGINX site should go down

Run the Script:
```
GuestBookSetup.sh
```

###### GuestBookSetup.sh
```
#! /bin/bash

kubectl apply -f https://raw.githubusercontent.com/kubernetes/examples/master/guestbook-go/redis-master-controller.json

kubectl apply -f https://raw.githubusercontent.com/kubernetes/examples/master/guestbook-go/redis-master-service.json

kubectl apply -f https://raw.githubusercontent.com/kubernetes/examples/master/guestbook-go/redis-slave-controller.json

kubectl apply -f https://raw.githubusercontent.com/kubernetes/examples/master/guestbook-go/redis-slave-service.json

kubectl apply -f https://raw.githubusercontent.com/kubernetes/examples/master/guestbook-go/guestbook-controller.json

kubectl apply -f https://raw.githubusercontent.com/kubernetes/examples/master/guestbook-go/guestbook-service.json

kubectl get services -o wide
```
These commands with the exception of the last one will create the different containers needed to run the guestbook. You should see the output say that it has created each one.

The final line will show you the services that are on the cluster.

After get your External IP and connect to it. It might take 80 seconds for it to be setup and show.
```
kubectl get svc
```

#### Finished? Or messed up?
When finished or if you want to start over you can just delete the cluster and start from scratch by first running this command:
```
kops delete cluster --name ${KOPS_CLUSTER_NAME} --yes
```
**KOPS_CLUSTER_NAME:** being the name of the cluster.
This will delete the cluster and you can start from the part where you ran the first script.





## FAQ - Potential or known issues related to the setup or execution of code





## Diagram of MEAN Stack Kubernetes Cluster
![Image of Kubernetes Cluster](https://imgur.com/1e8zpgd.png)

