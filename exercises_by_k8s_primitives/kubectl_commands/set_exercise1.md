### Task 1:

Set the nginx container image in the deployment `webapp` to 'nginx:1.19.0'
<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/webapp nginx=nginx:1.19.0
```
</details>

### Task 2:

Update all deployments' nginx container image to 'nginx:1.19.0'
<details>
<summary>Solution</summary>

```bash
kubectl set image deployments nginx=nginx:1.19.0 --all
```
</details>

### Task 3:

Update the image of all containers in the daemonset `monitoring` to 'busybox:1.31'
<details>
<summary>Solution</summary>

```bash
kubectl set image daemonset/monitoring *=busybox:1.31
```
</details>

### Task 4:

Print the result (in yaml format) of updating the nginx container image in a local file `my-deployment.yaml` without hitting the server
<details>
<summary>Solution</summary>

```bash
kubectl set image -f my-deployment.yaml nginx=nginx:1.19.0 --local -o yaml
```
</details>

### Task 5:

Update the nginx container image in the statefulset `db` to 'nginx:1.19.0'
<details>
<summary>Solution</summary>

```bash
kubectl set image statefulset/db nginx=nginx:1.19.0
```
</details>

### Task 6:

Update the image of the nginx container in the cronjob `backup` to 'nginx:1.19.0'
<details>
<summary>Solution</summary>

```bash
kubectl set image cronjob/backup nginx=nginx:1.19.0
```
</details>

### Task 7:

Update the nginx container image in all resources identified by the type and name in `resources.yaml`
<details>
<summary>Solution</summary>

```bash
kubectl set image -f resources.yaml nginx=nginx:1.19.0
```
</details>

### Task 8:

Update the busybox container image in the replication controller `frontend` to 'busybox:1.31'
<details>
<summary>Solution</summary>

```bash
kubectl set image rc/frontend busybox=busybox:1.31
```
</details>

### Task 1:

Set the nginx container image in the deployment `webapp` to 'nginx:1.19.0' in the `production` namespace, then get the details of the deployment
<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/webapp nginx=nginx:1.19.0 -n production
kubectl get deployment webapp -n production
```
</details>

### Task 2:

Update all deployments' nginx container image to 'nginx:1.19.0' across all namespaces, and verify the changes
<details>
<summary>Solution</summary>

```bash
kubectl set image deployments nginx=nginx:1.19.0 --all --all-namespaces
kubectl get deployments --all-namespaces -o wide
```
</details>

### Task 3:

Update the image of all containers in the daemonset `monitoring` to 'busybox:1.31' in the `monitoring` namespace, and describe the daemonset
<details>
<summary>Solution</summary>

```bash
kubectl set image daemonset/monitoring *=busybox:1.31 -n monitoring
kubectl describe daemonset monitoring -n monitoring
```
</details>

### Task 4:

Print the result (in yaml format) of updating the nginx container image in a local file `my-deployment.yaml` without hitting the server, and validate the file
<details>
<summary>Solution</summary>

```bash
kubectl set image -f my-deployment.yaml nginx=nginx:1.19.0 --local -o yaml
kubectl apply --dry-run=client -f my-deployment.yaml
```
</details>

### Task 5:

Update the nginx container image in the statefulset `db` to 'nginx:1.19.0' in the `database` namespace, and get the pods in that namespace
<details>
<summary>Solution</summary>

```bash
kubectl set image statefulset/db nginx=nginx:1.19.0 -n database
kubectl get pods -n database
```
</details>

### Task 6:

Update the image of the nginx container in the cronjob `backup` to 'nginx:1.19.0' in the `backup` namespace, and check the status of the cronjob
<details>
<summary>Solution</summary>

```bash
kubectl set image cronjob/backup nginx=nginx:1.19.0 -n backup
kubectl get cronjob backup -n backup
```
</details>

### Task 7:

Update the nginx container image in all resources identified by the type and name in `resources.yaml`, and list the resources
<details>
<summary>Solution</summary>

```bash
kubectl set image -f resources.yaml nginx=nginx:1.19.0
kubectl get -f resources.yaml
```
</details>

### Task 8:

Update the busybox container image in the replication controller `frontend` to 'busybox:1.31' in the `frontend` namespace, and scale the replication controller to 5 replicas
<details>
<summary>Solution</summary>

```bash
kubectl set image rc/frontend busybox=busybox:1.31 -n frontend
kubectl scale rc/frontend --replicas=5 -n frontend
```
</details>

