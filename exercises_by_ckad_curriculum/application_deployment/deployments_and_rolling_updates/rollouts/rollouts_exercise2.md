### Task 1:

Create a deployment named `nginx-deployment` in the namespace `default` using the `nginx:1.14.2` image with 3 replicas. After creating the deployment, update the image to `nginx:1.16.1`. Ensure that the rollout history is recorded.

The solution can be checked with the following kubectl command:
```bash
kubectl rollout history deployment/nginx-deployment
```

<details>
<summary>Solution</summary>

```bash
kubectl create deployment nginx-deployment --image=nginx:1.14.2 --replicas=3
kubectl set image deployment/nginx-deployment nginx=nginx:1.16.1
```
</details>

### Task 2:

Create a DaemonSet named `abc` in the namespace `default` using the `nginx:1.14.2` image. Update the DaemonSet image twice: first to `nginx:1.16.1`, and then to `nginx:1.17.0`. After completing these updates, view the details of the DaemonSet revision 3.

The solution can be checked with the following kubectl command:
```bash
kubectl rollout history daemonset/abc --revision=3
```

<details>
<summary>Solution</summary>

```bash
kubectl create daemonset abc --image=nginx:1.14.2
kubectl set image daemonset/abc nginx=nginx:1.16.1
kubectl set image daemonset/abc nginx=nginx:1.17.0
kubectl rollout history daemonset/abc --revision=3
```
</details>
