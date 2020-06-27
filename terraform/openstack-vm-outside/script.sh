terraform apply -var-file="variables/internet.tfvars" -auto-approve
terraform destroy -var-file="variables/internet.tfvars" -auto-approve
