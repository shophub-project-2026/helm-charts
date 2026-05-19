{{/*
Expand the name of the chart.
*/}}
{{- define "shop-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name. Truncated at 63 chars to comply
with the Kubernetes DNS label limit.
*/}}
{{- define "shop-operator.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Chart name and version as used in the helm.sh/chart label.
*/}}
{{- define "shop-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels applied to every resource the chart manages.
*/}}
{{- define "shop-operator.labels" -}}
helm.sh/chart: {{ include "shop-operator.chart" . }}
{{ include "shop-operator.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels (stable across upgrades).
*/}}
{{- define "shop-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "shop-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
ServiceAccount name -- chart-managed or user-supplied.
*/}}
{{- define "shop-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "shop-operator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
