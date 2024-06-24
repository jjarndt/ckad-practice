### Task 1:

Create a Deployment named `frontend-stable` with the image `nginx:1.18`, 3 replicas, and the following labels: `app=guestbook`, `tier=frontend`, `track=stable`. Also, ensure the deployment has a readiness probe to check if the application is ready on port 80.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment frontend-stable -o jsonpath='{.spec.template.metadata.labels}'
kubectl get deployment frontend-stable -o jsonpath='{.spec.template.spec.containers[0].image}'
kubectl get deployment frontend-stable -o jsonpath='{.spec.replicas}'
kubectl get deployment frontend-stable -o jsonpath='{.spec.template.spec.containers[0].readinessProbe}'
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-stable
spec:
  replicas: 3
  selector:
    matchLabels:
      app: guestbook
      tier: frontend
      track: stable
  template:
    metadata:
      labels:
        app: guestbook
        tier: frontend
        track: stable
    spec:
      containers:
      - name: frontend
        image: nginx:1.18
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
EOF
```
</details>

### Task 2:

Create a Service named `frontend-service` that selects the `frontend-stable` Deployment and exposes it on port 80.

The solution can be checked with the following kubectl command:
```bash
kubectl get service frontend-service -o jsonpath='{.spec.selector}'
kubectl get service frontend-service -o jsonpath='{.spec.ports[0].port}'
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
spec:
  selector:
    app: guestbook
    tier: frontend
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
EOF
```
</details>

### Task 3:

Create a canary Deployment named `frontend-canary` with the image `nginx:1.19`, 1 replica, and the following labels: `app=guestbook`, `tier=frontend`, `track=canary`. Also, ensure the deployment has a readiness probe to check if the application is ready on port 80.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment frontend-canary -o jsonpath='{.spec.template.metadata.labels}'
kubectl get deployment frontend-canary -o jsonpath='{.spec.template.spec.containers[0].image}'
kubectl get deployment frontend-canary -o jsonpath='{.spec.replicas}'
kubectl get deployment frontend-canary -o jsonpath='{.spec.template.spec.containers[0].readinessProbe}'
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-canary
spec:
  replicas: 1
  selector:
    matchLabels:
      app: guestbook
      tier: frontend
      track: canary
  template:
    metadata:
      labels:
        app: guestbook
        tier: frontend
        track: canary
    spec:
      containers:
      - name: frontend
        image: nginx:1.19
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
EOF
```
</details>

### Task 4:

Verify that the `frontend-service` spans both `frontend-stable` and `frontend-canary` by checking the endpoints.

The solution can be checked with the following kubectl command:
```bash
kubectl get endpoints frontend-service
```

<details>
<summary>Solution</summary>

```bash
kubectl get endpoints frontend-service
```
</details>

### Task 5:

Scale the `frontend-canary` Deployment to 2 replicas to increase its traffic ratio.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment frontend-canary -o jsonpath='{.spec.replicas}'
kubectl get endpoints frontend-service
```

<details>
<summary>Solution</summary>

```bash
kubectl scale deployment frontend-canary --replicas=2
```
</details>

### Task 6:

Update the image of the `frontend-stable` Deployment to `nginx:1.19` and scale it up to 4 replicas. Then, delete the `frontend-canary` Deployment.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment frontend-stable -o jsonpath='{.spec.template.spec.containers[0].image}'
kubectl get deployment frontend-stable -o jsonpath='{.spec.replicas}'
kubectl get deployment frontend-canary
```

<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/frontend-stable frontend=nginx:1.19
kubectl scale deployment frontend-stable --replicas=4
kubectl delete deployment frontend-canary
```
</details>

### Task 7:

Pause the rollout of the `frontend-stable` Deployment, then resume it.

The solution can be checked with the following kubectl command:
```bash
kubectl rollout status deployment frontend-stable
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout pause deployment/frontend-stable
kubectl rollout resume deployment/frontend-stable
```
</details>

### Task 8:

Undo the last rollout of the `frontend-stable` Deployment to revert to the previous version.

The solution can be checked with the following kubectl command:
```bash
kubectl rollout history deployment frontend-stable
kubectl rollout undo deployment frontend-stable
kubectl rollout status deployment frontend-stable
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout undo deployment frontend-stable
```
</details>

### Task 9:

Perform a rolling update on the `frontend-stable` Deployment to change the image to `nginx:1.20` and ensure the change-cause annotation is recorded.

The solution can be checked with the following kubectl command:
```bash
kubectl rollout history deployment frontend-stable
kubectl get deployment frontend-stable -o jsonpath='{.spec.template.spec.containers[0].image}'
kubectl get deployment frontend-stable -o jsonpath='{.metadata.annotations}'
```

<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/frontend-stable frontend=nginx:1.20 --record
kubectl annotate deployment frontend-stable kubernetes.io/change-cause="Updated image to nginx:1.20"
```
</details>
