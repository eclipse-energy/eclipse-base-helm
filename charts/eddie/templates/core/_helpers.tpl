{{/*
Volume for data needs config
*/}}
{{- define "eddie.core.data-needs.envs" }}
- name: EDDIE_DATA_NEEDS_CONFIG_DATA_NEED_SOURCE
  value: {{ .Values.core.dataNeedsConfig.source | quote }}
{{- if eq .Values.core.dataNeedsConfig.source "config" }}
- name: EDDIE_DATA_NEEDS_CONFIG_FILE
  value: "/opt/data-needs/data-needs.json"
{{- end }}
{{- end }}

{{/*
Volume for data needs config
*/}}
{{- define "eddie.core.data-needs.volumes" }}
{{- if eq .Values.core.dataNeedsConfig.source "config" }}
- name: data-needs-config
  configMap:
    name: {{ .Release.Name }}-core-data-needs-configmap
{{- end }}
{{- end }}

{{/*
Volume Mounts for data needs config
*/}}
{{- define "eddie.core.data-needs.volume-mounts" }}
{{- if eq .Values.core.dataNeedsConfig.source "config" }}
- name: data-needs-config
  mountPath: /opt/data-needs/data-needs.json
  subPath: data-needs.json
{{- end }}
{{- end }}
