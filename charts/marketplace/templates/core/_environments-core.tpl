{{/*
Context Path
*/}}
{{- define "marketplace.core.envs.context-path" -}}
{{- if and (eq .Values.core.ingress.enabled true) .Values.core.ingress.path }}
- name: SERVER_SERVLET_CONTEXT_PATH
  value: {{ .Values.core.ingress.path }}
{{- end }}
{{- end }}