### Task 9:

Set the container image for multiple containers in the deployment `multi-container` with nginx to 'nginx:1.19.0' and redis to 'redis:6.0' in the `services` namespace, then check the rollout status
<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/multi-container nginx=nginx:1.19.0 redis=redis:6.0 -n services
kubectl rollout status deployment/multi-container -n services
```
</details>

### Task 10:

Update the image of all containers in the statefulset `storage` to 'alpine:3.12' in the `storage` namespace, and restart the statefulset
<details>
<summary>Solution</summary>

```bash
kubectl set image statefulset/storage *=alpine:3.12 -n storage
kubectl rollout restart statefulset/storage -n storage
```
</details>
### Task 1:

Set the nginx container image in the deployment `webapp` to 'nginx:1.19.0', then get the details of the deployment
<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/webapp nginx=nginx:1.19.0
kubectl get deployment webapp -o wide
```
</details>

### Task 2:

Update all deployments' nginx container image to 'nginx:1.19.0' across all namespaces, and verify the changes
<details>
<summary>Solution</summary>

```bash
kubectl set image deployments nginx=nginx:1.19.0 --all --all-namespaces
kubectl get deployments --all-namespaces -o wide
```
</details>

### Task 3:

Update the image of all containers in the daemonset `monitoring` to 'busybox:1.31', and describe the daemonset
<details>
<summary>Solution</summary>

```bash
kubectl set image daemonset/monitoring *=busybox:1.31
kubectl describe daemonset monitoring
```
</details>

### Task 4:

Print the result (in yaml format) of updating the nginx container image in a local file `my-deployment.yaml` without hitting the server, and validate the file
<details>
<summary>Solution</summary>

```bash
kubectl set image -f my-deployment.yaml nginx=nginx:1.19.0 --local -o yaml
kubectl apply --dry-run=client -f my-deployment.yaml
```
</details>

### Task 5:

Update the nginx container image in the statefulset `db` to 'nginx:1.19.0', and get the pods in that statefulset
<details>
<summary>Solution</summary>

```bash
kubectl set image statefulset/db nginx=nginx:1.19.0
kubectl get pods -l app=db
```
</details>

### Task 6:

Update the image of the nginx container in the cronjob `backup` to 'nginx:1.19.0', and check the status of the cronjob
<details>
<summary>Solution</summary>

```bash
kubectl set image cronjob/backup nginx=nginx:1.19.0
kubectl get cronjob backup
```
</details>

### Task 7:

Update the nginx container image in all resources identified by the type and name in `resources.yaml`, and list the resources
<details>
<summary>Solution</summary>

```bash
kubectl set image -f resources.yaml nginx=nginx:1.19.0
kubectl get -f resources.yaml
```
</details>

### Task 8:

Update the busybox container image in the replication controller `frontend` to 'busybox:1.31', and scale the replication controller to 5 replicas
<details>
<summary>Solution</summary>

```bash
kubectl set image rc/frontend busybox=busybox:1.31
kubectl scale rc/frontend --replicas=5
```
</details>

### Task 9:

Set the container image for multiple containers in the deployment `multi-container` with nginx to 'nginx:1.19.0' and redis to 'redis:6.0', then check the rollout status
<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/multi-container nginx=nginx:1.19.0 redis=redis:6.0
kubectl rollout status deployment/multi-container
```
</details>

### Task 10:

Update the image of all containers in the statefulset `storage` to 'alpine:3.12', and restart the statefulset
<details>
<summary>Solution</summary>

```bash
kubectl set image statefulset/storage *=alpine:3.12
kubectl rollout restart statefulset/storage
```
</details>

### Task 11:

Update the image of all containers in the pod `test-pod` defined in `pod.yaml` to 'nginx:1.19.0', then apply the configuration
<details>
<summary>Solution</summary>

```bash
kubectl set image -f pod.yaml *=nginx:1.19.0
kubectl apply -f pod.yaml
```
</details>

### Task 12:

Set the busybox container image in the deployment `utility` to 'busybox:1.31' and perform a rolling restart
<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/utility busybox=busybox:1.31
kubectl rollout restart deployment/utility
```
</details>

### Task 13:

