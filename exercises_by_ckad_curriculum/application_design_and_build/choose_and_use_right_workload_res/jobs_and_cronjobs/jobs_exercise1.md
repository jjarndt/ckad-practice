### Task 1:

Create a Job named `counter` in the `default` namespace using the `nginx:1.25.1` image. The Job should run a container that executes the following bash command:
```bash
/bin/sh -c 'counter=0; while [ $counter -lt 3 ]; do counter=$((counter+1)); echo "$counter"; sleep 3; done;'
```
The container should not restart on failure.

The solution can be checked with the following kubectl command:
```bash
kubectl get job counter -o yaml
kubectl logs job/counter
```

<details>
<summary>Solution</summary>

```bash
apiVersion: batch/v1
kind: Job
metadata:
  name: counter
spec:
  template:
    spec:
      containers:
      - name: counter
        image: nginx:1.25.1
        command:
        - /bin/sh
        - -c
        - counter=0; while [ $counter -lt 3 ]; do counter=$((counter+1)); echo "$counter"; sleep 3; done;
      restartPolicy: Never
```
</details>
