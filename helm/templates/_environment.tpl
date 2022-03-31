# all environment variable should be defined here
{{- define "environment" -}}
envFrom:
  - secretRef:
      name: {{ .Release.Name }}-secret-config
{{- end -}}