Update the nginx container image in the deployment `webapp` to 'nginx:1.20.0' and save the change to a file `updated-deployment.yaml`
<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/webapp nginx=nginx:1.20.0 --dry-run=client -o yaml > updated-deployment.yaml
```
</details>

### Task 14:

Update the image of the redis container in the statefulset `cache` to 'redis:6.2', and get the status of the statefulset
<details>
<summary>Solution</summary>

```bash
kubectl set image statefulset/cache redis=redis:6.2
kubectl get statefulset cache -o wide
```
</details>

### Task 1:

Update deployment 'registry' with a new environment variable `STORAGE_DIR=/local`, then describe the deployment
<details>
<summary>Solution</summary>

```bash
kubectl set env deployment/registry STORAGE_DIR=/local
kubectl describe deployment registry
```
</details>

### Task 2:

List the environment variables defined on a deployment 'sample-build', then get the details of the deployment
<details>
<summary>Solution</summary>

```bash
kubectl set env deployment/sample-build --list
kubectl get deployment sample-build -o wide
```
</details>

### Task 3:

List the environment variables defined on all pods, and get the status of all pods
<details>
<summary>Solution</summary>

```bash
kubectl set env pods --all --list
kubectl get pods -o wide
```
</details>

### Task 4:

Output modified deployment in YAML without altering the object on the server, and validate the output
<details>
<summary>Solution</summary>

```bash
kubectl set env deployment/sample-build STORAGE_DIR=/data -o yaml
kubectl apply --dry-run=client -f sample-build.yaml
```
</details>

### Task 5:

Update all containers in all replication controllers to have `ENV=prod`, and list the replication controllers
<details>
<summary>Solution</summary>

```bash
kubectl set env rc --all ENV=prod
kubectl get rc -o wide
```
</details>

### Task 6:

Import environment variables from a secret `mysecret` into deployment `myapp`, and describe the deployment
<details>
<summary>Solution</summary>

```bash
kubectl set env --from=secret/mysecret deployment/myapp
kubectl describe deployment myapp
```
</details>

### Task 7:

Import environment variables from a config map `myconfigmap` with a prefix `MYSQL_` into deployment `myapp`, and list the environment variables of the deployment
<details>
<summary>Solution</summary>

```bash
kubectl set env --from=configmap/myconfigmap --prefix=MYSQL_ deployment/myapp
kubectl set env deployment/myapp --list
```
</details>

### Task 8:

Import specific keys `my-example-key` from a config map `myconfigmap` into deployment `myapp`, and get the details of the deployment
<details>
<summary>Solution</summary>

```bash
kubectl set env --keys=my-example-key --from=configmap/myconfigmap deployment/myapp
kubectl get deployment myapp -o wide
```
</details>

### Task 9:

Remove the environment variable `ENV` from container `c1` in all deployment configs, and list the environment variables of the deployments
<details>
<summary>Solution</summary>

```bash
kubectl set env deployments --all --containers="c1" ENV-
kubectl set env deployments --all --list
```
</details>

### Task 10:

Remove the environment variable `ENV` from a deployment definition on disk `deploy.json` and update the deployment config on the server, then describe the deployment
<details>
<summary>Solution</summary>

```bash
kubectl set env -f deploy.json ENV-
kubectl apply -f deploy.json
kubectl describe -f deploy.json
```
</details>

### Task 11:

Set some of the local shell environment variables starting with `RAILS_` into a deployment config `registry` on the server, and list the environment variables of the deployment
<details>
<summary>Solution</summary>

```bash
env | grep RAILS_ | kubectl set env -e - deployment/registry
kubectl set env deployment/registry --list
```
</details>

### Task 12:

Update deployment 'frontend' with a new environment variable `DEBUG=true`, then get the logs of one of the pods in the deployment
<details>
<summary>Solution</summary>

```bash
kubectl set env deployment/frontend DEBUG=true
kubectl get pods -l app=frontend -o jsonpath='{.items[0].metadata.name}' | xargs kubectl logs
```
</details>

### Task 13:

Remove the environment variable `DEBUG` from deployment 'backend', and get the rollout status of the deployment
<details>
<summary>Solution</summary>

```bash
kubectl set env deployment/backend DEBUG-
kubectl rollout status deployment/backend
```
</details>

### Task 14:

Import environment variables from a secret `dbsecret` into a statefulset `database`, and get the status of the statefulset
<details>
<summary>Solution</summary>

```bash
kubectl set env --from=secret/dbsecret statefulset/database
kubectl get statefulset database -o wide
```
</details>

### Task 15:

Update all containers in all deployments to have `LOG_LEVEL=info`, and list the deployments
<details>
<summary>Solution</summary>

```bash
kubectl set env deployments --all LOG_LEVEL=info
kubectl get deployments -o wide
```
</details>
