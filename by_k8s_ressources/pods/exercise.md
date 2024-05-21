You are the lead Kubernetes engineer for a cutting-edge scientific research organization called "Stellar Research Institute." The institute has a multi-node Kubernetes cluster used for running various microservices and data processing workloads related to space exploration. Your tasks will revolve around creating and managing Pods in this cluster to ensure seamless data processing, communication, and deployment of research applications.

**Scenario: The Data Ingestor Pod**

The first task involves setting up a critical data ingestor Pod. This Pod will collect data from various satellites and preprocess it before forwarding it to different processing units.

---

### Task 1: Create the Data Ingestor Pod

Create a Pod named `data-ingestor` in the `research-namespace` namespace. This Pod should have two containers:
- The first container named `data-collector` using the image `busybox`, which runs a continuous loop with the command `while true; do echo 'Collecting Data'; sleep 5; done`.
- The second container named `data-preprocessor` using the image `alpine`, which also runs a continuous loop with the command `while true; do echo 'Preprocessing Data'; sleep 5; done`.

---

### Task 2: Implement a Blue/Green Deployment Strategy for the Data Ingestor Pod

Modify the existing setup of the `data-ingestor` Pod to follow a blue/green deployment strategy. To achieve this, create a new version of the `data-ingestor` Pod, named `data-ingestor-green`. The new Pod should be in the same namespace (`research-namespace`) and include the following updates:

- The `data-collector` container should use the image `busybox:latest`.
- The `data-preprocessor` container should use the image `alpine:latest`.

Ensure that both versions of the Pod, `data-ingestor` (blue) and `data-ingestor-green` (green), are running simultaneously without affecting each other's operations. After verifying that the `data-ingestor-green` Pod is functioning correctly, delete the original `data-ingestor` Pod.

Use the following commands to verify the successful setup and transition to the new `data-ingestor-green` Pod:

```bash
kubectl get pods -n research-namespace
kubectl describe pod data-ingestor-green -n research-namespace
kubectl logs data-ingestor-green -n research-namespace -c data-collector --tail=10
kubectl logs data-ingestor-green -n research-namespace -c data-preprocessor --tail=10
kubectl delete pod data-ingestor -n research-namespace
```

### Task 3: Implement Resource Limits and Requests for the Data Ingestor Pod

To ensure that the `data-ingestor` Pod and its containers run efficiently without exhausting cluster resources, implement resource limits and requests. You need to update the `data-ingestor-green` Pod to include resource specifications for both containers.

#### Specifications:
- **data-collector** container:
    - Requests: 100m CPU, 128Mi memory
    - Limits: 200m CPU, 256Mi memory

- **data-preprocessor** container:
    - Requests: 150m CPU, 256Mi memory
    - Limits: 300m CPU, 512Mi memory

Update the Pod definition with these resource constraints and reapply the configuration to ensure it takes effect.

Verify the resource requests and limits by using the following commands:

```bash
kubectl describe pod data-ingestor-green -n research-namespace
```

Ensure that the output shows the correct resource requests and limits for both containers within the `data-ingestor-green` Pod.

### Task 4: Configure Liveness and Readiness Probes for the Data Ingestor Pod

To ensure that the `data-ingestor-green` Pod is both healthy and ready to handle traffic, you need to configure liveness and readiness probes for both containers. These probes will help Kubernetes manage the Pod's lifecycle more effectively.

#### Specifications:

- **Liveness Probe** for `data-collector` container:
    - Type: HTTP GET
    - Path: `/healthz`
    - Port: `8080`
    - Initial delay: `10 seconds`
    - Period: `5 seconds`
    - Timeout: `2 seconds`
    - Failure threshold: `3`

- **Readiness Probe** for `data-collector` container:
    - Type: HTTP GET
    - Path: `/ready`
    - Port: `8080`
    - Initial delay: `5 seconds`
    - Period: `3 seconds`
    - Timeout: `1 second`
    - Failure threshold: `3`

- **Liveness Probe** for `data-preprocessor` container:
    - Type: EXEC command
    - Command: `["/bin/sh", "-c", "ps aux | grep 'preprocess' | grep -v grep"]`
    - Initial delay: `15 seconds`
    - Period: `10 seconds`
    - Timeout: `3 seconds`
    - Failure threshold: `3`

- **Readiness Probe** for `data-preprocessor` container:
    - Type: EXEC command
    - Command: `["/bin/sh", "-c", "test -f /tmp/ready"]`
    - Initial delay: `10 seconds`
    - Period: `5 seconds`
    - Timeout: `1 second`
    - Failure threshold: `3`

Update the Pod definition with these probe configurations and reapply the configuration to ensure it takes effect.

Verify the probes are correctly configured and functioning by using the following commands:

```bash
kubectl describe pod data-ingestor-green -n research-namespace
kubectl get pod data-ingestor-green -n research-namespace -o jsonpath='{.status.containerStatuses[*].state}'
```

Ensure the liveness and readiness states reflect the correct status for both containers within the `data-ingestor-green` Pod.


### Task 5: Handle Pod Lifecycle Events with Init Containers and PreStop Hooks

To ensure that the `data-ingestor-green` Pod handles initialization and termination gracefully, you need to configure an Init Container and a PreStop hook. The Init Container will set up necessary prerequisites before the main containers start, and the PreStop hook will ensure proper cleanup before the Pod terminates.

#### Specifications:

- **Init Container**:
    - Name: `init-setup`
    - Image: `busybox`
    - Command: `["/bin/sh", "-c", "echo Initializing; sleep 10; echo Initialization complete"]`

- **PreStop Hook** for `data-collector` container:
    - Type: EXEC command
    - Command: `["/bin/sh", "-c", "echo PreStop Hook Triggered; sleep 10"]`

- **PreStop Hook** for `data-preprocessor` container:
    - Type: HTTP GET
    - Path: `/shutdown`
    - Port: `8080`

Update the `data-ingestor-green` Pod definition with the Init Container and PreStop hooks and reapply the configuration to ensure it takes effect.

Verify the Init Container and PreStop hooks by using the following commands:

```bash
kubectl describe pod data-ingestor-green -n research-namespace
kubectl logs data-ingestor-green -n research-namespace -c init-setup --tail=10
kubectl delete pod data-ingestor-green -n research-namespace
```

Ensure that the Init Container runs and completes successfully before the main containers start, and observe the logs to verify that the PreStop hooks execute properly during Pod termination.

### Task 6: Verify and Monitor Pod Conditions

To ensure the `data-ingestor-green` Pod is operating correctly and efficiently, you need to verify and monitor its various PodConditions. These conditions help you understand the different states the Pod goes through during its lifecycle.

#### Steps:

1. **Check Pod Conditions**: Inspect the current conditions of the `data-ingestor-green` Pod. Ensure that the following conditions are met:
    - `PodScheduled`: The Pod has been scheduled to a node.
    - `Initialized`: All init containers have completed successfully.
    - `ContainersReady`: All containers in the Pod are ready.
    - `Ready`: The Pod is able to serve requests and should be added to the load balancing pools of all matching Services.

2. **Monitor Pod Conditions**: Implement a method to continuously check the status of these PodConditions to ensure they are consistently met.

Use the following commands to check the conditions of the `data-ingestor-green` Pod:

```bash
kubectl get pod data-ingestor-green -n research-namespace -o jsonpath='{.status.conditions[*]}'
kubectl describe pod data-ingestor-green -n research-namespace
```

### Expected Outcome:

Ensure that the output indicates that all specified conditions (`PodScheduled`, `Initialized`, `ContainersReady`, and `Ready`) are true for the `data-ingestor-green` Pod.
