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
Metadata for jaeger components
*/}}
{{- define "eclipse-shared.jaeger.labels" }}
labels:
  app: {{ .Release.Name }}-keycloak
{{- include "eclipse-shared.labels" . }}
{{- end }}

{{/*
Metadata for keycloak components
*/}}
{{- define "eclipse-shared.keycloak.labels" }}
labels:
  app: {{ .Release.Name }}-keycloak
{{- include "eclipse-shared.labels" . }}
{{- end }}

{{/*
Metadata for shared components.
*/}}
{{- define "eclipse-shared.labels" }}
  generator: helm
  chart: {{ .Chart.Name }}
  version: {{ .Chart.Version }}
{{- end }}

{{/*
Azure Objectstore Destination Path helper
*/}}
{{- define "eclipse-shared.keycloak.postgres.object-store.destination-path" -}}
azure://{{ .blobStorage.storageName }}.blob.core.windows.net/{{ .blobStorage.containerName }}{{ if .blobStorage.blobName}}/{{ .blobStorage.blobName }}{{- end }}
{{- end }}
