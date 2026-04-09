#!/bin/bash

GHCR_USERNAME_ARG="--ghcr-username"
GHCR_USERNAME=""
GHCR_PAT_ARG="--ghcr-pat"
GHCR_PAT=""
TRACK_ARG="--track"
TRACK=${TRACK:-"stable"}
VALUES_ARG="--values"
VALUES=""
NAMESPACE="aiida"
SERVICES_NAMESPACE_ARG="--services-namespace"
SERVICES_NAMESPACE="aiida-services"

display_help () {
  echo -e "This script installs the required tools to deploy AIIDA on a minikube cluster (macOS)."
  echo -e "First enter secrets into the values file for the namespace you want to deploy to."
  echo -e "Usage: setup-aiida-macos.bash [OPTIONS]"
  echo -e "Options:"
  echo -e "  --help\t\t\t\t\tDisplay this help message."
  echo -e "  --ghcr-username=<username>\t\t\tThe GitHub Container Registry username."
  echo -e "  --ghcr-pat=<pat>\t\t\t\tThe GitHub Container Registry Personal Access Token."
  echo -e "  --services-namespace=<services-namespace>\tThe namespace for the services. Default is 'aiida-services'."
  echo -e "  --track=<track>\t\t\t\tThe track to install. Default is 'stable'."
  echo -e "  --values=<values>\t\t\t\tThe values file to use for the installation. Default is none."
}

for arg in "$@"; do
  case "$arg" in
    --help)
      display_help
      exit 0
      ;;
    ${GHCR_USERNAME_ARG}*)
      GHCR_USERNAME="${arg#*=}"
      ;;
    ${GHCR_PAT_ARG}*)
      GHCR_PAT="${arg#*=}"
      ;;
    ${TRACK_ARG}*)
      TRACK="${arg#*=}"
      ;;
    ${VALUES_ARG}*)
      VALUES="${arg#*=}"
      ;;
    ${SERVICES_NAMESPACE_ARG}*)
      SERVICES_NAMESPACE="${arg#*=}"
      ;;
    *)
      echo "Unknown argument: $arg"
      exit 1
      ;;
  esac
done

if [ -z "$GHCR_USERNAME" ] || [ -z "$GHCR_PAT" ]; then
  echo "Missing argument(s): $GHCR_USERNAME_ARG or $GHCR_PAT_ARG"
  exit 1
fi

### CHECK PREREQUISITES
if ! command -v brew &> /dev/null; then
  echo "Homebrew is required but not installed. Install it from https://brew.sh and re-run this script."
  exit 1
fi

if ! docker info &> /dev/null; then
  echo "Docker Desktop is not running. Please start Docker Desktop and re-run this script."
  exit 1
fi

### INSTALL TOOLS
if ! command -v minikube &> /dev/null; then
  brew install minikube
fi

if ! command -v kubectl &> /dev/null; then
  brew install kubectl
fi

if ! command -v helm &> /dev/null; then
  brew install helm
fi

if ! command -v k9s &> /dev/null; then
  brew install k9s
fi

### START MINIKUBE
minikube start --driver=docker
minikube addons enable ingress

export KUBECONFIG=~/.kube/config

### CREATE NAMESPACES
kubectl get namespace "$NAMESPACE" &> /dev/null || kubectl create namespace "$NAMESPACE"
kubectl get namespace "$SERVICES_NAMESPACE" &> /dev/null || kubectl create namespace "$SERVICES_NAMESPACE"

### INSTALL CERT-MANAGER
helm repo add jetstack https://charts.jetstack.io --force-update

helm upgrade --install cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true \
  jetstack/cert-manager

### CREATE GHCR SECRET
kubectl -n "$NAMESPACE" create secret docker-registry ghcr-secret \
    --docker-server=ghcr.io \
    --docker-username="$GHCR_USERNAME" \
    --docker-password="$GHCR_PAT" \
    --dry-run=client -o yaml | kubectl apply -f -

### INSTALL AIIDA INSTALLER
helm repo add eclipse "https://eclipse-energy.github.io/eclipse-base-helm/$TRACK" --force-update

HELM_VALUES_FLAG=""
if [ -n "$VALUES" ]; then
  HELM_VALUES_FLAG="--values $VALUES"
fi

helm upgrade --install aiida-installer \
  --namespace "$NAMESPACE" \
  --set core.services.namespace="$SERVICES_NAMESPACE" \
  --set core.services.repositoryTrack="$TRACK" \
  $HELM_VALUES_FLAG \
  eclipse/eclipse-aiida-installer

### START MINIKUBE TUNNEL (exposes LoadBalancer services on localhost:80)
echo "Starting minikube tunnel — this requires sudo and will run in the background."
sudo minikube tunnel &
