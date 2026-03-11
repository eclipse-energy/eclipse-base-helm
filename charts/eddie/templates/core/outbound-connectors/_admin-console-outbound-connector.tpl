{{/*
Environment variable mappings for Admin Console Outbound Connector
*/}}
{{- define "eddie.outbound-connectors.admin-console.envs" }}
{{- $adminConsoleValues := .Values.outboundConnectors.adminConsole }}
{{- $ocPrefix := "OUTBOUND_CONNECTOR_ADMIN_CONSOLE" }}
- name: {{ $ocPrefix }}_ENABLED
  value: {{ $adminConsoleValues.enabled | quote }}
{{- if eq $adminConsoleValues.enabled true }}
{{- end }}
{{- end }}
