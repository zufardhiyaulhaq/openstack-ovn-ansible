### Terraform Example
- copy ssh key
```
ssh-copy-id vagrant@10.201.102.250
```

- init terraform
```
terraform init
```

- apply with spesific tfvars
```
terraform apply -var-file="variables/internet.tfvars"
```
