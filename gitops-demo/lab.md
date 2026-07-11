# Concept 1 — Git is Production

Delete deployment:

```
kubectl delete deployment nginx -n demo
```

Watch:

```
kubectl get deployment -n demo -w
```

It comes back.

Why?

Because:

```
Git = desired state
Cluster = actual state

ArgoCD continuously does:

desired != actual ?
      yes
      ↓
reconcile
```

This is the GitOps contract.

***

# Concept 2 — Manual Changes Are Meaningless

Scale deployment:

```
kubectl scale deployment nginx \
--replicas=5 \
-n demo
```

Wait.

ArgoCD changes it back to:

```
replicas: 2
```

because Git says:

```
replicas: 2
```

***

# Concept 3 — Synced vs Healthy

This interview question appears everywhere.

***

## Synced

Means:

```
Git == Cluster
```

***

## Healthy

Means:

```
Application is actually functioning.
```

***

# Example 1

Commit:

```
image: nginx:doesnotexist
```

ArgoCD deploys successfully.

State:

```
Synced
Unhealthy
```

because:

```
Git == cluster
Pods failing
```

***

# Example 2

Manually change replicas:

```
kubectl scale deployment nginx \
--replicas=10
```

State:

```
OutOfSync
Healthy
```

because:

```
Pods work
Git != cluster
```

***

# Concept 4 — Self Heal

Disable autosync first:

```
syncPolicy: {}
```

Now:

```
kubectl scale deployment nginx \
--replicas=10
```

ArgoCD:

```
OutOfSync
```

No correction.

Enable:

```
automated:
  selfHeal: true
```

Repeat.

Deployment returns to desired state.

***

# Concept 5 — Prune

Delete service from git:

```
git rm service.yaml
git commit
git push
```

ArgoCD:

```
Should I delete service from cluster?
```

If:

```
prune: true
```

then:

```
Service removed.
```

If:

```
prune: false
```

service remains.

***

# Concept 6 — Sync Waves

This is huge in production.

Suppose:

```
Namespace
↓
ConfigMap
↓
Database
↓
Application
```

Deployment order matters.

***

## Namespace

```
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "-1"
```

***

## Database

```
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "0"
```

***

## Application

```
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "1"
```

ArgoCD deploys:

```
wave -1
wave 0
wave 1
```

***

# Lab

Break it.

Remove namespace sync wave.

Commit.

App fails.

Understand why ordering matters.

***

# Concept 7 — App of Apps Pattern

Production repos often look like:

```
gitops/
│
├── applications/
│     ├── frontend.yaml
│     ├── backend.yaml
│     ├── monitoring.yaml
│     └── logging.yaml
```

Parent app:

```
kind: Application
```

Children:

```
kind: Application
```

One sync deploys entire platform.

***

# Why Companies Use This

```
cluster bootstrap
↓
install ingress
↓
install monitoring
↓
install apps
↓
install databases
```

Everything from Git.

Entire cluster recreated in minutes.

***

# Concept 8 — Sync Windows

Prevent deployments during business hours.

Example:

```
kind: AppProject
spec:
  syncWindows:
  - kind: deny
    schedule: '0 9 * * 1-5'
    duration: 8h
    applications:
      - '*'
```

Meaning:

```
No auto-sync from
9 AM to 5 PM
Monday-Friday
```

Very common in banks.

***

# Concept 9 — RBAC

Create read-only users.

Example:

```
p, role:readonly, applications, get, *, allow
g, developers, role:readonly
```

Developers:

```
Can see apps
Cannot sync
Cannot delete
Cannot rollback
```
