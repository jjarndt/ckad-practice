Create this first:

```bash
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: web
    tier: frontend
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
        tier: frontend
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: busybox-deployment
  labels:
    app: utils
    tier: backend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: busybox
  template:
    metadata:
      labels:
        app: busybox
        tier: backend
    spec:
      containers:
      - name: busybox
        image: busybox
        command: ["sleep", "3600"]
EOF
```

### Task 1:

Update the label of the `nginx-deployment` pods from `tier=frontend` to `tier=web`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=tier=web
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods -l app=nginx tier=web --overwrite
```
</details>

### Task 2:

Remove the `tier` label from the `busybox-deployment` pods.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=tier=backend
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods -l app=busybox tier-
```
</details>

Sure, here is the corrected solution in English:

### Task 3:

Create a new label `environment=production` for the `nginx-deployment` pods and modify the label `app` to `application`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=environment=production
kubectl get pods --selector=application=nginx
```

<details>
<summary>Solution</summary>

```bash
# Step 1: Add the label environment=production to all pods with the label app=nginx
kubectl label pods -l app=nginx environment=production

# Step 2: Remove the label app from these pods
kubectl label pods -l app=nginx app-

# Step 3: Add the label application=nginx to all pods with the label environment=production
kubectl label pods -l environment=production application=nginx
```


### Explanation:

- **Step 1:** Adds the label `environment=production` to all pods that currently have the label `app=nginx`.
- **Step 2:** Removes the `app` label from these pods.
- **Step 3:** Adds the label `application=nginx` to all pods that have the label `environment=production`.

By following these steps, you ensure that all pods that originally had the label `app=nginx` now have the labels `environment=production` and `application=nginx`.
</details>

### Task 4:

Use set-based and equality-based selectors to list the `nginx-deployment` pods with `environment=production` and `application` in (`nginx`, `busybox`).

<details>
<summary>Solution</summary>

```bash
kubectl get pods --selector='environment=production,application in (nginx,busybox)'
```
</details>

### Task 5:

Demonstrate the application of labels and selectors in practice by creating a Service that selects the `nginx-deployment` pods.
Service name: `nginx-service`

The solution can be checked with the following kubectl command:
```bash
kubectl get svc nginx-service -o jsonpath='{.spec.selector}'
```

<details>
<summary>Solution</summary>

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    application: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
```
Apply this configuration:
```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    application: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
EOF
```
</details>

### Task 6:

Label the nodes with a well-known label `disktype=ssd` and taint them with `key=value:NoSchedule`.

The solution can be checked with the following kubectl commands:
```bash
kubectl get nodes --selector=disktype=ssd
kubectl describe nodes | grep Taints
```

<details>
<summary>Solution</summary>

```bash
# Label the nodes
kubectl label nodes <node-name> disktype=ssd
# Taint the nodes
kubectl taint nodes <node-name> key=value:NoSchedule
```
</details>

### Task 7:

Add a new label `stage=testing` to the `busybox-deployment` pods.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=stage=testing
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods -l app=busybox stage=testing
```
</details>

### Task 8:

Change the label `app` of `nginx-deployment` pods to `role=webserver`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=role=webserver
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods -l app=nginx role=webserver
kubectl label pods -l role=webserver app-
```
</details>

### Task 9:

Remove the `environment` label from all pods in the `nginx-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=environment=production
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods -l application=nginx environment-
```
</details>

### Task 10:

Create a label `version=v1` for all `busybox-deployment` pods and modify the label `tier` to `component`.

The solution can be checked with the following kubectl commands:
```bash
kubectl get pods --selector=version=v1
kubectl get pods --selector=component=backend
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods -l app=busybox version=v1
kubectl label pods -l app=busybox tier-
kubectl label pods -l version=v1 component=backend
```
</details>

### Task 11:

List all `nginx-deployment` pods that do not have the label `stage`.

<details>
<summary>Solution</summary>

```bash
kubectl get pods --selector='application=nginx,!stage'
```
</details>

### Task 12:

Add a label `maintainer=devops` to all pods in the namespace `default`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=maintainer=devops
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods --all maintainer=devops
```
</details>

### Task 13:

Remove the label `role` from all pods with the value `webserver`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=role=webserver --show-labels
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods -l role=webserver role-
```
</details>

### Task 14:

Label the `nginx-deployment` pods with `department=IT` and `project=website`.

The solution can be checked with the following kubectl commands:
```bash
kubectl get pods --selector=department=IT
kubectl get pods --selector=project=website
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods -l application=nginx department=IT
kubectl label pods -l application=nginx project=website
```
</details>

### Task 15:

Update the label on the `nginx-deployment` pods with `priority=high`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=priority=high
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods -l application=nginx priority=high
```
</details>

### Task 16:

Update all pods in the `default` namespace with the label `env=dev`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=env=dev
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods --all env=dev
```
</details>

### Task 17:

Update the label `stage` on the `busybox-deployment` pods to `status=active`, but only if the resource version is `1`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=status=active
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods -l app=busybox stage=status=active --resource-version=1
```
</details>

### Task 18:

Remove the label `project` from all `nginx-deployment` pods.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=project=website
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods -l application=nginx project-
```
</details>

### Task 19:

Update the label `app` on all pods in the `default` namespace with a DNS subdomain prefix, such as `example.com/app=frontend`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=example.com/app=frontend
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods --all example.com/app=frontend
```
</details>

### Task 20:

Overwrite the label `department` on the `nginx-deployment` pods with `division=IT`, ensuring the existing resource version is used.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=division=IT
```

<details>
<summary>Solution</summary>

```bash
kubectl label --overwrite pods -l application=nginx department=division=IT
```
</details>

### Task 21:

Remove the label `maintainer` from all pods, if it exists.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=maintainer=devops
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods --all maintainer-
```
</details>

### Task 22:

Update the `nginx-deployment` pods with a label `version` having a value that includes underscores, such as `version=1_0`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=version=1_0
```

<details>
<summary>Solution</summary>

```bash
# Step 1: Label the existing pods and overwrite if necessary
kubectl label pods -l application=nginx version=1_0 --overwrite

# Step 2: Verify that the pods have the correct label
kubectl get pods --selector=version=1_0

# Step 3: Patch the deployment to add the version label to new pods
kubectl patch deployment nginx-deployment -p '{"spec":{"template":{"metadata":{"labels":{"version":"1_0"}}}}}'
```
</details>

### Task 23:

Update the label `priority` on `busybox-deployment` pods to `importance=critical`, ensuring it conforms to the maximum 63 characters limit.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=importance=critical
```

<details>
<summary>Solution</summary>

```bash
kubectl label --overwrite pods -l app=busybox priority=importance=critical
```
</details>
