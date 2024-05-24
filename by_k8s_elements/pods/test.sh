#!/bin/bash

NAMESPACE="research-namespace"
POD_NAME="data-ingestor"

check_pod_exists() {
  kubectl get pod "$POD_NAME" -n "$NAMESPACE" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo -e "\e[32m✔ Pod exists\e[0m"
  else
    echo -e "\e[31m✘ Pod does not exist\e[0m"
  fi
}

describe_pod() {
  kubectl describe pod "$POD_NAME" -n "$NAMESPACE" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo -e "\e[32m✔ Pod description fetched\e[0m"
  else
    echo -e "\e[31m✘ Failed to fetch Pod description\e[0m"
  fi
}

check_container_image() {
  local container_name=$1
  local expected_image=$2

  image=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath="{.spec.containers[?(@.name=='$container_name')].image}")
  if [ "$image" == "$expected_image" ]; then
    echo -e "\e[32m✔ $container_name container image is '$expected_image'\e[0m"
  else
    echo -e "\e[31m✘ $container_name container image is not '$expected_image'\e[0m"
  fi
}

check_logs() {
  local container_name=$1
  local expected_log_message=$2

  logs=$(kubectl logs "$POD_NAME" -n "$NAMESPACE" -c "$container_name" --tail=10)
  if echo "$logs" | grep -q "$expected_log_message"; then
    echo -e "\e[32m✔ $container_name container logs contain expected output\e[0m"
  else
    echo -e "\e[31m✘ $container_name container logs do not contain expected output\e[0m"
  fi
}

check_container_statuses() {
  statuses=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.status.containerStatuses[*].ready}')
  if [ "$statuses" == "true true" ]; then
    echo -e "\e[32m✔ All containers are running\e[0m"
  else
    echo -e "\e[31m✘ Not all containers are running\e[0m"
  fi
}

echo "Checking Pod: $POD_NAME in Namespace: $NAMESPACE"

check_pod_exists
describe_pod
check_container_image "data-collector" "busybox"
check_container_image "data-preprocessor" "alpine"
check_logs "data-collector" "Collecting Data"
check_logs "data-preprocessor" "Preprocessing Data"
check_container_statuses
