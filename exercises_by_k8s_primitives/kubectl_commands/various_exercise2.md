### Task 1:

Scale the deployment `web-deployment` to 6 replicas, label all pods with `version=stable`, and set the environment variable `RELEASE` to `1.2.0` in each pod.
<details>
<summary>Solution</summary>

```bash
kubectl scale deployment web-deployment --replicas=6
kubectl label pods -l app=web-deployment version=stable
kubectl set env pods -l app=web-deployment RELEASE=1.2.0
```
</details>

### Task 2:

Update the pod `analytics` by setting the image to `analytics:v2`, set the environment variable `DEBUG` to `false`, and add a label `tier=data`.
<details>
<summary>Solution</summary>

```bash
kubectl set image pod/analytics analytics=analytics:v2
kubectl set env pod/analytics DEBUG=false
kubectl label pod analytics tier=data
```
</details>

### Task 3:

Label the `payment` pod with `app=payment`, set the replica count of its deployment to `4`, and overwrite any existing `status` label with `active`.
<details>
<summary>Solution</summary>

```bash
kubectl label pod payment app=payment
kubectl scale deployment payment --replicas=4
kubectl label --overwrite pod payment status=active
```
</details>

### Task 4:

Update all pods with the label `role=worker` to have the environment variable `WORKER_ROLE` set to `processing`, set the image to `worker:v3`, and save the logs to `worker_logs.txt`.
<details>
<summary>Solution</summary>

```bash
kubectl set env pods -l role=worker WORKER_ROLE=processing
kubectl set image pods -l role=worker worker=worker:v3
kubectl logs -l role=worker > worker_logs.txt
```
</details>

### Task 5:

Scale the stateful set `db-set` to 5 replicas, update the image to `db:v1.5`, and label the pods with `env=production`.
<details>
<summary>Solution</summary>

```bash
kubectl scale statefulset db-set --replicas=5
kubectl set image statefulset db-set db=db:v1.5
kubectl label pods -l app=db-set env=production
```
</details>

### Task 6:

Set the environment variable `ENV` to `test` in the pod `test-pod`, get the logs and save them to `test_pod_logs.txt`, and overwrite the label `phase` with `testing`.
<details>
<summary>Solution</summary>

```bash
kubectl set env pod/test-pod ENV=test
kubectl logs test-pod > test_pod_logs.txt
kubectl label --overwrite pod test-pod phase=testing
```
</details>

### Task 7:

Scale the deployment `frontend` to 8 replicas, set the image to `frontend:v2`, label all pods with `release=beta`, and set the environment variable `API_URL` to `https://api.example.com`.
<details>
<summary>Solution</summary>

```bash
kubectl scale deployment frontend --replicas=8
kubectl set image deployment/frontend frontend=frontend:v2
kubectl label pods -l app=frontend release=beta
kubectl set env pods -l app=frontend API_URL=https://api.example.com
```
</details>

### Task 8:

Update the `cache` pod by setting the image to `cache:v1.3`, scale the deployment to 3 replicas, add the label `region=us-east`, and set the environment variable `CACHE_SIZE` to `256MB`.
<details>
<summary>Solution</summary>

```bash
kubectl set image pod/cache cache=cache:v1.3
kubectl scale deployment cache --replicas=3
kubectl label pod cache region=us-east
kubectl set env pod/cache CACHE_SIZE=256MB
```
</details>

### Task 9:

Label all pods with `app=logger` to have `version=1.1`, scale the replica set `logger-set` to `4`, set the environment variable `LOG_LEVEL` to `debug`, and get the logs from one of the pods.
<details>
<summary>Solution</summary>

```bash
kubectl label pods -l app=logger version=1.1
kubectl scale rs logger-set --replicas=4
kubectl set env pods -l app=logger LOG_LEVEL=debug
kubectl logs $(kubectl get pods -l app=logger -o jsonpath='{.items[0].metadata.name}')
```
</details>

### Task 10:

Scale the `backup` deployment to `7` replicas, update the image to `backup:v2.1`, set the environment variable `BACKUP_INTERVAL` to `24h`, and label the pods with `priority=high`.
<details>
<summary>Solution</summary>

```bash
kubectl scale deployment backup --replicas=7
kubectl set image deployment/backup backup=backup:v2.1
kubectl set env pods -l app=backup BACKUP_INTERVAL=24h
kubectl label pods -l app=backup priority=high
```
</details>
