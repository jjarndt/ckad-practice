### Task 1:

Create a new namespace named `task-namespace`. Within this namespace, deploy a Deployment named `task-deployment` using the `nginx:latest` image. This Deployment should have 3 replicas, and each Pod should be labeled with `app=task-app`. Additionally, deploy a Job named `task-job` in the `task-namespace`, which runs a single Pod using the `busybox` image. This Job should execute the command `echo "Task completed"` and then exit. Next, update the Deployment to use the `nginx:alpine` image, ensuring that the rollout occurs with zero downtime. Finally, verify that the Pods are running with the new image and confirm that the logs of the Job Pod contain the message "Task completed".

The solution can be checked with the following kubectl command:

```bash
kubectl get ns task-namespace
kubectl get deployments -n task-namespace
kubectl get pods -n task-namespace -l app=task-app
kubectl describe deployment task-deployment -n task-namespace
kubectl logs -n task-namespace job/task-job
kubectl rollout status deployment/task-deployment -n task-namespace
```

<details>
<summary>Solution</summary>

```bash
# Create the namespace
kubectl create namespace task-namespace

# Create the deployment
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: task-deployment
  namespace: task-namespace
spec:
  replicas: 3
  selector:
    matchLabels:
      app: task-app
  template:
    metadata:
      labels:
        app: task-app
    spec:
      containers:
      - name: nginx
        image: nginx:latest
EOF

# Create the job
kubectl apply -f - <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: task-job
  namespace: task-namespace
spec:
  template:
    spec:
      containers:
      - name: busybox
        image: busybox
        command: ["sh", "-c", "echo 'Task completed'"]
      restartPolicy: Never
  backoffLimit: 1
EOF

# Update the deployment to use nginx:alpine
kubectl set image deployment/task-deployment nginx=nginx:alpine -n task-namespace

# Wait for the rollout to complete
kubectl rollout status deployment/task-deployment -n task-namespace

# Check the logs of the job pod
job_pod=$(kubectl get pods -n task-namespace -l job-name=task-job -o jsonpath='{.items[0].metadata.name}')
kubectl logs -n task-namespace $job_pod
```
</details>

### Task 2:

Create a new namespace called `autoscale-namespace`. Within this namespace, deploy a Deployment named `sidecar-deployment` using the `nginx:alpine` image. This Deployment should have 2 replicas, and each Pod should have a label `app=sidecar-app`. Add a sidecar container to this Deployment that uses the `busybox` image and runs the command `["sh", "-c", "while true; do echo 'Sidecar running'; sleep 30; done"]`.

Next, create a Horizontal Pod Autoscaler (HPA) for the `sidecar-deployment` that scales the number of replicas between 2 and 5 based on CPU utilization, targeting 50% average CPU usage.

In the same namespace, deploy a Job named `trigger-hpa-job` that runs a single Pod using the `busybox` image. This Job should run the command `["sh", "-c", "for i in $(seq 1 5); do wget -q -O- http://sidecar-deployment; sleep 10; done"]` to simulate load and trigger the autoscaler.

Finally, verify the autoscaler is working by checking the number of replicas has increased and ensure the sidecar container logs are being generated as expected.

The solution can be checked with the following kubectl command:

```bash
kubectl get ns autoscale-namespace
kubectl get deployments -n autoscale-namespace
kubectl get hpa -n autoscale-namespace
kubectl get pods -n autoscale-namespace -l app=sidecar-app
kubectl describe deployment sidecar-deployment -n autoscale-namespace
kubectl logs -n autoscale-namespace -l app=sidecar-app -c busybox
kubectl logs -n autoscale-namespace job/trigger-hpa-job
```

<details>
<summary>Solution</summary>

