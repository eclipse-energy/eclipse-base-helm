{{/*
Context Path
*/}}
{{- define "federator.core.envs.context-path" -}}
{{- if and (eq .Values.ingress.enabled true) .Values.ingress.path }}
- name: SERVER_SERVLET_CONTEXT_PATH
  value: {{ .Values.ingress.path }}
{{- end }}
{{- end }}
