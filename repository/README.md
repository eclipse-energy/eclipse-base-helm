# Eclipse Base Helm

This repository contains the **Helm charts** for Eclipse. The charts are packaged and published as a Helm repository, which is the primary purpose of this repo. The setup scripts in this directory are a convenience for running AIIDA locally.

## Helm Charts

Charts are located in the `charts/` directory. Each chart has a `Makefile` with the following targets:

| Command | Description |
|---|---|
| `make package` | Packages the chart into `repository/<track>/packages/` |
| `make index` | Regenerates `repository/<track>/index.yaml` for the Helm repository |

Run these commands from inside the desired chart directory, e.g. `charts/eclipse-aiida`.

The `TRACK` variable controls which track is targeted (default: `stable`):

```bash
make package TRACK=stable
make index   TRACK=stable
```

---

## Local Setup Scripts

The setup scripts install all required tooling and deploy AIIDA on a local Kubernetes cluster. They are intended for local development and testing.

| Script | Platform | Kubernetes |
|---|---|---|
| `setup-aiida.bash` | Linux | k3s |
| `setup-aiida-macos.bash` | macOS | minikube (Docker Desktop) |

### Usage

```bash
./setup-aiida.bash \
  --ghcr-username=<username> \
  --ghcr-pat=<personal-access-token>
```

```bash
./setup-aiida-macos.bash \
  --ghcr-username=<username> \
  --ghcr-pat=<personal-access-token>
```

### Options

| Option | Description | Default |
|---|---|---|
| `--ghcr-username` | GitHub Container Registry username | required |
| `--ghcr-pat` | GitHub Container Registry Personal Access Token | required |
| `--track` | Helm chart track to install | `stable` |
| `--values` | Path to a custom Helm values file | none |
| `--services-namespace` | Namespace for AIIDA services | `aiida-services` |

---

## Differences between Linux and macOS

### Kubernetes distribution

| | Linux | macOS |
|---|---|---|
| Distribution | k3s (runs directly on host) | minikube (runs inside Docker) |
| Extra prerequisite | — | Docker Desktop + Homebrew |

The Linux script installs **k3s** directly on the host. macOS does not support k3s, so the macOS script uses **minikube** with the Docker driver.

### Tool installation

| | Linux | macOS |
|---|---|---|
| `kubectl` | Downloaded as binary, installed via system `install` | Installed via Homebrew |
| `helm` | Installed via official `get-helm-3` script | Installed via Homebrew |
| `k9s` | — | Installed via Homebrew |

On macOS, each tool is only installed if not already present.

### Service exposure

On Linux, k3s services are directly accessible on the host network.

On macOS, the script starts a **minikube tunnel** in the background after installation, which exposes LoadBalancer services on `127.0.0.1`. Once running, AIIDA is reachable at:

```
http://localhost/aiida
```

### Idempotency

The macOS script is safe to run multiple times — namespaces are created only if they don't exist, Helm releases use `upgrade --install`, and secrets are applied declaratively.
