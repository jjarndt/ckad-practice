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
