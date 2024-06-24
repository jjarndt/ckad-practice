### Task 1: Create a Temporary Pod to List Environment Variables
**Objective:** Use the `kubectl run` command to create a temporary pod that lists all environment variables.

**Instructions:**
1. Use the `busybox` image version `1.36.1`.
2. Ensure the pod is automatically deleted after the command finishes.
3. The command to run inside the pod should be `env`.

**Solution:**
```sh
kubectl run busybox --image=busybox:1.36.1 --rm -it --restart=Never -- env
```

### Task 2: Create a Temporary Pod to Display Files in a Directory
**Objective:** Use the `kubectl run` command to create a temporary pod that lists files in the `/etc` directory.

**Instructions:**
1. Use the `busybox` image version `1.36.1`.
2. Ensure the pod is automatically deleted after the command finishes.
3. The command to run inside the pod should be `ls etc`.

**Solution:**
```sh
kubectl run busybox --image=busybox:1.36.1 --rm -it --restart=Never -- ls etc
```

### Task 3: Create a Temporary Pod to Check DNS Resolution
**Objective:** Use the `kubectl run` command to create a temporary pod that checks DNS resolution for a given domain (e.g., `example.com`).

**Instructions:**
1. Use the `busybox` image version `1.36.1`.
2. Ensure the pod is automatically deleted after the command finishes.
3. The command to run inside the pod should be `nslookup example.com`.

**Solution:**
```sh
kubectl run busybox --image=busybox:1.36.1 --rm -it --restart=Never -- nslookup example.com
```

### Task 4: Create a Temporary Pod to Fetch Data from a URL
**Objective:** Use the `kubectl run` command to create a temporary pod that fetches data from a specific URL (e.g., `http://example.com`).

**Instructions:**
1. Use the `curlimages/curl` image version `7.73.0`.
2. Ensure the pod is automatically deleted after the command finishes.
3. The command to run inside the pod should be `curl http://example.com`.

**Solution:**
```sh
kubectl run curlpod --image=curlimages/curl:7.73.0 --rm -it --restart=Never -- curl http://example.com
```

### Task 5: Create a Temporary Pod to Execute a Shell Command
**Objective:** Use the `kubectl run` command to create a temporary pod that starts an interactive shell session.

**Instructions:**
1. Use the `busybox` image version `1.36.1`.
2. Ensure the pod is automatically deleted after the shell session ends.
3. The command to run inside the pod should be `sh`.

**Solution:**
```sh
kubectl run busybox --image=busybox:1.36.1 --rm -it --restart=Never -- sh
```

### Task 6: Create a Temporary Pod to Inspect Pod Logs
**Objective:** Use the `kubectl run` command to create a temporary pod that inspects the logs of a specific pod (e.g., `mypod`).

**Instructions:**
1. Use the `busybox` image version `1.36.1`.
2. Ensure the pod is automatically deleted after the command finishes.
3. The command to run inside the pod should be `kubectl logs mypod`.

**Solution:**
```sh
kubectl run busybox --image=busybox:1.36.1 --rm -it --restart=Never -- kubectl logs mypod
```
