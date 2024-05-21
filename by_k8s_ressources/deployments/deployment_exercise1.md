### Task 1:

Create a Deployment named `nginx-deployment` in the `default` namespace with the following specifications:
- Image: `nginx:1.17.4`
- Replicas: 3
- Container Port: 80

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment nginx-deployment -o yaml
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: default
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.17.4
        ports:
        - containerPort: 80
EOF
```
</details>

### Task 2:

Update the `nginx-deployment` to use the image `nginx:1.19.0` instead of `nginx:1.17.4`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[0].image}'
```

<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/nginx-deployment nginx=nginx:1.19.0
```
</details>

### Task 3:

Scale the `nginx-deployment` to 5 replicas.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment nginx-deployment -o jsonpath='{.spec.replicas}'
```

<details>
<summary>Solution</summary>

```bash
kubectl scale deployment/nginx-deployment --replicas=5
```
</details>

### Task 4:

Add a readiness probe to the `nginx` containers in the `nginx-deployment`. The probe should check the path `/` on port `80` with an initial delay of 5 seconds and a period of 10 seconds.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[0].readinessProbe}'
```

<details>
<summary>Solution</summary>

```bash
kubectl patch deployment nginx-deployment --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/readinessProbe", "value": {"httpGet": {"path": "/", "port": 80}, "initialDelaySeconds": 5, "periodSeconds": 10}}]'
```
</details>

### Task 5:

Add a resource request and limit to the `nginx` containers in the `nginx-deployment`. Set the resource requests to `100m` CPU and `200Mi` memory, and the resource limits to `200m` CPU and `400Mi` memory.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[0].resources}'
```

<details>
<summary>Solution</summary>

```bash
kubectl patch deployment nginx-deployment --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/resources", "value": {"requests": {"cpu": "100m", "memory": "200Mi"}, "limits": {"cpu": "200m", "memory": "400Mi"}}}]'
```
</details>

### Task 6:

Add an environment variable `ENV` with the value `production` to the `nginx` containers in the `nginx-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[0].env}'
```

<details>
<summary>Solution</summary>

```bash
kubectl patch deployment nginx-deployment --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/env", "value": [{"name": "ENV", "value": "production"}]}]'
```
</details>

### Task 7:

Add a liveness probe to the `nginx` containers in the `nginx-deployment`. The probe should check the path `/healthz` on port `80` with an initial delay of 10 seconds and a period of 15 seconds.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[0].livenessProbe}'
```

<details>
<summary>Solution</summary>

```bash
kubectl patch deployment nginx-deployment --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/livenessProbe", "value": {"httpGet": {"path": "/healthz", "port": 80}, "initialDelaySeconds": 10, "periodSeconds": 15}}]'
```
</details>

### Task 8:

Add a sidecar container to the `nginx-deployment`. The sidecar container should use the `busybox` image, run indefinitely, and have the name `sidecar`. The command for the sidecar container should be `["sh", "-c", "while true; do echo hello; sleep 10;done"]`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[*].name}'
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: default
spec:
  replicas: 5
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.19.0
        ports:
        - containerPort: 80
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
        livenessProbe:
          httpGet:
            path: /healthz
            port: 80
          initialDelaySeconds: 10
          periodSeconds: 15
        resources:
          requests:
            cpu: "100m"
            memory: "200Mi"
          limits:
            cpu: "200m"
            memory: "400Mi"
        env:
        - name: ENV
          value: production
      - name: sidecar
        image: busybox
        command: ["sh", "-c", "while true; do echo hello; sleep 10;done"]
EOF
```
</details>

### Task 9:

Create a ConfigMap named `nginx-config` in the `default` namespace with the following key-value pair:
- Key: `nginx.conf`
- Value: `user  nginx;`

Modify the `nginx-deployment` to mount this ConfigMap as a volume. The volume should be mounted at `/etc/nginx/conf.d` in the `nginx` container.

The solution can be checked with the following kubectl command:
```bash
kubectl get configmap nginx-config -o yaml
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.volumes}'
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[0].volumeMounts}'
```

<details>
<summary>Solution</summary>

