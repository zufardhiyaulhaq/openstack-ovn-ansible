terraform apply -var-file="variables/snsc.tfvars" -auto-approve
terraform destroy -var-file="variables/snsc.tfvars" -auto-approve
terraform apply -var-file="variables/sndc.tfvars" -auto-approve
terraform destroy -var-file="variables/sndc.tfvars" -auto-approve
terraform apply -var-file="variables/dndc.tfvars" -auto-approve
terraform destroy -var-file="variables/dndc.tfvars" -auto-approve
terraform apply -var-file="variables/dnsc.tfvars" -auto-approve
terraform destroy -var-file="variables/dnsc.tfvars" -auto-approve
