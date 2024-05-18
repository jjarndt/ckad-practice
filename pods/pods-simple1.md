### Task 1:
Create a Pod named `my-pod` using the `nginx` image.

<details>
<summary>Solution</summary>

```bash
k run my-pod --image=nginx
```
</details>

### Task 2:
List all Pods in the default namespace.

<details>
<summary>Solution</summary>

```bash
k get pods -n default
```
</details>

### Task 3:
Describe the Pod named `my-pod`.

<details>
<summary>Solution</summary>

```bash
k describe pod my-pod
```
</details>

### Task 4:
Get the logs of the `my-pod` Pod.

<details>
<summary>Solution</summary>

```bash
k logs my-pod
```
</details>


### Task 5:
Expose the `my-pod` Pod as a service on port 80.

<details>
<summary>Solution</summary>

```bash
kubectl expose pod my-pod --port=80 --target-port=80 --name=my-pod-service
```
</details>

### Task 6:
Scale the `my-pod` Pod to 3 replicas. For that you need to use a Deployment or ReplicaSet. Let's create a Deployment first.
Create a Deployment named my-deployment with the nginx image.

<details>
<summary>Solution</summary>

```bash
kubectl scale deployment mydeployment --replicas=3
```
</details>

### Task 7:
Scale the my-deployment Deployment to 3 replicas.

<details>
<summary>Solution</summary>

```bash
kubectl scale deployment mydeployment --replicas=3
```
</details>

### Task 8
Update the image of the `my-deployment` Deployment to `nginx:1.19`.

<details>
<summary>Solution</summary>

```bash
k set image deployment/mydeployment nginx=nginx:1.19
```
</details>

### Task 9
Roll back the `my-deployment` Deployment to the previous version.

<details>
<summary>Solution</summary>

```bash
k rollout undo deployment/mydeployment
```
</details>

### Task 10
Create a Pod named `resource-pod` using the `nginx` image with CPU request set to `100m` and memory request set to `200Mi`.

<details>
<summary>Solution</summary>

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: resource-pod
spec:
    containers:
    - name: nginx
      image: nginx
      resources:
          requests:
            memory: "200Mi"
            cpu: "100m"
```

```bash
k apply -f spec.yaml 
```
Check with:
```bash
kubectl get pod resource-pod -o yaml | grep -A 5 "resources:"
```
</details>