First, create the ConfigMap:
```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
  namespace: default
data:
  nginx.conf: |
    user  nginx;
EOF
```

Then, update the Deployment to mount the ConfigMap:
```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: default
spec:
  replicas: 5
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.19.0
        ports:
        - containerPort: 80
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
        livenessProbe:
          httpGet:
            path: /healthz
            port: 80
          initialDelaySeconds: 10
          periodSeconds: 15
        resources:
          requests:
            cpu: "100m"
            memory: "200Mi"
          limits:
            cpu: "200m"
            memory: "400Mi"
        env:
        - name: ENV
          value: production
        volumeMounts:
        - name: config-volume
          mountPath: /etc/nginx/conf.d
          subPath: nginx.conf
      - name: sidecar
        image: busybox
        command: ["sh", "-c", "while true; do echo hello; sleep 10;done"]
      volumes:
      - name: config-volume
        configMap:
          name: nginx-config
          items:
          - key: nginx.conf
            path: nginx.conf
EOF
```
</details>

### Task 10:

Create a Secret named `nginx-secret` in the `default` namespace with the following key-value pair:
- Key: `username`
- Value: `admin` (base64 encoded value: YWRtaW4=)
- Key: `password`
- Value: `secret` (base64 encoded value: c2VjcmV0)

Modify the `nginx-deployment` to add these secrets as environment variables in the `nginx` container:
- Environment Variable: `USERNAME` from `nginx-secret` key `username`
- Environment Variable: `PASSWORD` from `nginx-secret` key `password`

The solution can be checked with the following kubectl command:
```bash
kubectl get secret nginx-secret -o yaml
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[0].env}'
```

<details>
<summary>Solution</summary>

First, create the Secret:
```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: nginx-secret
  namespace: default
data:
  username: YWRtaW4=
  password: c2VjcmV0
EOF
```

Then, update the Deployment to use the Secret as environment variables:
```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: default
spec:
  replicas: 5
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.19.0
        ports:
        - containerPort: 80
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 10
        livenessProbe:
          httpGet:
            path: /healthz
            port: 80
          initialDelaySeconds: 10
          periodSeconds: 15
        resources:
          requests:
            cpu: "100m"
            memory: "200Mi"
          limits:
            cpu: "200m"
            memory: "400Mi"
        env:
        - name: ENV
          value: production
        - name: USERNAME
          valueFrom:
            secretKeyRef:
              name: nginx-secret
              key: username
        - name: PASSWORD
          valueFrom:
            secretKeyRef:
              name: nginx-secret
              key: password
        volumeMounts:
        - name: config-volume
          mountPath: /etc/nginx/conf.d
          subPath: nginx.conf
      - name: sidecar
        image: busybox
        command: ["sh", "-c", "while true; do echo hello; sleep 10;done"]
      volumes:
      - name: config-volume
        configMap:
          name: nginx-config
          items:
          - key: nginx.conf
            path: nginx.conf
EOF
```
</details>

### Task 11:

Create a Service named `nginx-service` in the `default` namespace to expose the `nginx-deployment`. The Service should:
- Be of type `ClusterIP`
- Use port `80` and target port `80`
- Select pods with the label `app: nginx`

The solution can be checked with the following kubectl command:
```bash
kubectl get service nginx-service -o yaml
```

<details>
<summary>Solution</summary>

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  namespace: default
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
EOF
```
</details>

### Task 13:

Create a new Deployment named `test-deployment` with the following specifications:
- Image: `nginx:latest`
- Replicas: 2
- Container Port: 80

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment -o yaml
```

<details>
<summary>Solution</summary>

```bash
kubectl create deployment test-deployment --image=nginx:latest --replicas=2 --port=80
```
</details>

### Task 14:

Update the `test-deployment` to scale the replicas to 4.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment -o jsonpath='{.spec.replicas}'
```

<details>
<summary>Solution</summary>

```bash
kubectl scale deployment test-deployment --replicas=4
```
</details>

### Task 15:

Update the image of the `test-deployment` to `nginx:1.18.0`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment -o jsonpath='{.spec.template.spec.containers[0].image}'
```

