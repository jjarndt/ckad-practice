<details>
<summary>What does the `spec.backoffLimit` attribute determine?</summary>
The spec.backoffLimit attribute determines the number of retries a Job attempts to successfully complete the workload until the executed command finishes with an exit code 0
</details>

<details>
<summary>How many times will a Job attempt to execute the workload before being considered unsuccessful by default?</summary>
6
</details>

<details>
<summary>Which attribute in the Job manifest is used to declare the restart policy?</summary>
spec.template.spec.restartPolicy
</details>

<details>
<summary>What are the only valid restart policies for a Job?</summary>
OnFailure, Never
</details>

<details>
<summary>Can the restart policy of a Job be set to "Always"?</summary>
No.
</details>
