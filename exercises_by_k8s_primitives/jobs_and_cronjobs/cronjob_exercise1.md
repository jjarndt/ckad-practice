### Task 1:

Create a CronJob named `current-date` in the `default` namespace that runs every minute and prints the current date using the `nginx:1.25.1` image. The CronJob should execute the command `/bin/sh -c 'echo "Current date: $(date)"'`.

The solution can be checked with the following kubectl command:
```bash
kubectl get cronjob current-date -o yaml
kubectl get jobs --watch
```

<details>
<summary>Solution</summary>

```bash
apiVersion: batch/v1
kind: CronJob
metadata:
  name: current-date
spec:
  schedule: "* * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: current-date
            image: nginx:1.25.1
            args:
            - /bin/sh
            - -c
            - 'echo "Current date: $(date)"'
          restartPolicy: OnFailure
```
</details>

### Task 2:

Create a CronJob named `current-date` in the `default` namespace that runs every minute and prints the current date using the `nginx:1.25.1` image. Ensure that the CronJob keeps up to 5 successful job history entries and 3 failed job history entries.

The solution can be checked with the following kubectl command:
```bash
kubectl get cronjob current-date -o yaml
kubectl describe cronjob current-date
```

<details>
<summary>Solution</summary>

```bash
apiVersion: batch/v1
kind: CronJob
metadata:
  name: current-date
spec:
  successfulJobsHistoryLimit: 5
  failedJobsHistoryLimit: 3
  schedule: "* * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: current-date
            image: nginx:1.25.1
            args:
            - /bin/sh
            - -c
            - 'echo "Current date: $(date)"'
          restartPolicy: OnFailure
```
</details>
