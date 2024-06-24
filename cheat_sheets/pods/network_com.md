### Kubernetes Cheat Sheet: Using a Pod’s IP Address for Network Communication

#### Inspecting a Pod's IP Address
To find a Pod's IP address, use the `-o wide` option or describe the Pod.

**Get Pod's IP Address:**
```sh
$ kubectl get pod <pod-name> -o wide
```
- `<pod-name>`: The name of the pod.

**Example:**
```sh
$ kubectl run nginx --image=nginx:1.25.1 --port=80
$ kubectl get pod nginx -o wide
```
Output:
```sh
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          37s   10.244.0.5   minikube   <none>           <none>
```

**Describe Pod to Get IP Address:**
```sh
$ kubectl get pod <pod-name> -o yaml
```

**Example:**
```sh
$ kubectl get pod nginx -o yaml
```
Output (excerpt):
```yaml
status:
  podIP: 10.244.0.5
```

#### Verifying Pod Communication Using IP Address
Create a temporary Pod to communicate with another Pod using its IP address.

**Example:**
To call the IP address of a Pod using `wget`:
```sh
$ kubectl run busybox --image=busybox:1.36.1 --rm -it --restart=Never -- wget <pod-ip>:<port>
```
- `<pod-ip>`: The IP address of the target pod.
- `<port>`: The port number to connect to.

**Example Command:**
```sh
$ kubectl run busybox --image=busybox:1.36.1 --rm -it --restart=Never -- wget 10.244.0.5:80
```
Output:
```sh
Connecting to 10.244.0.5:80 (10.244.0.5:80)
saving to 'index.html'
index.html           100% |********************************|   615  0:00:00 ETA
'index.html' saved
pod "busybox" deleted
```

#### Key Points:
- **Unique IP Addresses**: Each Pod gets a unique IP address, assigned from a subnet dedicated to each node.
- **Temporary Pods**: Use temporary Pods for tasks like verifying network communication.
- **Dynamic IPs**: Pod IP addresses are not stable and can change after a Pod restart, hence they are often referred to as virtual IP addresses.
