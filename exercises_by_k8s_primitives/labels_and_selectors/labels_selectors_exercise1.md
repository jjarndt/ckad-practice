### Task 1:

Create a Deployment named `nginx-deployment` in the `default` namespace with 3 replicas of the `nginx` image. Apply the following labels to the pods:
- `environment=production`
- `tier=frontend`
- `partition=customerA`

Then, create a Service named `nginx-service` that selects all pods with the `partition=customerA` label and exclude the pods with the `environment=qa` label.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.metadata.labels}' | grep 'environment: production'
kubectl get service nginx-service -o jsonpath='{.spec.selector}' | grep 'partition: customerA'
kubectl get service nginx-service -o jsonpath='{.spec.selector}' | grep 'environment: qa'
```

<details>
<summary>Solution</summary>

```bash
# Create the deployment
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: default
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
        environment: production
        tier: frontend
        partition: customerA
    spec:
      containers:
      - name: nginx
        image: nginx
EOF

# Create the service
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  namespace: default
spec:
  selector:
    partition: customerA
    environment: production
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
EOF
```
</details>

### Task 2:

Remove all labels from the pods created by the `nginx-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods -l app=nginx --show-labels
```

<details>
<summary>Solution</summary>

```bash
# Remove the labels from the pods
kubectl label pods -l app=nginx environment- tier- partition-
```
</details>