<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/test-deployment nginx=nginx:1.18.0
```
</details>

### Task 16:

Pause the `test-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment -o jsonpath='{.spec.paused}'
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout pause deployment/test-deployment
```
</details>

### Task 17:

Resume the `test-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment -o jsonpath='{.spec.paused}'
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout resume deployment/test-deployment
```
</details>

### Task 18:

Rollback the `test-deployment` to the previous revision.

The solution can be checked with the following kubectl command:
```bash
kubectl rollout history deployment test-deployment
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout undo deployment test-deployment
```
</details>

### Task 19:

Add a label `env=production` to the `test-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment --show-labels
```

<details>
<summary>Solution</summary>

```bash
kubectl label deployment test-deployment env=production
```
</details>

### Task 20:

Annotate the `test-deployment` with `description='test deployment for nginx'`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment -o jsonpath='{.metadata.annotations}'
```

<details>
<summary>Solution</summary>

```bash
kubectl annotate deployment test-deployment description='test deployment for nginx'
```
</details>

### Task 21:

Set a resource request of `50m` CPU and `100Mi` memory for the containers in `test-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment -o jsonpath='{.spec.template.spec.containers[0].resources.requests}'
```

<details>
<summary>Solution</summary>

```bash
kubectl set resources deployment test-deployment --requests=cpu=50m,memory=100Mi
```
</details>

### Task 22:

Set a resource limit of `100m` CPU and `200Mi` memory for the containers in `test-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment -o jsonpath='{.spec.template.spec.containers[0].resources.limits}'
```

<details>
<summary>Solution</summary>

```bash
kubectl set resources deployment test-deployment --limits=cpu=100m,memory=200Mi
```
</details>

### Task 23:

Add an environment variable `MY_ENV_VAR` with the value `my-value` to the containers in `test-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment -o jsonpath='{.spec.template.spec.containers[0].env}'
```

<details>
<summary>Solution</summary>

```bash
kubectl set env deployment test-deployment MY_ENV_VAR=my-value
```
</details>

### Task 24:

Add a readiness probe to the `test-deployment` that checks the path `/ready` on port `80`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment -o jsonpath='{.spec.template.spec.containers[0].readinessProbe}'
```

<details>
<summary>Solution</summary>

```bash
kubectl set probe deployment test-deployment --readiness --get-url=http://:80/ready
```
</details>

### Task 25:

Add a liveness probe to the `test-deployment` that checks the path `/health` on port `80`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment -o jsonpath='{.spec.template.spec.containers[0].livenessProbe}'
```

<details>
<summary>Solution</summary>

```bash
kubectl set probe deployment test-deployment --liveness --get-url=http://:80/health
```
</details>

### Task 26:

Update the image of the `test-deployment` to `nginx:stable`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment -o jsonpath='{.spec.template.spec.containers[0].image}'
```

<details>
<summary>Solution</summary>

```bash
kubectl set image deployment/test-deployment nginx=nginx:stable
```
</details>

### Task 27:

Record the changes made to the `test-deployment` in the resource annotations.

The solution can be checked with the following kubectl command:
```bash
kubectl rollout history deployment test-deployment
```

<details>
<summary>Solution</summary>

```bash
kubectl annotate deployment test-deployment kubernetes.io/change-cause="updated image to nginx:stable"
```
</details>

### Task 28:

Rollback the `test-deployment` to a specific revision (assume revision 2).

The solution can be checked with the following kubectl command:
```bash
kubectl rollout history deployment test-deployment
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout undo deployment test-deployment --to-revision=2
```
</details>

### Task 29:

Describe the `test-deployment` to view detailed information about its state.

The solution can be checked with the following kubectl command:
```bash
kubectl describe deployment test-deployment
```

<details>
<summary>Solution</summary>

```bash
kubectl describe deployment test-deployment
```
</details>

### Task 30:

Delete the `test-deployment`.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment test-deployment
```

<details>
<summary>Solution</summary>

```bash
kubectl delete deployment test-deployment
```
</details>

### Task 31:

