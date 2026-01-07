{{/*
Custom Environments
*/}}
{{- define "eclipse-shared.customEnvs" -}}
{{- range . }}
- name: {{ .name }}
  value: {{ .value }}
{{- end }}
{{- end }}

{{/*
Metadata for eclipse-backend core components.
*/}}
{{- define "eclipse-shared.keycloak.labels" }}
labels:
  app: {{ .Release.Name }}-keycloak
{{- include "eclipse-shared.labels" . }}
{{- end }}

{{/*
Metadata for eclipse-backend components.
*/}}
{{- define "eclipse-shared.labels" }}
  generator: helm
  date: {{ now | htmlDate }}
  chart: {{ .Chart.Name }}
  version: {{ .Chart.Version }}
{{- end }}

