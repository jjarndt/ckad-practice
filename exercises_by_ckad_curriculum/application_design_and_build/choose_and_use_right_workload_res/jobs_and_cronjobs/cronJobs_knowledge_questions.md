<details>
<summary>What does a CronJob create periodically based on a schedule?</summary>
A new Job
</details>

<details>
<summary>How is the schedule for a CronJob defined?</summary>
The schedule can be defined with a cron-expression
</details>

<details>
<summary>What exit codes can the Pod finish with after running the task in a CronJob?</summary>
0 or non-zero exit
</details>

<details>
<summary>Will a Pod controlled by a CronJob be deleted automatically after it completes?</summary>
No.
</details>

<details>
<summary>Why is it useful to keep a historical record of Pods?</summary>
helpful for troubleshooting failed workloads or inspecting the logs
</details>

<details>
<summary>By default, how many successful Pods does a CronJob retain?</summary>
the last three successful Pods
</details>

<details>
<summary>By default, how many failed Pods does a CronJob retain?</summary>
the last failed Pod
</details>

<details>
<summary>How can you reconfigure the job retention history limits for a CronJob?</summary>
To reconfigure the job retention history limits, set new values for the spec.successfulJobsHistoryLimit and spec.failedJobsHistoryLimit attributes
</details>

<details>
<summary>What template does a CronJob contain by design?</summary>
A Template for new Jobs
</details>

<details>
<summary>Do changes to an existing CronJob apply to Jobs that have already started?</summary>
The CronJob does not update existing Jobs, even if those remain running
</details>

<details>
<summary>How often does a CronJob create a Job object?</summary>
A CronJob creates a Job object approximately once per execution time of its schedule
</details>

<details>
<summary>Why might the scheduling of Job creation by a CronJob be approximate?</summary>
The scheduling is approximate because there are certain circumstances where two Jobs might be created, or no Job might be created. Kubernetes tries to avoid those situations, but does not completely prevent them
</details>

<details>
<summary>What should the Jobs defined by a CronJob be to handle approximate scheduling?</summary>
The Jobs that you define should be idempotent.
</details>

<details>
<summary>What do the .spec.successfulJobsHistoryLimit and .spec.failedJobsHistoryLimit fields specify?</summary>
Specify how many completed and failed Jobs should be kept. Both fields are optional.
</details>

<details>
<summary>What is the default value of .spec.successfulJobsHistoryLimit?</summary>
3
</details>

<details>
<summary>What happens if the .spec.successfulJobsHistoryLimit field is set to 0?</summary>
Setting this field to 0 will not keep any successful jobs.
</details>

<details>
<summary>What is the default value of .spec.failedJobsHistoryLimit?</summary>
1
</details>

<details>
<summary>What happens if the .spec.failedJobsHistoryLimit field is set to 0?</summary>
Setting this field to 0 will not keep any failed jobs.
</details>



