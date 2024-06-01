### Task 1:

Create a Pod with a YAML manifest that meets the following requirements:
1. Specifies labels to the Pod.
2. Declares the container image to be executed in the container of the Pod.
3. Injects one or many environment variables to the container.
4. Specifies the number of ports to expose on the Pod’s IP address.

The solution can be checked with the following kubectl command:
```bash
kubectl get pod <pod-name> -o yaml | grep -E "labels|image|env|ports"
```

<details>
<summary>Solution</summary>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
  labels:
    app: my-app
    env: test
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
kubectl apply -f <path-to-manifest>/pod.yaml
```
</details>

### Task 2:

Create a Pod with a YAML manifest that meets the following requirements:
1. Specifies labels to the Pod.
2. Declares the container image to be executed in the container of the Pod.
3. Injects one or many environment variables to the container.
4. Specifies the number of ports to expose on the Pod’s IP address.
5. Sets resource requests and limits for CPU and memory.

The solution can be checked with the following kubectl command:
```bash
kubectl get pod <pod-name> -o yaml | grep -E "labels|image|env|ports|resources"
```

<details>
<summary>Solution</summary>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-pod
  labels:
    app: resource-app
    tier: frontend
spec:
  containers:
  - name: resource-container
    image: httpd:latest
    env:
    - name: ENV_VAR_1
      value: "value1"
    - name: ENV_VAR_2
      value: "value2"
    ports:
    - containerPort: 80
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
```

```bash
kubectl apply -f <path-to-manifest>/pod.yaml
```
</details>
