{{/*
Custom Environments
*/}}
{{- define "federator.customEnvs" -}}
{{- range . }}
- name: {{ .name }}
  value: {{ .value }}
{{- end }}
{{- end }}

{{/*
Metadata for federator core components.
*/}}
{{- define "federator.core.labels" }}
labels:
  app: {{ .Release.Name }}-core
{{- include "federator.labels" . }}
{{- end }}

{{/*
Metadata for federator postgres components.
*/}}
{{- define "federator.postgres.labels" }}
labels:
  app: {{ .Release.Name }}-postgres
{{- include "federator.labels" . }}
{{- end }}

{{/*
Metadata for federator components.
*/}}
{{- define "federator.labels" }}
  generator: helm
  chart: {{ .Chart.Name }}
  version: {{ .Chart.Version }}
{{- end }}

