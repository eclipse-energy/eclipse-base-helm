CHART_PATH?=.
TRACK?=stable

template:
	helm template $(CHART_PATH) --debug --output-dir ./out

template-local:
	helm template $(CHART_PATH) --values values-local.yaml --debug --output-dir ./out

package:
	helm package $(CHART_PATH) \
	--destination ../../repository/$(TRACK)/packages

index:
	helm repo index ../../repository/$(TRACK) \
	--url "https://eclipse-energy.github.io/eclipse-base-helm/$(TRACK)"