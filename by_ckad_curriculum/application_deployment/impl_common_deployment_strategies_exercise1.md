The task involves orchestrating the deployment of an Nginx web server application in a Kubernetes environment using advanced deployment strategies.

### Brief Overview:

1. **Task 1**: Deploy an initial version of the Nginx application (`nginx-blue`) with three replicas using version `1.18`.

2. **Task 2**: Expose the `nginx-blue` deployment through a Kubernetes Service (`nginx-service`) on port 80 to enable external access.

3. **Task 3**: Implement a Blue/Green deployment strategy by deploying a new version of the Nginx application (`nginx-green`) using version `1.19` alongside the existing one. Update the `nginx-service` to direct traffic to the new version (`nginx-green`).

4. **Task 4**: Expand the deployment strategy by introducing a Canary deployment. Deploy another version of the Nginx application (`nginx-canary`) using version `1.20` with minimal replica count for testing purposes. Modify the `nginx-service` to balance traffic between both the `nginx-green` and `nginx-canary` deployments.

Each step progressively enhances the deployment strategy, allowing for seamless updates and testing of new versions of the Nginx application in the Kubernetes cluster.

### Task 1:

Create a Deployment named `nginx-blue` with the image `nginx:1.18` and 3 replicas.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment nginx-blue -o jsonpath='{.spec.replicas}' | grep 3
kubectl get deployment nginx-blue -o jsonpath='{.spec.template.spec.containers[0].image}' | grep "nginx:1.18"
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-blue
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

Create a Service named `nginx-service` that exposes the `nginx-blue` Deployment on port 80.

The solution can be checked with the following kubectl command:
```bash
kubectl get service nginx-service -o jsonpath='{.spec.ports[0].port}' | grep 80
kubectl get service nginx-service -o jsonpath='{.spec.selector.app}' | grep "nginx"
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
EOF
```
</details>

### Task 3:

Implement a blue/green deployment strategy by creating a new Deployment named `nginx-green` with the image `nginx:1.19` and 3 replicas. Update the `nginx-service` to point to the `nginx-green` Deployment.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment nginx-green -o jsonpath='{.spec.template.spec.containers[0].image}' | grep "nginx:1.19"
kubectl get service nginx-service -o jsonpath='{.spec.selector.app}' | grep "nginx-green"
kubectl get endpoints nginx-service -o jsonpath='{.subsets[0].addresses[*].targetRef.name}'
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-green
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx-green
  template:
    metadata:
      labels:
        app: nginx-green
    spec:
      containers:
      - name: nginx
        image: nginx:1.19
EOF

kubectl patch service nginx-service -p '{"spec":{"selector":{"app":"nginx-green"}}}'
```
</details>

### Task 4:

Create a new Deployment named `nginx-canary` with the image `nginx:1.20` and 1 replica. Update the `nginx-service` to point to both `nginx-green` and `nginx-canary` Deployments.

The solution can be checked with the following kubectl command:

```bash
kubectl get deployment nginx-canary -o jsonpath='{.spec.template.spec.containers[0].image}' | grep "nginx:1.20"
kubectl get service nginx-service -o jsonpath='{.spec.selector}' | grep -E "nginx-green|nginx-canary"
kubectl get endpoints nginx-service
```

<details>
<summary>Solution</summary>

1. Create the `nginx-canary` Deployment:
```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-canary
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
      version: canary
  template:
    metadata:
      labels:
        app: nginx
        version: canary
    spec:
      containers:
      - name: nginx
        image: nginx:1.20
EOF
```

2. Update the `nginx-service` to include both `nginx-green` and `nginx-canary`:
```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
EOF
```

</details>
