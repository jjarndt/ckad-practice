### Task 1:

Update pod `foo` with the label `unhealthy` and the value `true`
<details>
<summary>Solution</summary>

```bash
kubectl label pods foo unhealthy=true
```
</details>

### Task 2:

Update pod `foo` with the label `status` and the value `unhealthy`, overwriting any existing value
<details>
<summary>Solution</summary>

```bash
kubectl label --overwrite pods foo status=unhealthy
```
</details>

### Task 3:

Update all pods in the namespace with the label `status=unhealthy`
<details>
<summary>Solution</summary>

```bash
kubectl label pods --all status=unhealthy
```
</details>

### Task 4:

Update a pod identified by the type and name in `pod.json` with the label `status=unhealthy`
<details>
<summary>Solution</summary>

```bash
kubectl label -f pod.json status=unhealthy
```
</details>

### Task 5:

Update pod `foo` only if the resource is unchanged from version 1 with the label `status=unhealthy`
<details>
<summary>Solution</summary>

```bash
kubectl label pods foo status=unhealthy --resource-version=1
```
</details>

### Task 6:

Update pod `foo` by removing a label named `bar` if it exists
<details>
<summary>Solution</summary>

```bash
kubectl label pods foo bar-
```
</details>

### Task 7:

Add a label `env=production` to all pods with the label `tier=frontend`
<details>
<summary>Solution</summary>

```bash
kubectl label pods -l tier=frontend env=production
```
</details>

### Task 8:

Update a node named `node-1` with the label `region=us-west`
<details>
<summary>Solution</summary>

```bash
kubectl label nodes node-1 region=us-west
```
</details>

### Task 9:

Update all nodes with the label `disktype=ssd`
<details>
<summary>Solution</summary>

```bash
kubectl label nodes --all disktype=ssd
```
</details>

### Task 10:

Update a service named `my-service` with the label `app=nginx`
<details>
<summary>Solution</summary>

```bash
kubectl label services my-service app=nginx
```
</details>

### Task 11:

Update a deployment named `my-deployment` with the label `team=devops`
<details>
<summary>Solution</summary>

```bash
kubectl label deployments my-deployment team=devops
```
</details>

### Task 12:

Add a label `version=v1` to all pods managed by a replication controller named `my-rc`
<details>
<summary>Solution</summary>

```bash
kubectl label rc my-rc version=v1
```
</details>

### Task 13:

Add a label `environment=staging` to a specific pod named `backend`
<details>
<summary>Solution</summary>

```bash
kubectl label pods backend environment=staging
```
</details>

### Task 14:

Update a pod named `cache` only if it matches the label selector `app=redis` with the label `tier=db`
<details>
<summary>Solution</summary>

```bash
kubectl label pods cache tier=db --selector=app=redis
```
</details>

### Task 15:

Add a label `backup=true` to all persistent volume claims in the namespace
<details>
<summary>Solution</summary>

```bash
kubectl label pvc --all backup=true
```
</details>

### Task 16:

Update a namespace named `development` with the label `team=backend`
<details>
<summary>Solution</summary>

```bash
kubectl label namespace development team=backend
```
</details>

### Task 17:

Remove a label named `beta` from all services
<details>
<summary>Solution</summary>

```bash
kubectl label services --all beta-
```
</details>

### Task 18:

Add a label `stage=testing` to a daemonset named `log-collector`
<details>
<summary>Solution</summary>

```bash
kubectl label daemonset log-collector stage=testing
```

</details>

### Task 19:

Update an ingress named `web-ingress` with the label `secure=true`
<details>
<summary>Solution</summary>

```bash
kubectl label ing web-ingress secure=true
```
</details>

### Task 20:

Add a label `release=canary` to a stateful set named `db`
<details>
<summary>Solution</summary>

```bash
kubectl label statefulset db release=canary
```
</details>

### Task 21:

Update a pod named `frontend` with the label `version=1.0.0` ensuring the key and value are within 63 characters
<details>
<summary>Solution</summary>

```bash
kubectl label pods frontend version=1.0.0
```
</details>

