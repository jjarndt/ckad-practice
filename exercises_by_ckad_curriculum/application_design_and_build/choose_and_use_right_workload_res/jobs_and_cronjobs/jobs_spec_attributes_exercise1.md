### Task 1

**Question:**
You have a job that processes data from an external API. Sometimes the API might be down temporarily, and you want the job to retry up to 3 times before it fails permanently. Which attribute would you use?

<details>
<summary>Solution</summary>

```yaml
apiVersion: batch/v1
kind: Job
spec:
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
```
</details>

### Task 5

**Question:**
You need to run a job that can complete its tasks in any order and does not depend on the completion of other tasks. 

<details>
<summary>Solution</summary>

```yaml
apiVersion: batch/v1
kind: Job
spec:
  completionMode: NonIndexed
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
  succeededCount: 10
```
</details>

### Task 9

**Question:**
You have a job that completes as soon as its Pod terminates successfully. Which attribute values would you use?

<details>
<summary>Solution</summary>

```yaml
completions: 1
parallelism: 1
```
</details>

### Task 10

**Question:**
You expect the workload of a job to complete successfully multiple times, and you want to ensure that it runs exactly 3 times. Which attribute would you use and what value would you set?

<details>
<summary>Solution</summary>

```yaml
completions: 3
```
</details>

### Task 11

**Question:**
You have a job where multiple Pods should execute the workload in parallel, and you want to run 4 Pods at the same time. Which attribute would you use and what value would you set?

<details>
<summary>Solution</summary>

```yaml
parallelism: 4
```
</details>

### Task 12

**Question:**
You want to ensure a job completes when at least one Pod has terminated successfully and all Pods are terminated. Which attributes would you set?

<details>
<summary>Solution</summary>

```yaml
parallelism: 1
```
</details>

### Task 15

**Question:**
You want to set a job to retry a maximum of 4 times before it is considered unsuccessful. Which attribute would you use and what value would you set?

<details>
<summary>Solution</summary>

```yaml
backoffLimit: 4
```
</details>

### Task 16

**Question:**
You need to set the job to always restart the Pod on failure but never restart it if the Pod completes successfully. Which attribute would you use and what value would you set?

<details>
<summary>Solution</summary>

```yaml
restartPolicy: OnFailure
```
</details>

### Task 17

**Question:**
You want to ensure that the job's Pod is never restarted, regardless of whether it fails or succeeds. Which attribute would you use and what value would you set?

<details>
<summary>Solution</summary>

```yaml
restartPolicy: Never
```
</details>

### Task 18

**Question:**
You are setting up a job and want to ensure that the job retries the workload exactly 6 times before it is considered unsuccessful, which is the default behavior. What attribute and value would you set in the job spec?

<details>
<summary>Solution</summary>

```yaml
backoffLimit: 6
```
</details>

### Task 19

**Question:**
You are creating a job and need to explicitly declare a restart policy where the Pod should only be restarted on failure. Which attribute and value would you set in the job spec?

<details>
<summary>Solution</summary>

```yaml
restartPolicy: OnFailure
```
</details>

### Task 20

**Question:**
You have a job configuration, and you want to ensure it uses the default retry limit for unsuccessful completions. How many times will the job retry by default, and which attribute determines this behavior?

<details>
<summary>Solution</summary>

```yaml
backoffLimit: 6
```
</details>
