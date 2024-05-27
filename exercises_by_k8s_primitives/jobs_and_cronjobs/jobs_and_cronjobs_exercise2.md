### Task 1:

Define a Kubernetes Job YAML for a non-parallel job that uses the `busybox` image and runs the command `echo "Hello, Kubernetes!"`.

The solution can be checked with the following kubectl command:
```bash
kubectl get job my-non-parallel-job -o yaml
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: batch/v1
kind: Job
metadata:
  name: my-non-parallel-job
spec:
  template:
    spec:
      containers:
      - name: my-container
        image: busybox
        command: ["echo", "Hello, Kubernetes!"]
      restartPolicy: Never
EOF
```
</details>

### Task 2:

Create a Kubernetes Job YAML for a parallel job with a fixed completion count of 3. Use the `busybox` image and run the following command: `sh -c "echo Hello, Kubernetes! Index: $(expr $JOB_COMPLETION_INDEX + 1)"`. Based on the nature of the job, decide whether using `.spec.completionMode: "Indexed"` is appropriate and configure the job accordingly.

The solution can be checked with the following kubectl command:
```bash
kubectl get job parallel-job -o yaml
```

<details>
<summary>Solution</summary>

```bash
apiVersion: batch/v1
kind: Job
metadata:
  name: parallel-job
spec:
  completions: 3
  parallelism: 3
  completionMode: Indexed
  template:
    spec:
      containers:
      - name: job-container
        image: busybox
        command: ["sh", "-c", "echo Hello, Kubernetes! Index: $(expr $JOB_COMPLETION_INDEX + 1)"]
      restartPolicy: Never
```

#### Explanation:
The Indexed completion mode is necessary here because each Pod needs to execute a command that includes a unique index. This unique index allows each Pod to perform a distinct task or output a unique message. Without the Indexed mode, all Pods would execute the same command without any differentiation, which does not fulfill the task's requirement.
</details>

### Task 3:

Create a Kubernetes Job YAML for an Indexed Job with a fixed completion count of 5. Use the `busybox` image and run the following command: `sh -c "echo Hello, Kubernetes! Index: $(expr $JOB_COMPLETION_INDEX + 1)"`. Configure a success policy where the job is considered successful if at least 2 out of the Pods with indexes 0, 1, and 2 succeed. Ensure the JobSuccessPolicy feature gate is enabled in your cluster.

The solution can be checked with the following kubectl command:
```bash
kubectl get job indexed-job-with-success-policy -o yaml
```

<details>
<summary>Solution</summary>

```bash
apiVersion: batch/v1
kind: Job
metadata:
  name: indexed-job-with-success-policy
spec:
  completions: 5
  parallelism: 5
  completionMode: Indexed
  successPolicy:
    rules:
      - succeededIndexes: 0-2
        succeededCount: 2
  template:
    spec:
      containers:
      - name: job-container
        image: busybox
        command: ["sh", "-c", "echo Hello, Kubernetes! Index: $(expr $JOB_COMPLETION_INDEX + 1)"]
      restartPolicy: Never
```

### Explanation:
The task requires creating a Kubernetes Job that uses the `Indexed` completion mode and specifies a success policy. The success policy should declare the job as successful if at least 2 out of the Pods with indexes 0, 1, and 2 succeed. This feature requires the JobSuccessPolicy feature gate to be enabled in the cluster. The provided solution includes the necessary YAML configuration for the job and the success policy.

</details>

