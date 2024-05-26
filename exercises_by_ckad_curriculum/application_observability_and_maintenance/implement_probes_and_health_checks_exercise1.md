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