```bash
# Create the namespace
kubectl create namespace autoscale-namespace

# Create the deployment with sidecar
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sidecar-deployment
  namespace: autoscale-namespace
spec:
  replicas: 2
  selector:
    matchLabels:
      app: sidecar-app
  template:
    metadata:
      labels:
        app: sidecar-app
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
      - name: busybox
        image: busybox
        command: ["sh", "-c", "while true; do echo 'Sidecar running'; sleep 30; done"]
EOF

# Create the Horizontal Pod Autoscaler
kubectl autoscale deployment sidecar-deployment --cpu-percent=50 --min=2 --max=5 -n autoscale-namespace

# Create the job to trigger HPA
kubectl apply -f - <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: trigger-hpa-job
  namespace: autoscale-namespace
spec:
  template:
    spec:
      containers:
      - name: busybox
        image: busybox
        command: ["sh", "-c", "for i in $(seq 1 5); do wget -q -O- http://sidecar-deployment; sleep 10; done"]
      restartPolicy: Never
  backoffLimit: 1
EOF

# Wait for a few minutes to allow HPA to scale the deployment

# Verify the number of replicas has increased
kubectl get hpa -n autoscale-namespace
kubectl get deployment sidecar-deployment -n autoscale-namespace

# Check the logs of the sidecar container
sidecar_pod=$(kubectl get pods -n autoscale-namespace -l app=sidecar-app -o jsonpath='{.items[0].metadata.name}')
kubectl logs -n autoscale-namespace $sidecar_pod -c busybox

# Check the logs of the job pod
job_pod=$(kubectl get pods -n autoscale-namespace -l job-name=trigger-hpa-job -o jsonpath='{.items[0].metadata.name}')
kubectl logs -n autoscale-namespace $job_pod
```
</details>

### Task 3:

Create a new deployment named "apache-server" using the image "httpd:2.4.46". The container should listen on port 8080 and be located in the namespace "web-apps".

Configure a Horizontal Pod Autoscaler for this deployment to scale based on a CPU utilization of 50%. The minimum number of pods should be 2 and the maximum number should be 5.

Check the CPU utilization of the deployment and ensure that the autoscaling is working by conducting a load simulation. For this, use a temporary pod that uses the image "busybox:1.36.1" and generates artificial traffic to the apache-server using a shell script (with a loop and curl commands).

Verify the current autoscaling configuration and the number of running pods.

Add the environment variables SERVER_ADMIN=admin@example.com and SERVER_NAME=myApacheServer to the containers of the apache-server deployment.

Open a shell for one of the Apache containers and check the header information of an HTTP request with the command `curl -I localhost:8080`. Then exit the container.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment apache-server -n web-apps
kubectl get hpa apache-server -n web-apps
kubectl get pods -n web-apps
kubectl exec -it <apache-pod-name> -n web-apps -- curl -I localhost:8080
```

<details>
<summary>Solution</summary>

```bash
# Create namespace
kubectl create namespace web-apps

# Create deployment with environment variables
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: apache-server
  namespace: web-apps
spec:
  replicas: 2
  selector:
    matchLabels:
      app: apache-server
  template:
    metadata:
      labels:
        app: apache-server
    spec:
      containers:
      - name: apache-container
        image: httpd:2.4.46
        ports:
        - containerPort: 8080
        env:
        - name: SERVER_ADMIN
          value: "admin@example.com"
        - name: SERVER_NAME
          value: "myApacheServer"
        resources:
          requests:
            cpu: "100m"
          limits:
            cpu: "200m"
EOF

# Create Horizontal Pod Autoscaler
kubectl autoscale deployment apache-server --cpu-percent=50 --min=2 --max=5 -n web-apps

# Verify the deployment and HPA
kubectl get deployment apache-server -n web-apps
kubectl get hpa apache-server -n web-apps

# Simulate load using busybox pod
kubectl run -i --tty load-generator --image=busybox:1.36.1 --restart=Never -n web-apps -- /bin/sh -c "while true; do wget -q -O- http://apache-server.web-apps.svc.cluster.local:8080; done"

# Check the number of running pods
kubectl get pods -n web-apps

# Open a shell to one of the Apache containers
kubectl exec -it $(kubectl get pods -n web-apps -l app=apache-server -o jsonpath='{.items[0].metadata.name}') -n web-apps -- /bin/bash

# Inside the Apache container, check the HTTP headers
curl -I localhost:8080

# Exit the container
exit
```
</details>
