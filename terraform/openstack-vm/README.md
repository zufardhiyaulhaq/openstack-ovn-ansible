### OpenStack Network Performance Test
- init terraform
```
terraform init
```

- Run all Test
```
bash script.sh
```

If you want to run spesific test

- apply with spesific tfvars
```
terraform apply -var-file="variables/snsc.tfvars"
```
