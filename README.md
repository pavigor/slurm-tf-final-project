# Slurm Terraform final project

Task: create machine image in Yandex Cloud with Packer and deploy instance group using this image in the cloud. Instance group should create application load balancer. All possible values should be configured with variables. 

```
git clone git@github.com:pavigor/slurm-tf-final-project.git
```

## Packer
**Task:** Create image with Nginx deployed with Ansible provisioner.

### 1. Set variables
Fill `variables.pkrvars.hcl` with your Yandex Cloud credentials

### 2. Start build
```
cd packer
packer build -var-file=variables.pkrvars.hcl .
```

## Terraform
**Task:** Deploy infrastructure with three subnets (one per AZ), instance group and application load balancer.

### Install Yandex Cloud CLI (YC)
```
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
```
Follow [instructions](https://cloud.yandex.com/en/docs/cli/quickstart#install) to configure YC 

### 1. Set auth data for Yandex provider
```
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
```

### 2. Set variables
Fill `variables.tf` with your requirements

### 2. Deploy infra
```
cd terraform
terraform init
terraform apply -var-file=var.tfvars
```