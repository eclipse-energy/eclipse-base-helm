{{/*
Environment variable mappings for Admin Console Outbound Connector
*/}}
{{- define "eddie.outbound-connectors.admin-console.envs" }}
{{- $adminConsoleValues := .Values.outboundConnectors.adminConsole }}
{{- $ocPrefix := "OUTBOUND_CONNECTOR_ADMIN_CONSOLE" }}
- name: {{ $ocPrefix }}_ENABLED
  value: {{ $adminConsoleValues.enabled | quote }}
{{- end }}

{{/*
Environment variable mappings for Kafka Outbound Connector
*/}}
{{- define "eddie.outbound-connectors.kafka.envs" }}
{{- $kafkaValues := .Values.outboundConnectors.kafka }}
{{- $ocPrefix := "OUTBOUND_CONNECTOR_KAFKA" }}
- name: {{ $ocPrefix }}_ENABLED
  value: {{ $kafkaValues.enabled | quote }}
{{- if eq $kafkaValues.enabled true }}
- name: KAFKA_SECURITY_PROTOCOL
  value: "SASL_PLAINTEXT"
- name: KAFKA_SASL_MECHANISM
  value: "PLAIN"
- name: KAFKA_BOOTSTRAP_SERVERS
  value: "{{ .Release.Name }}-kafka:9094"
- name: KAFKA_SASL_JAAS_CONFIG
  valueFrom:
    secretKeyRef:
      name: {{ .Values.core.secret.name }}
      key: {{ .Values.core.secret.kafkaJaasConfigKey }}
- name: {{ $ocPrefix }}_FORMAT
  value: {{ .Values.outboundConnectors.kafka.format | quote }}
- name: {{ $ocPrefix }}_EDDIE_ID
  value: {{ .Values.outboundConnectors.kafka.eddieId | quote }}
{{- end }}
{{- end }}
