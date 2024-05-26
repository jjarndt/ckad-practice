### Task 1:

Create a DaemonSet named `log-collector` in the `default` namespace. The DaemonSet should use the `busybox` image and run a shell command that prints "Collecting logs..." every 5 seconds.

The solution can be checked with the following kubectl command:
```bash
kubectl get daemonset log-collector -o jsonpath='{.spec.template.spec.containers[0].image}' | grep 'busybox' && \
kubectl get daemonset log-collector -o jsonpath='{.spec.template.spec.containers[0].command}' | grep 'Collecting logs...'
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: log-collector
  namespace: default
spec:
  selector:
    matchLabels:
      name: log-collector
  template:
    metadata:
      labels:
        name: log-collector
    spec:
      containers:
      - name: log-collector
        image: busybox
        command: ["sh", "-c", "while true; do echo 'Collecting logs...'; sleep 5; done"]
EOF
```
</details>

### Task 2:

Update the `log-collector` DaemonSet to run the `busybox` container with the `latest` tag instead of the default tag.

The solution can be checked with the following kubectl command:
```bash
kubectl get daemonset log-collector -o jsonpath='{.spec.template.spec.containers[0].image}' | grep 'busybox:latest'
```

<details>
<summary>Solution</summary>

```bash
kubectl set image daemonset/log-collector log-collector=busybox:latest
```
</details>

### Task 3:

Configure the `log-collector` DaemonSet to run only on nodes with the label `logging=true`.

The solution can be checked with the following kubectl command:
```bash
kubectl get daemonset log-collector -o jsonpath='{.spec.template.spec.nodeSelector.logging}' | grep 'true'
```

<details>
<summary>Solution</summary>

```bash
kubectl patch daemonset log-collector -p '{"spec": {"template": {"spec": {"nodeSelector": {"logging": "true"}}}}}'
```
</details>

### Task 4:

Add a liveness probe to the `log-collector` DaemonSet that checks if the container is running by executing the command `pgrep sh` every 10 seconds, with an initial delay of 15 seconds.

The solution can be checked with the following kubectl command:
```bash
kubectl get daemonset log-collector -o jsonpath='{.spec.template.spec.containers[0].livenessProbe.exec.command}' | grep 'pgrep sh' && \
kubectl get daemonset log-collector -o jsonpath='{.spec.template.spec.containers[0].livenessProbe.initialDelaySeconds}' | grep '15' && \
kubectl get daemonset log-collector -o jsonpath='{.spec.template.spec.containers[0].livenessProbe.periodSeconds}' | grep '10'
```

<details>
<summary>Solution</summary>

```bash
kubectl patch daemonset log-collector -p '{
  "spec": {
    "template": {
      "spec": {
        "containers": [
          {
            "name": "log-collector",
            "livenessProbe": {
              "exec": {
                "command": ["pgrep", "sh"]
              },
              "initialDelaySeconds": 15,
              "periodSeconds": 10
            }
          }
        ]
      }
    }
  }
}'
```
</details>
