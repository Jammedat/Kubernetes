# Deploy your first app

## Downloads the following
1. kubectl
2. minikube

## Verify the installation by simply running:
kubectl- for kubectl and minikube for minikube

## Start and configure the minikube:

### If you are on windows run the following commands

```
minikube start --memory=4098 --driver=docker
```

### If you are on mac run the following commands

```
minikube start --memory=4098 --driver=hyperkit
```

### Check the configuration

```
kubectl get nodes
```

### Now install pod by:

1. Creating a yaml files
2. Then run

```
kubectl create -f pod.yml
```
3. Get the information of the pods by running:

```
kubectl get pods -o wide
```
### Then login to the Kubernetes cluster

```
minikube ssh
```

### Execute the pods:

```
curl <ip_address>
```

## Hurray your first app is deployed

For more kubectl commands refer to the:

```
https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/
```

