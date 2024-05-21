### Task 1:

Create a ReplicaSet named `frontend` that manages three replicas of a Pod running the `nginx:latest` image. Ensure that the Pods are labeled with `app=frontend`.

The solution can be checked with the following kubectl command:
```bash
kubectl get replicaset frontend -o yaml | grep -A 3 'spec:' | grep replicas: && kubectl get pods -l app=frontend --field-selector=status.phase=Running | wc -l
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: nginx
        image: nginx:latest
EOF
```
</details>

### Task 2:

Update the `frontend` ReplicaSet to use the `nginx:1.19` image instead of the `nginx:latest` image. Ensure that the change is applied without deleting the existing ReplicaSet.

The solution can be checked with the following kubectl command:
```bash
kubectl get replicaset frontend -o yaml | grep 'image: nginx:1.19' && kubectl get pods -l app=frontend -o jsonpath='{.items[*].spec.containers[*].image}'
```

<details>
<summary>Solution</summary>

```bash
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: nginx
        image: nginx:1.19
EOF
```
</details>

### Task 3:

Create a new Namespace called `production`, and deploy the `frontend` ReplicaSet (with `nginx:1.19` image) into this namespace.

The solution can be checked with the following kubectl command:
```bash
kubectl get ns production && kubectl get replicaset frontend -n production -o yaml | grep 'image: nginx:1.19' && kubectl get pods -n production -l app=frontend --field-selector=status.phase=Running | wc -l
```

<details>
<summary>Solution</summary>

```bash
# Create the namespace
kubectl create namespace production

# Deploy the ReplicaSet into the 'production' namespace
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  namespace: production
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: nginx
        image: nginx:1.19
EOF
```
</details>

### Task 4:

Scale the `frontend` ReplicaSet in the `production` namespace to five replicas. Ensure that all five replicas are running.

The solution can be checked with the following kubectl command:
```bash
kubectl get replicaset frontend -n production -o yaml | grep 'replicas: 5' && kubectl get pods -n production -l app=frontend --field-selector=status.phase=Running | wc -l
```

<details>
<summary>Solution</summary>

```bash
kubectl scale replicaset frontend --replicas=5 -n production
```
</details>

### Task 5:

Add a readiness probe to the Pods in the `frontend` ReplicaSet in the `production` namespace. The readiness probe should check if the `nginx` container is responding on port 80 with the path `/`. The initial delay for the probe should be 5 seconds, the period should be 10 seconds.

The solution can be checked with the following kubectl command:
```bash
kubectl get replicaset frontend -n production -o yaml | grep -A 10 'readinessProbe' && kubectl describe pod -n production -l app=frontend | grep 'Readiness probe'
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  namespace: production
spec:
  replicas: 5
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: nginx
        image: nginx:1.19
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
EOF
```
</details>

### Task 6:

Isolate one of the Pods managed by the `frontend` ReplicaSet in the `production` namespace from receiving traffic by adding a taint to the node it is running on. The taint should be `key=isolated`, `value=true`, and `effect=NoSchedule`. Ensure the isolated Pod is not deleted or rescheduled, and verify the taint has been applied.

The solution can be checked with the following kubectl command:
```bash
kubectl get pods -n production -l app=frontend -o jsonpath='{.items[0].spec.nodeName}' && kubectl describe node $(kubectl get pods -n production -l app=frontend -o jsonpath='{.items[0].spec.nodeName}') | grep 'isolated=true:NoSchedule'
```

<details>
<summary>Solution</summary>

```bash
# Get the name of one of the pods in the frontend ReplicaSet
POD_NAME=$(kubectl get pods -n production -l app=frontend -o jsonpath='{.items[0].metadata.name}')

# Get the node on which this pod is running
NODE_NAME=$(kubectl get pod $POD_NAME -n production -o jsonpath='{.spec.nodeName}')

# Apply a taint to this node
kubectl taint nodes $NODE_NAME isolated=true:NoSchedule

# The pod should not be deleted or rescheduled since taints don't affect already running pods
```
</details>

### Task 7:

Delete the `frontend` ReplicaSet in the `production` namespace along with all its Pods. Ensure that both the ReplicaSet and its associated Pods are completely removed from the cluster.

The solution can be checked with the following kubectl command:
```bash
kubectl get replicaset frontend -n production && kubectl get pods -n production -l app=frontend
```

<details>
<summary>Solution</summary>

