{{/* Helper for http protocol */}}
{{- define "eclipse-aiida.ingress.protocol" }}
{{- if .Values.ingress.tlsEnabled }}https{{- else }}http{{- end }}
{{- end }}

{{/* Helper to build the external core host */}}
{{- define "eclipse-aiida.core.external-host" -}}
{{ include "eclipse-aiida.ingress.protocol" . }}://{{ .Values.ingress.host }}{{ .Values.core.path }}
{{- end }}