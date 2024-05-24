### Task 1:

Create a Deployment named `nginx-deployment` with the image `nginx:1.18` and 3 replicas. Ensure the change-cause annotation is recorded.

The solution can be checked with the following kubectl command:
```bash
kubectl describe deployment nginx-deployment | grep Replicas
kubectl describe deployment nginx-deployment | grep Annotations
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  annotations:
    kubernetes.io/change-cause: "Initial deployment"
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.18
EOF
```
</details>

### Task 2:

Check the status of the `nginx-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment nginx-deployment
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout status deployment nginx-deployment
```
</details>

### Task 3:

Update the `nginx-deployment` to use the image `nginx:1.19` and ensure the change-cause annotation is recorded.

The solution can be checked with the following kubectl command:
```bash
kubectl describe deployment nginx-deployment | grep Image
kubectl describe deployment nginx-deployment | grep Annotations
```

<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/nginx-deployment nginx=nginx:1.19 --record
kubectl annotate deployment nginx-deployment kubernetes.io/change-cause="Updated image to nginx:1.19"
```
</details>

### Task 4:

Pause the rollout of the `nginx-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl describe deployment nginx-deployment | grep Conditions
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout pause deployment nginx-deployment
```
</details>

### Task 5:

Resume the rollout of the `nginx-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl describe deployment nginx-deployment | grep Conditions
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout resume deployment nginx-deployment
```
</details>

### Task 6:

Undo the last rollout of the `nginx-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl describe deployment nginx-deployment | grep Annotations
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout undo deployment nginx-deployment
```
</details>

### Task 7:

Undo the rollout of the `nginx-deployment` to the previous revision.

The solution can be checked with the following kubectl command:
```bash
kubectl describe deployment nginx-deployment | grep Revision
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout undo deployment nginx-deployment --to-revision=1
```
</details>
