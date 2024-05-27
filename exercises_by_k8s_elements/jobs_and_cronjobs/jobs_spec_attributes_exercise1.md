### Task 1

**Question:**
You have a job that processes data from an external API. Sometimes the API might be down temporarily, and you want the job to retry up to 3 times before it fails permanently. Which attribute would you use?

<details>
<summary>Solution</summary>

```yaml
apiVersion: batch/v1
kind: Job
spec:
  template:
    spec:
      containers:
      - name: api-processor
        image: api-processor-image
  backoffLimit: 3
```
</details>

### Task 2

**Question:**
You need a job to process exactly 5 tasks, one after another. Which attribute should you use to define the number of tasks to be completed?

<details>
<summary>Solution</summary>

```yaml
apiVersion: batch/v1
kind: Job
spec:
  completions: 5
  template:
    spec:
      containers:
      - name: task-processor
        image: task-processor-image
```
</details>

### Task 3

**Question:**
You want a job to run 3 tasks in parallel to speed up processing time. Which attribute allows you to define this parallel execution?

<details>
<summary>Solution</summary>

```yaml
apiVersion: batch/v1
kind: Job
spec:
  parallelism: 3
  template:
    spec:
      containers:
      - name: parallel-task
        image: parallel-task-image
```
</details>

### Task 4

**Question:**
Your job should fail if it does not complete within 2 hours. Which attribute would you use to enforce this time limit?

<details>
<summary>Solution</summary>

```yaml
apiVersion: batch/v1
kind: Job
spec:
  activeDeadlineSeconds: 7200
  template:
    spec:
      containers:
      - name: time-sensitive-task
        image: time-sensitive-task-image
```
</details>

### Task 5

**Question:**
You need to run a job that can complete its tasks in any order and does not depend on the completion of other tasks. Which attribute should you specify to set the job's completion mode to non-indexed?

<details>
<summary>Solution</summary>

```yaml
apiVersion: batch/v1
kind: Job
spec:
  completionMode: NonIndexed
  template:
    spec:
      containers:
      - name: unordered-task
        image: unordered-task-image
```
</details>

### Task 6

**Question:**
You want to specify a job to not retry after it has succeeded in completing its tasks. Which attribute would you use to define this behavior?

<details>
<summary>Solution</summary>

```yaml
apiVersion: batch/v1
kind: Job
spec:
  successPolicy: Terminate
  template:
    spec:
      containers:
      - name: single-success-task
        image: single-success-task-image
```
</details>

### Task 7

**Question:**
You need to track the indexes of the succeeded tasks in a job. Which attribute would you use to get this information?

<details>
<summary>Solution</summary>

```yaml
apiVersion: batch/v1
kind: Job
spec:
  template:
    spec:
      containers:
      - name: track-success-task
        image: track-success-task-image
  succeededIndexes: "0-4"
```
</details>

### Task 8

**Question:**
You need to monitor the number of successfully completed tasks in a job and keep a count. Which attribute would help you achieve this?

<details>
<summary>Solution</summary>

```yaml
apiVersion: batch/v1
kind: Job
spec:
  template:
    spec:
      containers:
      - name: success-count-task
        image: success-count-task-image
  succeededCount: 10
```
</details>
