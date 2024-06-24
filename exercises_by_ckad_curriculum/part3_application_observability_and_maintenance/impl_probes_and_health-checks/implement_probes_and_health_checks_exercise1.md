### Task 1:

Create a deployment named `web-app` using the `nginx` image with 3 replicas. Implement a liveness probe that checks the health of the application by sending a GET request to the root path `/` on port `80` every 10 seconds. If the probe fails, the container should be restarted.

The solution can be checked with the following kubectl command:
```sh
kubectl get deployment web-app
kubectl get pods -l app=web-app
kubectl describe pod -l app=web-app
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 10
          periodSeconds: 10
EOF
```
</details>

### Task 2:

Modify the `web-app` deployment to include a liveness probe with a `timeoutSeconds` of 5 and a `successThreshold` of 1. This means the liveness probe should timeout after 5 seconds and it needs to succeed only once to be considered successful.

The solution can be checked with the following kubectl command:
```sh
kubectl get deployment web-app
kubectl describe deployment web-app
kubectl describe pod -l app=web-app
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 10
          periodSeconds: 10
          timeoutSeconds: 5
          successThreshold: 1
EOF
```
</details>

### Task 3:

Modify the `web-app` deployment to include a liveness probe with a `failureThreshold` of 3. This means the liveness probe will restart the container if it fails 3 consecutive times.

The solution can be checked with the following kubectl command:
```sh
kubectl get deployment web-app
kubectl describe deployment web-app
kubectl describe pod -l app=web-app
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 10
          periodSeconds: 10
          timeoutSeconds: 5
          successThreshold: 1
          failureThreshold: 3
EOF
```
</details>

### Task 4:

Modify the `web-app` deployment to set the `terminationGracePeriodSeconds` to 30. This means when the container is terminated, it will be given 30 seconds to shut down gracefully before being forcefully killed.

The solution can be checked with the following kubectl command:
```sh
kubectl get deployment web-app
kubectl describe deployment web-app
kubectl describe pod -l app=web-app
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      terminationGracePeriodSeconds: 30
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 10
          periodSeconds: 10
          timeoutSeconds: 5
          successThreshold: 1
          failureThreshold: 3
EOF
```
</details>

### Task 5:

Modify the `web-app` deployment to ensure the liveness probe has the following settings:
- `initialDelaySeconds`: 10
- `periodSeconds`: 10
- `timeoutSeconds`: 5
- `successThreshold`: 1
- `failureThreshold`: 3

Additionally, set the `terminationGracePeriodSeconds` to 30.

The solution can be checked with the following kubectl command:
```sh
kubectl get deployment web-app
kubectl describe deployment web-app
kubectl describe pod -l app=web-app
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      terminationGracePeriodSeconds: 30
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 10
          periodSeconds: 10
          timeoutSeconds: 5
          successThreshold: 1
          failureThreshold: 3
EOF
```
</details>

### Task 6:

Modify the `web-app` deployment to include a readiness probe with the following settings:
- `initialDelaySeconds`: 5
- `periodSeconds`: 10
- `timeoutSeconds`: 5
- `successThreshold`: 1
- `failureThreshold`: 3

The readiness probe should also check the health of the application by sending a GET request to the root path `/` on port `80`.

The solution can be checked with the following kubectl command:
```sh
kubectl get deployment web-app
kubectl describe deployment web-app
kubectl describe pod -l app=web-app
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      terminationGracePeriodSeconds: 30
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 10
          periodSeconds: 10
          timeoutSeconds: 5
          successThreshold: 1
          failureThreshold: 3
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
          timeoutSeconds: 5
          successThreshold: 1
          failureThreshold: 3
EOF
```
</details>
