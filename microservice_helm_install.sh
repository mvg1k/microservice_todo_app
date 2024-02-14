#!/bin/bash

helm install frontend-dev frontend/ -f frontend/values-dev.yaml -n dev

helm install auth-api-dev auth-api_helm/ -f auth-api_helm/values.yaml -n dev

helm install log-message-processor-dev log-message-processor_helm/ -f log-message-processor_helm/values.yaml -n dev

helm install redis-dev redis_helm/ -f redis_helm/values.yaml -n dev

helm install todos-api-dev todos-api_helm/ -f todos-api_helm/values.yaml -n dev

helm install users-api-dev users-api_helm/ -f users-api_helm/values.yaml -n dev

helm install zipkin_helm/ -f zipkin_helm/values.yaml -n dev

