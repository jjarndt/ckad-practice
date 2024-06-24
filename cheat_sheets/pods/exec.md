
### Kubernetes Cheat Sheet: Executing Commands in Containers

#### Open a Shell in a Running Container
To open a shell inside a running container, use the following command:
```sh
$ kubectl exec -it <pod-name> -- /bin/sh
```
- `-it`: Combines the `-i` (interactive) and `-t` (tty) flags to allow for interactive shell access.
- `<pod-name>`: The name of the pod you want to access.
- `-- /bin/sh`: Specifies the command to run inside the container (in this case, opening a shell).

**Example:**
```sh
$ kubectl exec -it hazelcast -- /bin/sh
```

#### Execute a Single Command in a Container
To execute a single command inside a container without opening an interactive shell, use:
```sh
$ kubectl exec <pod-name> -- <command>
```
- `<pod-name>`: The name of the pod.
- `-- <command>`: The command you want to run inside the container.

**Example:**
To render the environment variables:
```sh
$ kubectl exec hazelcast -- env
```

#### Additional Examples:
1. **Listing Files in a Container:**
   ```sh
   $ kubectl exec <pod-name> -- ls /path/to/directory
   ```

2. **Checking the Process Status:**
   ```sh
   $ kubectl exec <pod-name> -- ps aux
   ```

3. **Viewing Container Logs:**
   ```sh
   $ kubectl exec <pod-name> -- cat /var/log/app.log
   ```

4. **Testing Network Connectivity:**
   ```sh
   $ kubectl exec <pod-name> -- ping <hostname>
   ```

#### Notes:
- **Resource Type Not Required**: You do not need to specify the resource type (like pod, deployment) since `kubectl exec` works only for pods.
- **Separation with `--`**: The `--` separates the `exec` command options from the command you want to run inside the container.
