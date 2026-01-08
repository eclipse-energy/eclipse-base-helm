{{/*
Custom Environments
*/}}
{{- define "eclipse-backend.customEnvs" -}}
{{- range . }}
- name: {{ .name }}
  value: {{ .value }}
{{- end }}
{{- end }}

{{/*
Metadata for eclipse-backend core components.
*/}}
{{- define "eclipse-backend.core.labels" }}
labels:
  app: {{ .Release.Name }}-core
{{- include "eclipse-backend.labels" . }}
{{- end }}

{{/*
Metadata for eclipse-backend timescaledb components.
*/}}
{{- define "eclipse-backend.timescaledb.labels" }}
labels:
  app: {{ .Release.Name }}-timescaledb
{{- include "eclipse-backend.labels" . }}
{{- end }}

{{/*
Metadata for eclipse-backend emqx components.
*/}}
{{- define "eclipse-backend.emqx.labels" }}
labels:
  app: {{ .Release.Name }}-emqx
{{- include "eclipse-backend.labels" . }}
{{- end }}

{{/*
Metadata for eclipse-backend components.
*/}}
{{- define "eclipse-backend.labels" }}
  generator: helm
  chart: {{ .Chart.Name }}
  version: {{ .Chart.Version }}
{{- end }}

