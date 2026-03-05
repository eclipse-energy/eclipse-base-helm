CHART_PATH?=.
TRACK?=stable

template:
	helm template $(CHART_PATH) --debug --output-dir ./out

template-local:
	helm template $(CHART_PATH) --values values-local.yaml --debug --output-dir ./out
