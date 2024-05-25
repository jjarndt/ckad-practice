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