```bash
# Delete the frontend ReplicaSet and its Pods
kubectl delete replicaset frontend -n production

# Verify the ReplicaSet and its Pods are deleted
kubectl get replicaset frontend -n production
kubectl get pods -n production -l app=frontend
```
</details>

### Task 8:

Update the `frontend` ReplicaSet in the `production` namespace to include an additional label `environment=production` for the Pods it manages. Ensure the ReplicaSet's selector is also updated to match this new label, and verify that the Pods have the new label.

The solution can be checked with the following kubectl command:
```bash
kubectl get replicaset frontend -n production -o yaml | grep 'environment: production' && kubectl get pods -n production -l app=frontend -l environment=production
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  namespace: production
spec:
  replicas: 5
  selector:
    matchLabels:
      app: frontend
      environment: production
  template:
    metadata:
      labels:
        app: frontend
        environment: production
    spec:
      containers:
      - name: nginx
        image: nginx:1.19
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
EOF

# Update existing Pods to include the new label
POD_NAMES=$(kubectl get pods -n production -l app=frontend -o jsonpath='{.items[*].metadata.name}')
for POD in $POD_NAMES; do
  kubectl label pod $POD -n production environment=production --overwrite
done
```
</details>

### Task 9:

Perform a rollback of the `frontend` ReplicaSet in the `production` namespace to its previous state with the `nginx:latest` image. Ensure the ReplicaSet and its Pods are reverted to use the `nginx:latest` image.

The solution can be checked with the following kubectl command:
```bash
kubectl get replicaset frontend -n production -o yaml | grep 'image: nginx:latest' && kubectl get pods -n production -l app=frontend -o jsonpath='{.items[*].spec.containers[*].image}'
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  namespace: production
spec:
  replicas: 5
  selector:
    matchLabels:
      app: frontend
      environment: production
  template:
    metadata:
      labels:
        app: frontend
        environment: production
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
EOF
```
</details>

### Task 10:

Add resource requests and limits to the `frontend` ReplicaSet in the `production` namespace. Set the resource requests for CPU to `100m` and memory to `200Mi`, and limits for CPU to `200m` and memory to `400Mi`.

The solution can be checked with the following kubectl command:
```bash
kubectl get replicaset frontend -n production -o yaml | grep -A 6 'resources:'
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  namespace: production
spec:
  replicas: 5
  selector:
    matchLabels:
      app: frontend
      environment: production
  template:
    metadata:
      labels:
        app: frontend
        environment: production
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        resources:
          requests:
            cpu: "100m"
            memory: "200Mi"
          limits:
            cpu: "200m"
            memory: "400Mi"
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
EOF
```
</details>

### Task 11:

Create a Pod Disruption Budget (PDB) for the `frontend` ReplicaSet in the `production` namespace to ensure that at least 3 Pods are always available.

The solution can be checked with the following kubectl command:
```bash
kubectl get pdb frontend-pdb -n production -o yaml
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: frontend-pdb
  namespace: production
spec:
  minAvailable: 3
  selector:
    matchLabels:
      app: frontend
EOF
```
</details>

### Task 12:

Apply node affinity rules to the `frontend` ReplicaSet in the `production` namespace to ensure that Pods are scheduled on nodes with the label `disktype=ssd`.

The solution can be checked with the following kubectl command:
```bash
kubectl get replicaset frontend -n production -o yaml | grep -A 10 'affinity:'
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  namespace: production
spec:
  replicas: 5
  selector:
    matchLabels:
      app: frontend
      environment: production
  template:
    metadata:
      labels:
        app: frontend
        environment: production
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: disktype
                operator: In
                values:
                - ssd
      containers:
      - name: nginx
        image: nginx:latest
        resources:
          requests:
            cpu: "100m"
            memory: "200Mi"
          limits:
            cpu: "200m"
            memory: "400Mi"
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
EOF
```
</details>

### Task 13:

Set up a Horizontal Pod Autoscaler (HPA) for the `frontend` ReplicaSet in the `production` namespace to automatically scale the number of replicas between 3 and 10 based on CPU utilization.

The solution can be checked with the following kubectl command:
```bash
kubectl get hpa frontend-hpa -n production -o yaml
```

<details>
<summary>Solution</summary>

```bash
kubectl autoscale rs frontend --cpu-percent=50 --min=3 --max=10 -n production
```
</details>

Hier sind einige zusätzliche Themen, die im Zusammenhang mit ReplicaSets relevant sein könnten und für die CKAD-Prüfung wichtig sind:

