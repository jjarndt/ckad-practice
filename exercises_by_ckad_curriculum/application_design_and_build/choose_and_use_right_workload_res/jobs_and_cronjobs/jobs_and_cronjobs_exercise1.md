### Task 1:

Create a Job named `pi` that calculates the value of pi to 2000 decimal places using the Perl image `perl:5.34.0`. The Job should have the following attributes:

- `backoffLimit: 6`
- `completionMode: NonIndexed`
- `completions: 1`
- `parallelism: 1`
- `activeDeadlineSeconds: 10`

The solution can be checked with the following kubectl command:
```bash
kubectl get job pi -o yaml
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: batch/v1
kind: Job
metadata:
  name: pi
spec:
  backoffLimit: 6
  completionMode: NonIndexed
  completions: 1
  parallelism: 1
  activeDeadlineSeconds: 10
  template:
    spec:
      containers:
      - name: pi
        image: perl:5.34.0
        command: ["perl",  "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
EOF
```
</details>

### Task 2:

Create a CronJob named `pi-cron` that calculates the value of pi to 2000 decimal places using the Perl image `perl:5.34.0`. The CronJob should run every minute and have the following attributes:

- `concurrencyPolicy: Allow`
- `failedJobsHistoryLimit: 1`
- `schedule: '*/1 * * * *'`
- `successfulJobsHistoryLimit: 3`
- `startingDeadlineSeconds: 15`

The solution can be checked with the following kubectl command:
```bash
kubectl get cronjob pi-cron -o yaml
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: batch/v1
kind: CronJob
metadata:
  name: pi-cron
spec:
  concurrencyPolicy: Allow
  failedJobsHistoryLimit: 1
  schedule: '*/1 * * * *'
  successfulJobsHistoryLimit: 3
  startingDeadlineSeconds: 15
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: pi
            image: perl:5.34.0
            command: ["perl",  "-Mbignum=bpi", "-wle", "print bpi(2000)"]
          restartPolicy: OnFailure
EOF
```
</details>

### Task 3:

Given the following container specification:

```yaml
- name: random-generator
  image: alpine
  command: ["/bin/sh", "-c"]
  args: ["echo $((RANDOM % 100))"]
```

Create a Kubernetes Job named `random-generator-job` in the namespace `default` that uses this container specification to generate and print a random number between 0 and 100.

The solution can be checked with the following kubectl command:
```bash
kubectl logs job/random-generator-job
```

<details>
<summary>Solution</summary>

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: random-generator-job
  namespace: default
spec:
  template:
    spec:
      containers:
      - name: random-generator
        image: alpine
        command: ["/bin/sh", "-c"]
        args: ["echo $((RANDOM % 100))"]
      restartPolicy: Never
  backoffLimit: 4
```

```bash
kubectl apply -f - <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: random-generator-job
  namespace: default
spec:
  template:
    spec:
      containers:
      - name: random-generator
        image: alpine
        command: ["/bin/sh", "-c"]
        args: ["echo $((RANDOM % 100))"]
      restartPolicy: Never
  backoffLimit: 4
EOF
```
</details>

### Task 4:

Create a new Job named `random-generator-parallel-job` in the namespace `default` to be a parallel Job with a fixed completion count. Configure the Job to complete after 5 successful Pods have run, with a parallelism of 2. Ensure that each Pod generates and prints a random number between 0 and 100.

The solution can be checked with the following kubectl commands:
```bash
kubectl get job random-generator-parallel-job
kubectl get pods --selector=job-name=random-generator-parallel-job
kubectl logs job/random-generator-parallel-job
```

<details>
<summary>Solution</summary>

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: random-generator-parallel-job
  namespace: default
spec:
  completions: 5
  parallelism: 2
  template:
    spec:
      containers:
      - name: random-generator
        image: alpine
        command: ["/bin/sh", "-c"]
        args: ["echo $((RANDOM % 100))"]
      restartPolicy: Never
  backoffLimit: 4
```

```bash
kubectl apply -f - <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: random-generator-parallel-job
  namespace: default
spec:
  completions: 5
  parallelism: 2
  template:
    spec:
      containers:
      - name: random-generator
        image: alpine
        command: ["/bin/sh", "-c"]
        args: ["echo $((RANDOM % 100))"]
      restartPolicy: Never
  backoffLimit: 4
EOF
```
</details>

### Task 5:

Is it possible to modify the `completions` and `parallelism` values of an existing Kubernetes Job? If not, explain why and describe an alternative approach to achieving the desired changes.

The solution can be checked with the following kubectl commands:
```bash
kubectl describe job <job-name>
kubectl delete job <job-name>
```

<details>
<summary>Solution</summary>

No, it is not possible to modify the `completions` and `parallelism` values of an existing Kubernetes Job because these values are immutable once the Job is created.

### Alternative Approach:
To achieve the desired changes, you need to delete the existing Job and create a new Job with the updated specifications.

1. Delete the existing Job:
    ```bash
    kubectl delete job <existing-job-name>
    ```

2. Create a new Job with the updated `completions` and `parallelism` values:
    ```yaml
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: <new-job-name>
      namespace: default
    spec:
      completions: <desired-completions>
      parallelism: <desired-parallelism>
      template:
        spec:
          containers:
          - name: random-generator
            image: alpine
            command: ["/bin/sh", "-c"]
            args: ["echo $((RANDOM % 100))"]
          restartPolicy: Never
      backoffLimit: 4
    ```

    ```bash
    kubectl apply -f - <<EOF
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: <new-job-name>
      namespace: default
    spec:
      completions: <desired-completions>
      parallelism: <desired-parallelism>
      template:
        spec:
          containers:
          - name: random-generator
            image: alpine
            command: ["/bin/sh", "-c"]
            args: ["echo $((RANDOM % 100))"]
          restartPolicy: Never
      backoffLimit: 4
    EOF
    ```
</details>

### Task 6:

Create a Kubernetes Job named `resilient-random-generator-job` in the namespace `default` that uses the `alpine` image to generate and print a random number between 0 and 100. Configure the Job with a `restartPolicy` of `OnFailure` to handle container failures by restarting the container within the same Pod. Set the `backoffLimit` to 3 to limit the number of retries for failed Pods. To test the failure handling, simulate a container failure by exiting with a non-zero exit code.

Use the following container specification to simulate the failure:
```yaml
- name: random-generator
  image: alpine
  command: ["/bin/sh", "-c"]
  args: ["echo $((RANDOM % 100)); exit 1"]
```

The solution can be checked with the following kubectl commands:
```bash
kubectl get job resilient-random-generator-job
kubectl describe job resilient-random-generator-job
kubectl logs job/resilient-random-generator-job
```

<details>
<summary>Solution</summary>

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: resilient-random-generator-job
  namespace: default
spec:
  template:
    spec:
      containers:
      - name: random-generator
        image: alpine
        command: ["/bin/sh", "-c"]
        args: ["echo $((RANDOM % 100)); exit 1"] # Simulate failure for testing
      restartPolicy: OnFailure
  backoffLimit: 3
```

```bash
kubectl apply -f - <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: resilient-random-generator-job
  namespace: default
spec:
  template:
    spec:
      containers:
      - name: random-generator
        image: alpine
        command: ["/bin/sh", "-c"]
        args: ["echo $((RANDOM % 100)); exit 1"] # Simulate failure for testing
      restartPolicy: OnFailure
  backoffLimit: 3
EOF
```
</details>
