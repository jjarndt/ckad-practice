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
kubectl label pods -l app=nginx environment=production
kubectl label pods -l app=nginx app-
kubectl label pods -l environment=production application=nginx
```
</details>

### Task 4:

Apply a constraint to the `nginx-deployment` pods to ensure the label keys conform to DNS subdomain names and values contain only lowercase letters, digits, and `-` or `.` characters.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=application=nginx
```

<details>
<summary>Solution</summary>

```yaml
# Edit the pod template of the deployment
kubectl edit deployment nginx-deployment
```
Ensure the labels are compliant with the constraints:
```yaml
metadata:
  labels:
    application: nginx
    environment: production
```
</details>

### Task 5:

Use set-based and equality-based selectors to list the `nginx-deployment` pods with `environment=production` and `application` in (`nginx`, `busybox`).

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=environment=production,application in (nginx,busybox)
```

<details>
<summary>Solution</summary>

```bash
kubectl get pods --selector=environment=production,application in (nginx,busybox)
```
</details>

### Task 6:

Demonstrate the application of labels and selectors in practice by creating a Service that selects the `nginx-deployment` pods.

The solution can be checked with the following kubectl command:
```bash
kubectl get svc --selector=application=nginx
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

### Task 7:

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

### Task 8:

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

### Task 9:

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

### Task 10:

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

### Task 11:

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

### Task 12:

List all `nginx-deployment` pods that do not have the label `stage`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=application=nginx,!stage
```

<details>
<summary>Solution</summary>

```bash
kubectl get pods --selector=application=nginx,!stage
```
</details>

### Task 13:

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

### Task 14:

Remove the label `role` from all pods with the value `webserver`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=role=webserver
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods -l role=webserver role-
```
</details>

### Task 15:

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

### Task 16:

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

### Task 17:

Overwrite the label `component` on the `busybox-deployment` pods to `module=core`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=module=core
```

<details>
<summary>Solution</summary>

```bash
kubectl label --overwrite pods -l component=backend component=module=core
```
</details>

### Task 18:

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

### Task 19:

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

### Task 20:

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

### Task 21:

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

### Task 22:

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

### Task 23:

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

### Task 24:

Update the `nginx-deployment` pods with a label `version` having a value that includes underscores, such as `version=1_0`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=version=1_0
```

<details>
<summary>Solution</summary>

```bash
kubectl label pods -l application=nginx version=1_0
```
</details>

### Task 25:

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
