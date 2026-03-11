{{/*
Metadata for core components
*/}}
{{- define "eddie.core.labels" }}
labels:
  app: {{ .Release.Name }}-core
{{- include "eddie.labels" . }}
{{- end }}
{{/*

{{/*
Metadata for emqx components
*/}}
{{- define "eddie.emqx.labels" }}
labels:
  app: {{ .Release.Name }}-emqx
{{- include "eddie.labels" . }}
{{- end }}
{{/*

Metadata for kafka components
*/}}
{{- define "eddie.kafka.labels" }}
labels:
  app: {{ .Release.Name }}-kafka
{{- include "eddie.labels" . }}
{{- end }}

{{/*
Metadata for postgres components
*/}}
{{- define "eddie.postgres.labels" }}
labels:
  app: {{ .Release.Name }}-postgres
{{- include "eddie.labels" . }}
{{- end }}

{{/*
Metadata for eddie components
*/}}
{{- define "eddie.labels" }}
  generator: helm
  chart: {{ .Chart.Name }}
  version: {{ .Chart.Version }}
{{- end }}

{{/*
Helper to build the postgres Url
*/}}
{{- define "eddie.postgres-url" -}}
"jdbc:postgresql://{{ .Release.Name }}-postgres-rw:5432/{{ .Values.postgres.database }}"
{{- end }}

{{- define "eddie.extraEnv" -}}
{{- range . }}
- name: {{ .name }}
  value: {{ .value | quote }}
{{- end }}
{{- end }}

{{/*
Azure Objectstore Destination Path helper
*/}}
{{- define "eddie.postgres.object-store.destination-path" -}}
azure://{{ .blobStorage.storageName }}.blob.core.windows.net/{{ .blobStorage.containerName }}{{ if .blobStorage.blobName}}/{{ .blobStorage.blobName }}{{- end }}
{{- end }}
