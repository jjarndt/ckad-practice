### Task 1:

Create a temporary pod named `debugger` using the `alpine:3.14` image. Inside this pod, execute the `ls /` command to list the contents of the root directory. Ensure the pod is automatically deleted after the command execution.


<details>
<summary>Solution</summary>

```bash
kubectl run debugger --image=alpine:3.14 --rm -it --restart=Never -- ls /
```
</details>

### Task 2:

Create a temporary pod named `diagnostics` using the `busybox:1.36.1` image. Execute the `date` command inside the pod to display the current date and time. Ensure the pod is automatically deleted after the command execution.


<details>
<summary>Solution</summary>

```bash
kubectl run diagnostics --image=busybox:1.36.1 --rm -it --restart=Never -- date
```
</details>

### Task 3:

Create a temporary pod named `test-pod` using the `alpine:3.14` image. Inside this pod, execute the `cat /etc/os-release` command to display the OS release information. Ensure the pod is automatically deleted after the command execution.


<details>
<summary>Solution</summary>

```bash
kubectl run test-pod --image=alpine:3.14 --rm -it --restart=Never -- cat /etc/os-release
```
</details>
