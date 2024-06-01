### Task 2:

Create a Deployment with a YAML manifest that meets the following requirements:
1. Specifies labels to the Deployment and its Pods.
2. Declares the container image to be executed in the container of the Pods.
3. Injects one or many environment variables to the container.
4. Specifies the number of ports to expose on the Pods’ IP address.
5. Ensures that 3 replicas of the Pods are running.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment <deployment-name> -o yaml | grep -E "labels|image|env|ports|replicas"
```

<details>
<summary>Solution</summary>

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
  labels:
    app: my-app
    tier: backend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
        tier: backend
    spec:
      containers:
      - name: my-container
        image: nginx:latest
        env:
        - name: ENV_VAR_1
          value: "value1"
        - name: ENV_VAR_2
          value: "value2"
        ports:
        - containerPort: 80
```

```bash
kubectl apply -f <path-to-manifest>/deployment.yaml
```
</details>
