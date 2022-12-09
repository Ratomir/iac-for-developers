login:
	az login
	az account set --subscription 7d3606d4-570b-45db-8693-3b74f57fe1ee

attach-acr:
	az aks update -n aks-sin22v3-dev -g rg-sin22v3-dev --attach-acr '/subscriptions/7d3606d4-570b-45db-8693-3b74f57fe1ee/resourceGroups/rg-sin22v3-dev/providers/Microsoft.ContainerRegistry/registries/crsin22v3dev'
	az aks check-acr -n aks-sin22v3-dev -g rg-sin22v3-dev --acr crsin22v3dev.azurecr.io

template:
	helm template --namespace sin22v3 --values ./services/$(service)/values.dev.yaml $(service) ./mainsinergija22 --set image.tag=$(tag)  --debug

install:
	helm upgrade --namespace sin22v3 --create-namespace --install --values ./services/$(service)/values.dev.yaml $(service) ./mainsinergija22 --set image.tag=$(tag)

template-schedule:
	make template service=schedule tag=$(tag)

install-schedule:
	make install service=schedule tag=$(tag)

template-payment:
	make template service=payment tag=$(tag)

install-payment:
	make install service=payment tag=$(tag)

template-simple:
	make template service=simple tag=$(tag)

install-simple:
	make install service=simple tag=$(tag)