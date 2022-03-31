# database replica information, that value can be overrited at specific environment config
{{- define "dbreplica" -}}
{{- if .Values.postgres.replica -}}
replicas: {{ .Values.postgres.replica }}
{{- end -}}
{{- end -}}


# database replica information, that value can be overrited at specific environment config. 
# If we're using HPA for some env, that configuration will be skipped
{{- define "appreplica" -}}
{{- if not .Values.horizontalScaler.require -}}
replicas: {{ .Values.container.replica }}
{{- end -}}
{{- end -}}