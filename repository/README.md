# AIIDA Setup Scripts

This directory contains scripts to deploy AIIDA on a Kubernetes cluster.

## Scripts

| Script | Platform | Kubernetes |
|---|---|---|
| `setup-aiida.bash` | Linux | k3s |
| `setup-aiida-macos.bash` | macOS | minikube (Docker Desktop) |

## Usage

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

## Differences between Linux and macOS

### Kubernetes distribution

The Linux script installs **k3s**, a lightweight Kubernetes distribution that runs directly on the host.
macOS does not support k3s, so the macOS script uses **minikube** with the Docker driver, which runs the cluster inside a Docker container.

**macOS prerequisite:** Docker Desktop must be installed and running before executing the script.

### Tool installation

On Linux, `kubectl` is downloaded as a binary and installed via the system `install` command.
On macOS, all tools (`minikube`, `kubectl`, `helm`, `k9s`) are installed via **Homebrew**. Each tool is only installed if not already present.

**macOS prerequisite:** Homebrew must be installed (`https://brew.sh`).

### Service exposure

On Linux, k3s services are directly accessible on the host network.
On macOS, the script starts a **minikube tunnel** in the background after installation, which exposes LoadBalancer services (including the ingress on port 80) on `127.0.0.1`.

Once the tunnel is running, AIIDA is reachable at: `http://localhost/aiida`

### Idempotency

The macOS script is safe to run multiple times — namespaces are created only if they don't exist, Helm releases use `upgrade --install`, and secrets are applied declaratively.
