### Task 1:

Return snapshot logs from pod nginx with only one container
<details>
<summary>Solution</summary>

```bash
kubectl logs nginx
```
</details>

### Task 2:

Return snapshot logs from pod nginx with multi containers
<details>
<summary>Solution</summary>

```bash
kubectl logs nginx --all-containers=true
```
</details>

### Task 3:

Return snapshot logs from all containers in pods defined by label app=nginx
<details>
<summary>Solution</summary>

```bash
kubectl logs -l app=nginx --all-containers=true
```
</details>

### Task 4:

Return snapshot of previous terminated ruby container logs from pod web-1
<details>
<summary>Solution</summary>

```bash
kubectl logs -p -c ruby web-1
```
</details>

### Task 5:

Begin streaming the logs of the ruby container in pod web-1
<details>
<summary>Solution</summary>

```bash
kubectl logs -f -c ruby web-1
```
</details>

### Task 6:

Begin streaming the logs from all containers in pods defined by label app=nginx
<details>
<summary>Solution</summary>

```bash
kubectl logs -f -l app=nginx --all-containers=true
```
</details>

### Task 7:

Display only the most recent 20 lines of output in pod nginx
<details>
<summary>Solution</summary>

```bash
kubectl logs --tail=20 nginx
```
</details>

### Task 8:

Show all logs from pod nginx written in the last hour
<details>
<summary>Solution</summary>

```bash
kubectl logs --since=1h nginx
```
</details>

### Task 9:

Show logs from a kubelet with an expired serving certificate
<details>
<summary>Solution</summary>

```bash
kubectl logs --insecure-skip-tls-verify-backend nginx
```
</details>

### Task 10:

Return snapshot logs from first container of a job named hello
<details>
<summary>Solution</summary>

```bash
kubectl logs job/hello
```
</details>

### Task 11:

Return snapshot logs from container nginx-1 of a deployment named nginx
<details>
<summary>Solution</summary>

```bash
kubectl logs deployment/nginx -c nginx-1
```
</details>

### Task 12:

Show logs from the last 5 minutes for the nginx pod in the default namespace
<details>
<summary>Solution</summary>

```bash
kubectl logs --since=5m nginx
```
</details>

### Task 13:

Return snapshot logs from all containers in a pod named `web` located in the `production` namespace
<details>
<summary>Solution</summary>

```bash
kubectl logs web --all-containers=true -n production
```
</details>

### Task 14:

Stream logs from a specific node in your Kubernetes cluster
<details>
<summary>Solution</summary>

```bash
kubectl logs -f --node=my-node-name
```
</details>

### Task 15:

Show logs from the nginx pod and exclude messages older than a specific timestamp
<details>
<summary>Solution</summary>

```bash
kubectl logs --since-time="2024-05-27T10:00:00Z" nginx
```
</details>

### Task 16:

Return logs from a specific time range for the ruby container in the web-1 pod
<details>
<summary>Solution</summary>

```bash
kubectl logs -c ruby web-1 --since-time="2024-05-27T10:00:00Z" --until-time="2024-05-27T12:00:00Z"
```
</details>

### Task 17:

Stream logs from all pods with the label `tier=frontend` in the `staging` namespace
<details>
<summary>Solution</summary>

```bash
kubectl logs -f -l tier=frontend -n staging
```
</details>

### Task 18:

Retrieve the logs for a cron job named `backup` for a specific execution
<details>
<summary>Solution</summary>

```bash
kubectl logs job/backup-<job-id>
```
</details>

### Task 19:

Return the logs from all previous instances of the pods defined by the label `app=database`
<details>
<summary>Solution</summary>

```bash
kubectl logs -l app=database --all-containers=true --previous
```
</details>

### Task 20:

Fetch logs from a specific container in the most recent pod created by a deployment named `web-app`
<details>
<summary>Solution</summary>

```bash
kubectl logs deployment/web-app -c <container-name> --tail=50
```
</details>

### Task 21:

Show logs from a pod using a specific context in your Kubernetes configuration
<details>
<summary>Solution</summary>

```bash
kubectl logs nginx --context=my-context
```
</details>

### Task 22:

Return logs from a specific init container in the pod named `init-pod`
<details>
<summary>Solution</summary>

```bash
kubectl logs init-pod -c init-container
```
</details>

### Task 23:

Stream logs from a stateful set named `mysql` with a specific pod ordinal
<details>
<summary>Solution</summary>

```bash
kubectl logs -f statefulset/mysql-0
```
</details>

### Task 24:

Fetch and follow logs from a DaemonSet named `fluentd` on a specific node
<details>
<summary>Solution</summary>

```bash
kubectl logs -f daemonset/fluentd -l kubernetes.io/hostname=<node-name>
```
</details>

### Task 25:

Display logs from a pod while excluding logs from a specific container
<details>
<summary>Solution</summary>

```bash
kubectl logs nginx --all-containers=true --ignore-errors=true
```
</details>

### Task 26:

Return logs from all containers in a pod named `nginx` using the `all-containers` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs nginx --all-containers=true
```
</details>

### Task 27:

Return logs from a specific container named `app-container` in a pod named `web` using the `container` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs web -c app-container
```
</details>

### Task 28:

Stream logs from a pod named `backend` using the `follow` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs -f backend
```
</details>

### Task 29:

Stream logs from all containers in a pod named `frontend` while ignoring errors using the `ignore-errors` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs -f frontend --all-containers=true --ignore-errors=true
```
</details>

### Task 30:

Return logs from a pod named `auth` while skipping TLS verification using the `insecure-skip-tls-verify-backend` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs auth --insecure-skip-tls-verify-backend
```
</details>

### Task 31:

Return a maximum of 1000 bytes of logs from a pod named `cache` using the `limit-bytes` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs cache --limit-bytes=1000
```
</details>

### Task 32:

Stream logs from pods with the label `role=database` with a maximum of 3 concurrent logs using the `max-log-requests` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs -f -l role=database --max-log-requests=3
```
</details>

### Task 33:

Wait for up to 30 seconds for at least one pod named `api` to be running using the `pod-running-timeout` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs api --pod-running-timeout=30s
```
</details>

### Task 34:

Prefix each log line with the log source (pod name and container name) for a pod named `worker` using the `prefix` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs worker --prefix=true
```
</details>

### Task 35:

Return logs for the previous instance of a container named `db` in a pod named `database` using the `previous` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs database -c db -p
```
</details>

### Task 36:

Return logs from pods with the label `app=payment` using the `selector` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs -l app=payment
```
</details>

### Task 37:

Return logs newer than 2 hours from a pod named `nginx` using the `since` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs nginx --since=2h
```
</details>

### Task 38:

Return logs from a pod named `scheduler` after a specific date using the `since-time` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs scheduler --since-time="2024-05-27T10:00:00Z"
```
</details>

### Task 39:

Display only the most recent 50 lines of logs from a pod named `gateway` using the `tail` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs gateway --tail=50
```
</details>

### Task 40:

Include timestamps on each line in the log output for a pod named `storage` using the `timestamps` flag
<details>
<summary>Solution</summary>

```bash
kubectl logs storage --timestamps=true
```
</details>
