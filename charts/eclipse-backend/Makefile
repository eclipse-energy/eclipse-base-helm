CHART_PATH?=.
TRACK?=stable

package:
	helm package $(CHART_PATH) \
	--destination ../../repository/$(TRACK)/packages

index:
	helm repo index ../../repository/$(TRACK) \
	--url "https://eclipse-energy.github.io/eclipse-base-helm/$(TRACK)"