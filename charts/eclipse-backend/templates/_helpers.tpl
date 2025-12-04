{{- define "eclipse-backend.customEnvs" -}}
{{- range . }}
- name: {{ .name }}
  value: {{ .value }}
{{- end }}
{{- end }}
