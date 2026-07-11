# Configure infra via terraform 

```
terraform init
terraform plan
terraform apply -auto-approve
```

# Then access the vm and do the following:

# Create Cluster

```
kind create cluster --name argocd-lab
```

***

# Install ArgoCD
```
kubectl create ns argocd

kubectl apply --server-side -n argocd \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

```

# Expose ArgoCD with NodePort:

```
kubectl patch svc argocd-server \
-n argocd \
-p '{"spec":{"type":"NodePort"}}'
```

Get port:

```
kubectl get svc -n argocd
```

Port forwarding

```
kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd `<nodeport>`:443 &
```

Then browse:

```
https://<vm-public-ip>:<nodeport>
```

# Get Admin Password

```
kubectl get secret argocd-initial-admin-secret \
-n argocd \
-o jsonpath="{.data.password}" | base64 -d
```

Login:

```
Username: admin
Password: <output>
```
