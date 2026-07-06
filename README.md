# helm-charts

Helm charts authored as part of the ShopHub project (DevOps requirement
**5.3 Organizacija IaC**). Each chart lives under `charts/<name>/` and is
versioned independently via its own `Chart.yaml`.

## Charts

| Chart | Purpose | Status |
|---|---|---|
| [`shop-operator`](charts/shop-operator) | Deploys the Shop operator and installs its CRDs (req. 3.2) | active |
| [`shophub`](charts/shophub) | Deploys the ShopHub control plane + its CNPG database (req. 3.3) | active |
| [`shophub-discord`](charts/shophub-discord) | Platform Discord alert routing (AlertmanagerConfig) | active |

## OCI publishing (req. 5.3)

Every push to `main` that touches `charts/**` packages the charts and pushes
them to the GitHub Container Registry as OCI artifacts
(see [.github/workflows/release.yml](.github/workflows/release.yml)):

```
oci://ghcr.io/shophub-project-2026/charts/shop-operator
oci://ghcr.io/shophub-project-2026/charts/shophub
oci://ghcr.io/shophub-project-2026/charts/shophub-discord
```

The `kube-state` repository references charts exclusively by these OCI names.
After the first publish, mark the GHCR packages **public** (org → Packages →
package → Settings → Change visibility) so `helm pull` works anonymously.

## Layout

```
helm-charts/
├── README.md
└── charts/
    ├── shop-operator/
    │   ├── Chart.yaml
    │   ├── values.yaml
    │   ├── README.md
    │   ├── crds/
    │   │   ├── shops.yaml
    │   │   ├── discordchannels.yaml
    │   │   └── wallets.yaml
    │   └── templates/
    │       ├── _helpers.tpl
    │       ├── NOTES.txt
    │       ├── deployment.yaml
    │       ├── rbac.yaml
    │       └── serviceaccount.yaml
    ├── shophub/
    │   ├── Chart.yaml
    │   ├── values.yaml
    │   ├── README.md
    │   ├── charts/
    │   │   └── kube-prometheus-stack-85.3.3.tgz
    │   └── templates/
    │       ├── _helpers.tpl
    │       ├── NOTES.txt
    │       ├── cnpg-cluster.yaml
    │       ├── deployment.yaml
    │       ├── hpa.yaml
    │       ├── ingress.yaml
    │       ├── rbac.yaml
    │       ├── secret.yaml
    │       ├── service.yaml
    │       ├── serviceaccount.yaml
    │       └── servicemonitor.yaml
    └── shophub-discord/
        ├── Chart.yaml
        ├── values.yaml
        ├── README.md
        └── templates/
            ├── _helpers.tpl
            ├── NOTES.txt
            ├── alertmanagerconfig.yaml
            └── secret.yaml
```

## Conventions

- `apiVersion: v2` for every chart (Helm 3).
- CRDs live in chart-level `crds/` (installed before templates, kept on uninstall).
- Per-chart README documents the values matrix and operational notes.
- Trunk-based development: PRs targeted at `development`, linear history on `main`.
