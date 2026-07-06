# shophub-discord

Platform-level Discord alert routing for the ShopHub platform. Renders an
`AlertmanagerConfig` (monitoring.coreos.com/v1alpha1) that delivers
Kubernetes-cluster and ShopHub alerts — everything labelled
`team=platform` or `team=shophub` — to a Discord channel via webhook.

Per-shop alerts (labelled `shop=<name>`) are deliberately **excluded**: the
shop-operator provisions a dedicated Discord channel, webhook Secret and
AlertmanagerConfig for every Shop CR it reconciles.

## Prerequisites

- kube-prometheus-stack (the Prometheus operator must serve the
  `AlertmanagerConfig` CRD and its Alertmanager must select configs labelled
  `release: kube-prometheus-stack` — override via `alertmanagerConfigLabels`).

## Secret handling

The Discord webhook URL is a credential and is never committed to git:

- **Out-of-band Secret (default):** leave `discord.webhookUrl` empty and create
  the Secret referenced by `discord.secret.name`/`discord.secret.key` yourself:

  ```sh
  kubectl create secret generic alertmanager-discord-secret \
    --namespace monitoring \
    --from-literal=webhook-url='<discord-webhook-url>'
  ```

- **Install-time value:** pass `--set discord.webhookUrl=...` and the chart
  renders the Secret for you.

## Values

| Key | Default | Description |
|---|---|---|
| `discord.webhookUrl` | `""` | Webhook URL; empty ⇒ Secret managed out-of-band |
| `discord.secret.name` | `alertmanager-discord-secret` | Secret holding the webhook |
| `discord.secret.key` | `webhook-url` | Key inside the Secret |
| `route.matchers` | `team =~ platform\|shophub` | Which alerts this receiver gets |
| `route.repeatInterval` | `12h` | Re-notification interval |
| `alertmanagerConfigLabels` | `release: kube-prometheus-stack` | Selector labels |
