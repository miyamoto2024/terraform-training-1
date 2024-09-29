export

TF_VAR_project_name := $(shell gcloud config list project --format='value(core.project)')
TF_VAR_region       := asia-northeast1

fmt:
	terraform fmt -recursive

validate:
	terraform validate

init:
	terraform init

plan:
	make fmt
	make validate
	terraform plan

apply:
	terraform apply

destroy:
	terraform destroy
