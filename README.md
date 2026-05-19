# helm-charts

Helm charts authored as part of the ShopHub project (DevOps requirement
**5.3 Organizacija IaC**). Each chart lives under `charts/<name>/` and is
versioned independently via its own `Chart.yaml`.

## Charts

| Chart                                  | Purpose                                                       | Status   |
|----------------------------------------|---------------------------------------------------------------|----------|
| [`shop-operator`](charts/shop-operator) | Deploys the Shop operator and installs its CRDs (req. 3.2)    | active   |
| `shophub`                              | Deploys the ShopHub control plane (req. 3.3)                  | planned  |

## Layout

```
helm-charts/
├── README.md
└── charts/
    └── shop-operator/
        ├── Chart.yaml
        ├── values.yaml
        ├── README.md
        ├── crds/
        │   ├── shops.yaml
        │   ├── discordchannels.yaml
        │   └── wallets.yaml
        └── templates/
            ├── _helpers.tpl
            ├── NOTES.txt
            ├── deployment.yaml
            ├── rbac.yaml
            └── serviceaccount.yaml
```

## Conventions

- `apiVersion: v2` for every chart (Helm 3).
- CRDs live in chart-level `crds/` (installed before templates, kept on uninstall).
- Per-chart README documents the values matrix and operational notes.
- Trunk-based development: PRs targeted at `development`, linear history on `main`.
