### Task 1:

Create a Deployment named `my-deployment` using the `nginx` image with 3 replicas.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment my-deployment -o jsonpath='{.spec.replicas}' | grep 3
kubectl get deployment my-deployment -o jsonpath='{.spec.template.spec.containers[0].image}' | grep "nginx"
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
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
        image: nginx
EOF
```
</details>

### Task 2:

Check the status of the `my-deployment`.

<details>
<summary>Solution</summary>

```bash
kubectl rollout status deployment/my-deployment
```
</details>

### Task 3:

Check the rollout history of the `my-deployment`.

<details>
<summary>Solution</summary>

```bash
kubectl rollout history deployment/my-deployment
```
</details>

### Task 4:

Update the `my-deployment` to use the `nginx:1.19` image and record the change.

The solution can be checked with the following kubectl command:
```bash
kubectl rollout history deployment/my-deployment | grep "nginx:1.19"
```

<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/my-deployment nginx=nginx:1.19 --record
```
</details>

### Task 5:

Undo the last rollout of `my-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl rollout history deployment/my-deployment | grep "nginx"
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout undo deployment/my-deployment
```
</details>

### Task 6:

Pause the rollout of `my-deployment`.

<details>
<summary>Solution</summary>

```bash
kubectl rollout pause deployment/my-deployment
```
</details>

### Task 7:

Resume the rollout of `my-deployment`.


<details>
<summary>Solution</summary>

```bash
kubectl rollout resume deployment/my-deployment
```
</details>

### Task 8:

Check the annotation for the change-cause field in the `my-deployment`.

<details>
<summary>Solution</summary>

```bash
kubectl rollout history deployment/my-deployment --revision=2
```
</details>
