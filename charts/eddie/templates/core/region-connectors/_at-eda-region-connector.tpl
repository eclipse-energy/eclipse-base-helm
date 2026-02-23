{{/*
Environment variable mappings for AT EDA region connector
*/}}
{{- define "eddie.region-connectors.at-eda.envs" }}
{{- $edaValues := .Values.regionConnectors.atEda }}
{{- $rcPrefix := "REGION_CONNECTOR_AT_EDA" }}
- name: {{ $rcPrefix }}_ENABLED
  value: {{ $edaValues.enabled | quote }}
{{- if eq $edaValues.enabled true }}
{{- $pontonValues := .Values.regionConnectors.atEda.pontonMessenger }}
{{- $pontonPrefix := "REGION_CONNECTOR_AT_EDA_PONTON_MESSENGER" }}
- name: {{ $rcPrefix }}_ELIGIBLEPARTY_ID
  value: {{ $edaValues.eligiblePartyId | quote }}
- name: {{ $pontonPrefix }}_ADAPTER_ID
  value: {{ $pontonValues.adapter.id | quote }}
- name: {{ $pontonPrefix }}_ADAPTER_VERSION
  value: {{ $pontonValues.adapter.version | quote }}
- name: {{ $pontonPrefix }}_HOSTNAME
  value: {{ $pontonValues.hostname | quote }}
- name: {{ $pontonPrefix }}_API_ENDPOINT
  value: {{ $pontonValues.apiEndpoint | quote }}
- name: {{ $pontonPrefix }}_PORT
  value: {{ $pontonValues.port | quote }}
- name: {{ $pontonPrefix }}_FOLDER
  value: {{ $pontonValues.folder | quote }}
- name: {{ $pontonPrefix }}_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Name }}-region-connector-secrets
      key: pontonUsername
- name: {{ $pontonPrefix }}_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Release.Name }}-region-connector-secrets
      key: pontonPassword
{{- end }}
{{- end }}

{{/*
Volumes for AT EDA region connector
*/}}
{{- define "eddie.region-connectors.at-eda.volumes" }}
- name: ponton
  persistentVolumeClaim:
    claimName: {{ .Release.Name }}-core-ponton-pvc
{{- end }}

{{/*
Volume Mounts for AT EDA region connector
*/}}
{{- define "eddie.region-connectors.at-eda.volume-mounts" }}
- name: ponton
  mountPath: /opt/ponton
{{- end }}