1. **Scaling ReplicaSets up and down programmatically**: Schreiben von Skripten oder Automatisierungen zum Skalieren von ReplicaSets.
2. **Interacting with ReplicaSets using JSON and YAML**: Verwenden von JSON und YAML für verschiedene Operationen wie Erstellen, Aktualisieren und Löschen von ReplicaSets.
3. **Handling ReplicaSet Failures**: Strategien zum Umgang mit fehlgeschlagenen Pods in einem ReplicaSet.
4. **Network Policies for ReplicaSets**: Anwenden von Netzwerk-Richtlinien auf Pods, die von einem ReplicaSet verwaltet werden.
5. **Rolling Updates with ReplicaSets**: Implementierung von Rolling Updates ohne Verwendung von Deployments.

Hier sind entsprechende Aufgaben dazu:

### Task 14:

Write a script to programmatically scale the `frontend` ReplicaSet in the `production` namespace up to 7 replicas and then back down to 3 replicas.

The solution can be checked with the following kubectl command:
```bash
kubectl get replicaset frontend -n production -o yaml | grep 'replicas:'
```

<details>
<summary>Solution</summary>

```bash
# Scale up to 7 replicas
kubectl scale replicaset frontend --replicas=7 -n production

# Wait for a few seconds to allow scaling to take effect
sleep 5

# Scale back down to 3 replicas
kubectl scale replicaset frontend --replicas=3 -n production
```
</details>

### Task 15:

Create a JSON file that defines the `frontend` ReplicaSet in the `production` namespace with 5 replicas. Apply this JSON file to create the ReplicaSet.

The solution can be checked with the following kubectl command:
```bash
kubectl get replicaset frontend -n production -o yaml
```

<details>
<summary>Solution</summary>

```bash
# Create the JSON file
cat <<EOF > frontend-replicaset.json
{
  "apiVersion": "apps/v1",
  "kind": "ReplicaSet",
  "metadata": {
    "name": "frontend",
    "namespace": "production"
  },
  "spec": {
    "replicas": 5,
    "selector": {
      "matchLabels": {
        "app": "frontend",
        "environment": "production"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "app": "frontend",
          "environment": "production"
        }
      },
      "spec": {
        "containers": [
          {
            "name": "nginx",
            "image": "nginx:latest",
            "resources": {
              "requests": {
                "cpu": "100m",
                "memory": "200Mi"
              },
              "limits": {
                "cpu": "200m",
                "memory": "400Mi"
              }
            },
            "readinessProbe": {
              "httpGet": {
                "path": "/",
                "port": 80
              },
              "initialDelaySeconds": 5,
              "periodSeconds": 10
            }
          }
        ]
      }
    }
  }
}
EOF

# Apply the JSON file
kubectl apply -f frontend-replicaset.json
```
</details>

### Task 16:

Implement a network policy to restrict the traffic to the Pods managed by the `frontend` ReplicaSet in the `production` namespace. Allow traffic only from Pods with the label `access=true`.

The solution can be checked with the following kubectl command:
```bash
kubectl get networkpolicy frontend-network-policy -n production -o yaml
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: frontend-network-policy
  namespace: production
spec:
  podSelector:
    matchLabels:
      app: frontend
  ingress:
  - from:
    - podSelector:
        matchLabels:
          access: "true"
    ports:
    - protocol: TCP
      port: 80
EOF
```
</details>

### Task 17:

Perform a rolling update of the `frontend` ReplicaSet in the `production` namespace to use the `nginx:1.21` image without using Deployments. Ensure there is no downtime during the update.

The solution can be checked with the following kubectl command:
```bash
kubectl get replicaset frontend -n production -o yaml | grep 'image: nginx:1.21' && kubectl get pods -n production -l app=frontend -o jsonpath='{.items[*].spec.containers[*].image}'
```

<details>
<summary>Solution</summary>

```bash
# Step 1: Scale up the ReplicaSet to add new replicas with the new image
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  namespace: production
spec:
  replicas: 8 # Increase the replicas to handle new Pods
  selector:
    matchLabels:
      app: frontend
      environment: production
  template:
    metadata:
      labels:
        app: frontend
        environment: production
    spec:
      containers:
      - name: nginx
        image: nginx:1.21
        resources:
          requests:
            cpu: "100m"
            memory: "200Mi"
          limits:
            cpu: "200m"
            memory: "400Mi"
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
EOF

# Wait for new Pods to be ready
sleep 30

# Step 2: Scale down the old Pods
kubectl scale replicaset frontend --replicas=5 -n production
```
</details>
