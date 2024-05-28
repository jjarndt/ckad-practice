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


