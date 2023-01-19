# Slurm Terraform final project

Task: create machine image in Yandex Cloud with Packer and deploy instance group using this image in the cloud. Instance group should create application load balancer. All possible values should be configured with variables. 

```
git clone git@github.com:pavigor/slurm-tf-final-project.git
```

## Packer
Create image with Nginx deployed with Ansible provisioner.

### 1. Set variables
Fill `variables.pkrvars.hcl` with your Yandex Cloud credentials

### 2. Start build
```
cd packer
packer build -var-file=variables.pkrvars.hcl .
```

## Terraform
Deploy infrastructure with three subnets (one per AZ), instance group and application load balancer.

### 1. Set variables
Fill `variables.tf` with your Yandex Cloud credentials

### 2. Deploy infra
```
cd terraform
terraform apply -var-file=var.tfvars
```