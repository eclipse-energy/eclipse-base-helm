{{/*
Environment variable mappings for Kafka Outbound Connector
*/}}
{{- define "eddie.outbound-connectors.kafka.envs" }}
{{- $ocPrefix := "OUTBOUND_CONNECTOR_KAFKA" }}
{{- $kafkaValues := .Values.outboundConnectors.kafka }}
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
