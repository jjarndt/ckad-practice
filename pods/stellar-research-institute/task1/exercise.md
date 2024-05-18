You are the lead Kubernetes engineer for a cutting-edge scientific research organization called "Stellar Research Institute." The institute has a multi-node Kubernetes cluster used for running various microservices and data processing workloads related to space exploration. Your tasks will revolve around creating and managing Pods in this cluster to ensure seamless data processing, communication, and deployment of research applications.

**Scenario: The Data Ingestor Pod**

The first task involves setting up a critical data ingestor Pod. This Pod will collect data from various satellites and preprocess it before forwarding it to different processing units.

---

### Task 1: Create the Data Ingestor Pod

Create a Pod named `data-ingestor` in the `research-namespace` namespace. This Pod should have two containers:
- The first container named `data-collector` using the image `busybox`, which runs a continuous loop with the command `while true; do echo 'Collecting Data'; sleep 5; done`.
- The second container named `data-preprocessor` using the image `alpine`, which also runs a continuous loop with the command `while true; do echo 'Preprocessing Data'; sleep 5; done`.

---

