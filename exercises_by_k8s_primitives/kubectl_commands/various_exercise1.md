### Task 1:

Update pod `bar` to set the number of replicas to `3`.
<details>
<summary>Solution</summary>

```bash
kubectl scale pod bar --replicas=3
```
</details>

### Task 2:

Update the deployment `nginx-deployment` to scale the number of replicas to `5`.
<details>
<summary>Solution</summary>

```bash
kubectl scale deployment nginx-deployment --replicas=5
```
</details>

### Task 3:

Update the pod `webapp` by setting the environment variable `DEBUG` to `true`.
<details>
<summary>Solution</summary>

```bash
kubectl set env pod webapp DEBUG=true
```
</details>

### Task 4:

Update pod `backend` with the label `version` and the value `v2`.
<details>
<summary>Solution</summary>

```bash
kubectl label pods backend version=v2
```
</details>

### Task 5:

Update pod `frontend` with the label `app=frontend` and set the environment variable `ENV` to `production`.
<details>
<summary>Solution</summary>

```bash
kubectl label pods frontend app=frontend
kubectl set env pod frontend ENV=production
```
</details>

### Task 6:

Get logs from the pod `database` and save them to a file `db_logs.txt`.
<details>
<summary>Solution</summary>

```bash
kubectl logs database > db_logs.txt
```
</details>

### Task 7:

Scale the replica set `my-replica-set` to `4` replicas and label the pods with `tier=backend`.
<details>
<summary>Solution</summary>

```bash
kubectl scale rs my-replica-set --replicas=4
kubectl label pods -l app=my-replica-set tier=backend
```
</details>

### Task 8:

Update all pods with the label `app=nginx` to have the label `environment=staging`.
<details>
<summary>Solution</summary>

```bash
kubectl label pods -l app=nginx environment=staging
```
</details>

### Task 9:

Update pod `auth-service` by setting the image to `auth-service:v2`.
<details>
<summary>Solution</summary>

```bash
kubectl set image pod/auth-service auth-service=auth-service:v2
```
</details>

### Task 10:

Scale the deployment `api-server` to `10` replicas and get the logs from one of the pods.
<details>
<summary>Solution</summary>

```bash
kubectl scale deployment api-server --replicas=10
kubectl logs $(kubectl get pods -l app=api-server -o jsonpath='{.items[0].metadata.name}')
```
</details>
