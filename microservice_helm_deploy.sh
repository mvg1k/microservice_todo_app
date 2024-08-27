#!/bin/bash
set -e
CHARTS_DIR="./helm_charts_for_microservices"

helm install redis "$CHARTS_DIR/redis_helm" -f "$CHARTS_DIR/redis_helm/values.yaml" -n prod

helm install users-api "$CHARTS_DIR/users-api_helm" -f "$CHARTS_DIR/users-api_helm/values.yaml" -n prod

helm install auth-api "$CHARTS_DIR/auth-api_helm" -f "$CHARTS_DIR/auth-api_helm/values.yaml" -n prod

helm install todos-api "$CHARTS_DIR/todos-api_helm" -f "$CHARTS_DIR/todos-api_helm/values.yaml" -n prod

helm install log-message-processor "$CHARTS_DIR/log-message-processor_helm" -f "$CHARTS_DIR/log-message-processor_helm/values.yaml" -n prod

helm install frontend "$CHARTS_DIR/frontend" -f "$CHARTS_DIR/frontend/values.yaml" -n prod

helm install zipkin "$CHARTS_DIR/zipkin_helm" -f "$CHARTS_DIR/zipkin_helm/values.yaml" -n prod

