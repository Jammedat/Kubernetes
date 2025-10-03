### Create a namespace named dev and deploy a POD within it. Name the pod dev-nginx-pod and use the nginx image with the latest tag. Ensure to specify the tag as nginx:latest.

1. **Create a namespace**

```bash
kubectl create namespace dev
```
or simply create a config for namespace and create as:

`kubectl create namespace <filename>`

2. **Verify the namespace**

```bash
kubectl get namespaces
```

3. **Deploy the Pod into that namespace** (apply your Pod YAML with namespace defined)

```bash
kubectl apply -f pod.yaml -n dev
```

4. **Verify the Pod is created**

```bash
kubectl get pods -n dev
```

