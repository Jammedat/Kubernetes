### Secrets can be created as:

```
kubectl create secret generic <secret_file_name> --from-literal=db-port="3302"
```
### You can edit the secret files as:

```
kubectl edit secret <secret_file_name>
```

### It can also be decoded as:

```
echo <encrypted_value> | base64 --decode
```