### Task 22:

Update a deployment named `api-server` with the label `example.com/app=production`
<details>
<summary>Solution</summary>

```bash
kubectl label deployments api-server example.com/app=production
```
</details>

### Task 23:

Update a service named `web-service` with the label `env=production` and overwrite any existing value
<details>
<summary>Solution</summary>

```bash
kubectl label --overwrite services web-service env=production
```
</details>

### Task 24:

Update all pods with the label `status=active` ensuring not to overwrite existing labels
<details>
<summary>Solution</summary>

```bash
kubectl label pods --all status=active
```
</details>

### Task 25:

Update a config map identified by the type and name in `config.json` with the label `tier=backend`
<details>
<summary>Solution</summary>

```bash
kubectl label -f config.json tier=backend
```
</details>

### Task 26:

Update a pod named `metrics-server` with the label `version=2.11` only if the resource is unchanged from version 3
<details>
<summary>Solution</summary>

```bash
kubectl label pods metrics-server version=2.11 --resource-version=3
```
</details>

### Task 27:

Add a label `team=frontend` to a pod named `client-app`, overwriting any existing value if necessary
<details>
<summary>Solution</summary>

```bash
kubectl label --overwrite pods client-app team=frontend
```
</details>

### Task 28:

Remove a label named `debug` from a pod named `cache-server`
<details>
<summary>Solution</summary>

```bash
kubectl label pods cache-server debug-
```
</details>

### Task 29:

Update a pod named `database` with a DNS subdomain prefix label `example.org/role=db`
<details>
<summary>Solution</summary>

```bash
kubectl label pods database example.org/role=db
```
</details>

### Task 30:

Update a pod named `analytics` with the label `version=1.1.1`, ensuring the value follows the allowed character set
<details>
<summary>Solution</summary>

```bash
kubectl label pods analytics version=1.1.1
```
</details>

### Task 31:

Add a label `stage=prod` to all services with the label `app=nginx`
<details>
<summary>Solution</summary>

```bash
kubectl label services -l app=nginx stage=prod
```
</details>

### Task 32:

Update a pod named `web-backend` with the label `env=staging` only if it currently has no such label
<details>
<summary>Solution</summary>

```bash
kubectl label pods web-backend env=staging --overwrite=false
```
</details>

### Task 33:

Update a stateful set named `db` with the label `team=database`, ensuring the key does not exceed 63 characters
<details>
<summary>Solution</summary>

```bash
kubectl label statefulset db team=database
```
</details>

### Task 34:

Add a label `project=alpha` to a node named `worker-1`, ensuring the key begins with a letter
<details>
<summary>Solution</summary>

```bash
kubectl label nodes worker-1 project=alpha
```
</details>

### Task 35:

Update a service named `auth-service` with a complex label `auth.example.com/version=2.0`
<details>
<summary>Solution</summary>

```bash
kubectl label services auth-service auth.example.com/version=2.0
```
</details>

### Task 36:

Remove a label named `obsolete` from all pods in the namespace
<details>
<summary>Solution</summary>

```bash
kubectl label pods --all obsolete-
```
</details>

### Task 37:

Update a deployment named `nginx-deployment` with the label `release=stable`, ensuring the key starts with a letter
<details>
<summary>Solution</summary>

```bash
kubectl label deployments nginx-deployment release=stable
```
</details>

### Task 38:

Add a label `region=us-east-1` to all persistent volume claims, overwriting existing values if necessary
<details>
<summary>Solution</summary>

```bash
kubectl label --overwrite pvc --all region=us-east-1
```
</details>

### Task 39:

Update a daemonset named `logging-daemon` with the label `log-level=verbose`
<details>
<summary>Solution</summary>

```bash
kubectl label daemonset logging-daemon log-level=verbose
```
</details>

### Task 40:

Update an ingress named `main-ingress` with the label `secured=true`, ensuring not to overwrite existing labels
<details>
<summary>Solution</summary>

```bash
kubectl label --overwrite=false ing main-ingress secured=true
```
</details>