Create a Deployment named `complex-deployment` with the following specifications:
- Image: `nginx:alpine`
- Replicas: 3
- Container Port: 8080
- Add a startup probe that checks the path `/startup` on port `8080` with an initial delay of 5 seconds and a period of 10 seconds
- Set resource requests to `200m` CPU and `256Mi` memory
- Set resource limits to `500m` CPU and `512Mi` memory
- Add an environment variable `ENV_MODE` with the value `debug`
- Add a volume mount for a ConfigMap named `config-volume` at `/app/config`

The solution can be checked with the following kubectl commands:
```bash
kubectl get deployment complex-deployment -o yaml
kubectl get configmap config-volume -o yaml
```

<details>
<summary>Solution</summary>

First, create the ConfigMap:
```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: config-volume
  namespace: default
data:
  config-file: |
    log_level=debug
EOF
```

Then, create the Deployment:
```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: complex-deployment
  namespace: default
spec:
  replicas: 3
  selector:
    matchLabels:
      app: complex
  template:
    metadata:
      labels:
        app: complex
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
        ports:
        - containerPort: 8080
        resources:
          requests:
            cpu: "200m"
            memory: "256Mi"
          limits:
            cpu: "500m"
            memory: "512Mi"
        env:
        - name: ENV_MODE
          value: debug
        volumeMounts:
        - name: config-volume
          mountPath: /app/config
        startupProbe:
          httpGet:
            path: /startup
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 10
      volumes:
      - name: config-volume
        configMap:
          name: config-volume
EOF
```
</details>

### Task 32:

Patch the `complex-deployment` to change the readiness probe to check the path `/readyz` on port `8080` with an initial delay of 10 seconds and a period of 5 seconds.

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment complex-deployment -o jsonpath='{.spec.template.spec.containers[0].readinessProbe}'
```

<details>
<summary>Solution</summary>

```bash
kubectl patch deployment complex-deployment --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/readinessProbe", "value": {"httpGet": {"path": "/readyz", "port": 8080}, "initialDelaySeconds": 10, "periodSeconds": 5}}]'
```
</details>

### Task 33:

Pause the `complex-deployment` and change its image to `nginx:stable-alpine`. After that, resume the deployment.

The solution can be checked with the following kubectl commands:
```bash
kubectl rollout status deployment complex-deployment
kubectl get deployment complex-deployment -o jsonpath='{.spec.template.spec.containers[0].image}'
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout pause deployment complex-deployment
kubectl set image deployment/complex-deployment nginx=nginx:stable-alpine
kubectl rollout resume deployment complex-deployment
```
</details>

### Task 34:

Add a sidecar container to the `complex-deployment` with the following specifications:
- Name: `sidecar`
- Image: `busybox`
- Command: `["sh", "-c", "while true; do echo sidecar running; sleep 5; done"]`
- Set a resource request of `100m` CPU and `128Mi` memory for the sidecar container

The solution can be checked with the following kubectl command:
```bash
kubectl get deployment complex-deployment -o jsonpath='{.spec.template.spec.containers[*].name}'
```

<details>
<summary>Solution</summary>

```bash
kubectl patch deployment complex-deployment --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/-", "value": {"name": "sidecar", "image": "busybox", "command": ["sh", "-c", "while true; do echo sidecar running; sleep 5; done"], "resources": {"requests": {"cpu": "100m", "memory": "128Mi"}}}}]'
```
</details>

### Task 35:

Simulate a failure and recovery by rolling back the `complex-deployment` to the previous revision.

The solution can be checked with the following kubectl command:
```bash
kubectl rollout history deployment complex-deployment
```

<details>
<summary>Solution</summary>

```bash
kubectl rollout undo deployment complex-deployment --to-revision=0
```
</details>

### Task 36:

Delete the `complex-deployment` and the `config-volume` ConfigMap.

The solution can be checked with the following kubectl commands:
```bash
kubectl get deployment complex-deployment
kubectl get configmap config-volume
```

<details>
<summary>Solution</summary>

```bash
kubectl delete deployment complex-deployment
kubectl delete configmap config-volume
```
</details>
