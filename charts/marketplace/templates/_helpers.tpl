{{/*
Custom Environments
*/}}
{{- define "marketplace.customEnvs" -}}
{{- range . }}
- name: {{ .name }}
  value: {{ .value | quote }}
{{- end }}
{{- end }}

{{/*
Metadata for marketplace core components.
*/}}
{{- define "marketplace.core.labels" }}
labels:
  app: {{ .Release.Name }}-core
{{- include "marketplace.labels" . }}
{{- end }}

{{/*
Metadata for marketplace postgres components.
*/}}
{{- define "marketplace.postgres.labels" }}
labels:
  app: {{ .Release.Name }}-postgres
{{- include "marketplace.labels" . }}
{{- end }}

{{/*
Metadata for marketplace components.
*/}}
{{- define "marketplace.labels" }}
  generator: helm
  chart: {{ .Chart.Name }}
  version: {{ .Chart.Version }}
{{- end }}

{{/*
Azure Objectstore Destination Path helper
*/}}
{{- define "marketplace.postgres.object-store.destination-path" -}}
azure://{{ .blobStorage.storageName }}.blob.core.windows.net/{{ .blobStorage.containerName }}{{ if .blobStorage.blobName}}/{{ .blobStorage.blobName }}{{- end }}
{{- end }}
