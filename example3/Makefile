login:
	az login
	az account set --subscription 7d3606d4-570b-45db-8693-3b74f57fe1ee
	
clean:
	cls

init:
	make clean
	terraform init

workspace?:
	terraform workspace list

workspace-dev:
	make clean
	terraform workspace select dev
	make init

plan-dev:
	make init
	terraform plan -var-file="variables/dev.tfvars"

apply-dev:
	make init
	terraform apply -var-file="variables/dev.tfvars"

workspace-qa:
	make clean
	terraform workspace select qa
	make init

plan-qa:
	make init
	terraform plan -var-file="variables/qa.tfvars"

apply-qa:
	make init
	terraform apply -var-file="variables/qa.tfvars"