{{/*
CORS Allowed Origins
*/}}
{{- define "eclipse-backend.core.envs.cors" -}}
{{- if .Values.core.corsAllowedOrigins }}
- name: ECLIPSE_CORS_ALLOWED_ORIGINS
  value: {{ .Values.core.corsAllowedOrigins }}
{{- end }}
{{- end }}

{{/*
Tracing
*/}}
{{- define "eclipse-backend.core.envs.tracing" -}}
{{- if .Values.core.tracing.url }}
- name: ECLIPSE_TRACING_URL
  value: {{ .Values.core.tracing.url }}
{{- end }}
{{- end }}

{{/*
Context Path
*/}}
{{- define "eclipse-backend.core.envs.context-path" -}}
{{- if and (eq .Values.ingress.enabled true) .Values.ingress.path }}
- name: SERVER_SERVLET_CONTEXT_PATH
  value: {{ .Values.ingress.path }}
{{- end }}
{{- end }}

{{/*
DB Environments
*/}}
{{- define "eclipse-backend.core.envs.db" -}}
{{/* Kafka Consumer Properties */}}
- name: ECLIPSE_DB_NAME
  value: eclipse-backend
- name: ECLIPSE_DB_URL
  value: jdbc:postgresql://{{ .Release.Name }}-timescaledb:5432/eclipse-backend
- name: ECLIPSE_DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.timescaledb.secret.name }}
      key: {{ .Values.timescaledb.secret.usernameKey }}
- name: ECLIPSE_DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.timescaledb.secret.name }}
      key: {{ .Values.timescaledb.secret.passwordKey }}
{{- end }}

{{/*
EDDIE Environments
*/}}
{{- define "eclipse-backend.core.envs.eddie" }}
- name: ECLIPSE_EDDIE_ID
  value: {{ .Values.core.eddie.id }}
- name: ECLIPSE_EDDIE_PUBLIC_URL
  value: {{ .Values.core.eddie.publicUrl }}
- name: ECLIPSE_EDDIE_VHD_DATA_NEED_ID
  value: {{ .Values.core.eddie.vhdDataNeedId }}
- name: ECLIPSE_EDDIE_PERMISSION_MONITOR_SCHEDULE
  value: {{ .Values.core.eddie.permissionMonitorSchedule }}
{{- end }}


{{/*
EDDIE Kafka Environments
*/}}
{{- define "eclipse-backend.core.envs.eddie-kafka" -}}
{{/* Kafka Consumer Properties */}}
- name: ECLIPSE_EDDIE_KAFKA_BOOTSTRAP_SERVERS
  value: {{ .Values.core.kafka.bootstrapServers }}
- name: ECLIPSE_EDDIE_KAFKA_CLIENT_ID
  value: {{ .Values.core.kafka.clientId }}
- name: ECLIPSE_EDDIE_KAFKA_GROUP_ID
  value: {{ .Values.core.kafka.groupId }}
{{/* SASL Authentication */}}
- name: ECLIPSE_EDDIE_KAFKA_SASL_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.core.kafka.saslSecret.name }}
      key: {{ .Values.core.kafka.saslSecret.usernameKey }}
- name: ECLIPSE_EDDIE_KAFKA_SASL_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.core.kafka.saslSecret.name }}
      key: {{ .Values.core.kafka.saslSecret.passwordKey }}
{{/* SSL Truststore */}}
- name: ECLIPSE_EDDIE_KAFKA_SSL_TRUST_STORE_LOCATION
  value: file://etc/certs/kafka/client.truststore.jks
- name: ECLIPSE_EDDIE_KAFKA_SSL_TRUST_STORE_PASSWORD
  valueFrom:
    secretKeyRef:
      key: {{ .Values.core.kafka.sslTrustStoreSecret.passwordKey }}
      name: {{ .Values.core.kafka.sslTrustStoreSecret.name }}
{{/* EDDIE specific properties */}}
- name: ECLIPSE_EDDIE_KAFKA_MESSAGE_FORMAT
  value: {{ .Values.core.kafka.messageFormat }}
- name: ECLIPSE_EDDIE_KAFKA_PERMISSION_CIM_VERSION
  value: {{ .Values.core.kafka.cim.permissionVersion }}
- name: ECLIPSE_EDDIE_KAFKA_VHD_CIM_VERSION
  value: {{ .Values.core.kafka.cim.vhdVersion }}
- name: ECLIPSE_EDDIE_KAFKA_RTR_CIM_VERSION
  value: {{ .Values.core.kafka.cim.rtrVersion }}
{{- end }}

{{/*
Keycloak Environments
*/}}
{{- define "eclipse-backend.core.envs.keycloak" }}
- name: ECLIPSE_KEYCLOAK_INTERNAL_HOST
  value: {{ .Values.keycloak.internalHost }}
- name: ECLIPSE_KEYCLOAK_EXTERNAL_HOST
  value: {{ .Values.keycloak.externalHost }}
- name: ECLIPSE_KEYCLOAK_REALM
  value: {{ .Values.keycloak.realm }}
- name: ECLIPSE_KEYCLOAK_CLIENT_ID
  value: {{ .Values.core.keycloak.clientId }}
{{- end }}

{{/*
MQTT Environments
*/}}
{{- define "eclipse-backend.core.envs.mqtt" }}
{{- if eq .Values.emqx.enabled true }}
- name: ECLIPSE_MQTT_SERVER_URI
  value: "tcp://{{ .Release.Name }}-emqx:1883"
- name: ECLIPSE_MQTT_USERNAME
  value: "eclipse"
- name: ECLIPSE_MQTT_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.emqx.secret.name }}
      key: {{ .Values.emqx.secret.mqttPasswordKey }}
{{- end }}
{{- end }}
