# shophub

Helm chart for the ShopHub admin service — manages Shop CRDs via the Kubernetes API and provides a web UI and REST API for store management.

## Prerequisites

- Kubernetes 1.26+
- Helm 3.14+
- `shop.devops.io` CRDs installed (from the `shop-operator` chart)
- PostgreSQL accessible from the cluster

## Install

```bash
helm install shophub charts/shophub \
  --namespace shophub \
  --create-namespace \
  --set config.jwtSecret=<your-secret> \
  --set config.db.host=<postgres-host> \
  --set config.db.password=<postgres-password>
```

## Values

| Key | Default | Description |
|-----|---------|-------------|
| `image.repository` | `milos2002/shophub` | Container image |
| `image.tag` | `""` (uses appVersion) | Image tag |
| `replicaCount` | `1` | Number of replicas (ignored when HPA enabled) |
| `config.jwtSecret` | `change-me-in-production` | JWT signing secret |
| `config.db.host` | `postgresql` | PostgreSQL host |
| `config.db.port` | `5432` | PostgreSQL port |
| `config.db.name` | `shophub_db` | Database name |
| `config.db.user` | `shophub_user` | Database user |
| `config.db.password` | `shophub_password` | Database password |
| `ingress.enabled` | `false` | Enable Ingress |
| `hpa.enabled` | `false` | Enable HorizontalPodAutoscaler |
| `serviceMonitor.enabled` | `true` | Enable Prometheus ServiceMonitor |
| `prometheus-stack.enabled` | `false` | Install kube-prometheus-stack as subchart |

## RBAC

The chart creates a `ClusterRole` and `ClusterRoleBinding` granting the ShopHub service account full CRUD access to `shops.shop.devops.io` resources cluster-wide.
