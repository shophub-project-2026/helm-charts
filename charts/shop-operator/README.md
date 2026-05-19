# shop-operator

Helm chart that deploys the Shop operator and installs its CRDs.

The chart fulfils requirement **3.2 Shop operator Helm Chart** of the ShopHub
project specification: a single chart that bootstraps the operator manager
along with the `Shop`, `DiscordChannel` and `Wallet` CRDs.

## Installing

```bash
helm install shop-operator ./charts/shop-operator \
  --namespace shop-operator-system \
  --create-namespace
```

## Uninstalling

```bash
helm uninstall shop-operator -n shop-operator-system
```

CRDs in `crds/` are intentionally **not** removed on `helm uninstall` so
existing Shop/DiscordChannel/Wallet objects survive operator upgrades and
re-installs. Delete them manually with `kubectl delete crd ...` when the
operator is being retired permanently.

## Values

| Key                      | Default                          | Description                                   |
|--------------------------|----------------------------------|-----------------------------------------------|
| `image.repository`       | `milos2002/shop-operator`        | Container image                               |
| `image.tag`              | `development`                    | Image tag (overrides `Chart.AppVersion`)      |
| `image.pullPolicy`       | `IfNotPresent`                   | Pull policy                                   |
| `replicaCount`           | `1`                              | Number of operator replicas                   |
| `resources`              | requests 100m/128Mi, limits 500m/256Mi | Container resource sizing               |
| `serviceAccount.create`  | `true`                           | Create a chart-managed ServiceAccount         |
| `serviceAccount.name`    | `""`                             | Override the ServiceAccount name              |
| `rbac.create`            | `true`                           | Create cluster-scoped RBAC for the operator   |
| `nodeSelector`           | `{}`                             | Pod node selector                             |
| `tolerations`            | `[]`                             | Pod tolerations                               |
| `affinity`               | `{}`                             | Pod affinity rules                            |

## CRDs installed

- `shops.shop.devops.io`
- `discordchannels.shop.devops.io`
- `wallets.shop.devops.io`

## RBAC summary

Cluster-scoped because Shop CRDs may be created in any namespace by the
ShopHub control plane. Grants the operator full CRUD on its own CRDs plus
`apps/deployments`, `core/services`, `postgresql.cnpg.io/clusters` and
`app.redislabs.com/redisenterprisedatabases`.
