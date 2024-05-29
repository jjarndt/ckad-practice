### Task 1:

Create a temporary Pod using the `nginx:1.25.1` image, exposing port 8080, setting an environment variable `PROFILE` to `dev`, and adding a label `app=frontend`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].env[?(@.name=="PROFILE")].value}' 
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].status.containerStatuses[0].image}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].ports[0].containerPort}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].metadata.deletionTimestamp}'
```

<details>
<summary>Solution</summary>

```bash
kubectl run temp-nginx --image=nginx:1.25.1 --port=8080 --rm --env=PROFILE=dev --labels=app=frontend
```
</details>

### Task 2:

Create a Pod named `web-server` using the `nginx:1.25.1` image, exposing port 8080, setting an environment variable `ENV` to `production`, and adding a label `tier=backend`.

The solution can be checked with the following kubectl command:
```bash
kubectl get pod web-server -o jsonpath='{.spec.containers[0].env[?(@.name=="ENV")].value}'
kubectl get pod web-server -o jsonpath='{.status.containerStatuses[0].image}'
kubectl get pod web-server -o jsonpath='{.spec.containers[0].ports[0].containerPort}'
kubectl get pod web-server -o jsonpath='{.metadata.labels.tier}'
```

<details>
<summary>Solution</summary>

```bash
kubectl run web-server --image=nginx:1.25.1 --port=8080 --env=ENV=production --labels=tier=backend
```
</details>

### Task 3:

Create a temporary Pod using the `nginx:1.25.1` image, exposing port 8080, setting an environment variable `PROFILE` to `dev`, and adding a label `app=frontend`. Ensure the Pod is deleted after the command in the container finishes.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].env[?(@.name=="PROFILE")].value}' 
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].status.containerStatuses[0].image}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].ports[0].containerPort}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].metadata.deletionTimestamp}'
```

<details>
<summary>Solution</summary>

```bash
kubectl run temp-nginx --image=nginx:1.25.1 --port=8080 --rm --env=PROFILE=dev --labels=app=frontend
```
</details>

### Task 5:

Create a temporary Pod named `test-app` using the `nginx:1.25.1` image, exposing port 8080, setting an environment variable `PROFILE` to `dev`, and adding a label `app=frontend`. Ensure the Pod is deleted after the command in the container finishes.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].env[?(@.name=="PROFILE")].value}' 
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].status.containerStatuses[0].image}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].ports[0].containerPort}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].metadata.deletionTimestamp}'
```

<details>
<summary>Solution</summary>

```bash
kubectl run test-app --image=nginx:1.25.1 --port=8080 --rm --env=PROFILE=dev --labels=app=frontend
```
</details>

### Task 6:

Launch a temporary Pod named `frontend-pod` using the `nginx:1.25.1` image. The Pod should expose port 8080, have an environment variable `PROFILE` set to `dev`, and be labeled with `app=frontend`. Ensure the Pod is automatically deleted once the container completes its execution.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].env[?(@.name=="PROFILE")].value}' 
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].status.containerStatuses[0].image}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].ports[0].containerPort}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].metadata.deletionTimestamp}'
```

<details>
<summary>Solution</summary>

```bash
kubectl run frontend-pod --image=nginx:1.25.1 --port=8080 --rm --env=PROFILE=dev --labels=app=frontend
```
</details>

### Task 7:

Deploy a temporary Pod named `nginx-temp` using the `nginx:1.25.1` image. Ensure it exposes port 8080, includes an environment variable `PROFILE` set to `dev`, and is labeled with `app=frontend`. The Pod should be removed automatically after the command finishes.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].env[?(@.name=="PROFILE")].value}' 
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].status.containerStatuses[0].image}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].ports[0].containerPort}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].metadata.deletionTimestamp}'
```

<details>
<summary>Solution</summary>

```bash
kubectl run nginx-temp --image=nginx:1.25.1 --port=8080 --rm --env=PROFILE=dev --labels=app=frontend
```
</details>

### Task 8:

Start a temporary Pod named `nginx-app` with the `nginx:1.25.1` image. It should expose port 8080, set an environment variable `PROFILE` to `dev`, and have the label `app=frontend`. Make sure the Pod gets deleted automatically after the container's command finishes.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].env[?(@.name=="PROFILE")].value}' 
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].status.containerStatuses[0].image}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].ports[0].containerPort}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].metadata.deletionTimestamp}'
```

<details>
<summary>Solution</summary>

```bash
kubectl run nginx-app --image=nginx:1.25.1 --port=8080 --rm --env=PROFILE=dev --labels=app=frontend
```
</details>

### Task 9:

Run a temporary Pod named `dev-nginx` using the `nginx:1.25.1` image. Configure it to expose port 8080, include an environment variable `PROFILE` with the value `dev`, and assign the label `app=frontend`. Ensure the Pod is deleted automatically after the command execution completes.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].env[?(@.name=="PROFILE")].value}' 
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].status.containerStatuses[0].image}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].spec.containers[0].ports[0].containerPort}'
kubectl get pods --selector=app=frontend -o jsonpath='{.items[0].metadata.deletionTimestamp}'
```

<details>
<summary>Solution</summary>

```bash
kubectl run dev-nginx --image=nginx:1.25.1 --port=8080 --rm --env=PROFILE=dev --labels=app=frontend
```
</details>
