# almost credentials configuration
{{- define "secret" -}}
POSTGRES_DB: {{ .Values.POSTGRES_DB }}
POSTGRES_USER: {{ .Values.POSTGRES_USER }}
POSTGRES_PASSWORD: {{ .Values.POSTGRES_PASSWORD }}
{{- end -}}


# for db configuration for application
{{- define "secretConfig" -}}
{{ (.Files.Glob "conf.toml").AsConfig | indent 2 }}
{{- end }}