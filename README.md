# Module : terraform-aws-ami-helper

<p align="left">
<a href="https://github.com/recarnot/terraform-aws-convention/"><img alt="Terraform version" src="https://img.shields.io/badge/Terraform-%3E%3D0.12-orange" /></a>
<a href="https://registry.terraform.io/modules/recarnot/convention/aws/"><img alt="Terraform registry" src="https://img.shields.io/github/v/release/recarnot/terraform-aws-convention" /></a>
<a href="https://github.com/recarnot/terraform-aws-convention/actions"><img alt="Plan check" src="https://github.com/recarnot/terraform-aws-convention/workflows/Plan%20check/badge.svg" /></a>
<a href="https://github.com/recarnot/terraform-aws-convention/actions"><img alt="Security check" src="https://github.com/recarnot/terraform-aws-convention/workflows/Security%20check/badge.svg" /></a>
<a href="https://registry.terraform.io/modules/recarnot/convention/aws/"><img alt="Terraform registry" src="https://img.shields.io/badge/Terraform-registry-blue" /></a>
</p>
This [**Terraform**](https://www.terraform.io/) module is just an helper to easily find some useful  **[AWS](https://aws.amazon.com/fr/console/)** AMI id.

No resources created 



## How to use

You can use this module with Terraform **OSS** or Terraform **Cloud**/**Enterprise**.



#### Directly retrieve AMI Id for a dedicated supported OS

```typescript
module "helper" {
  source  = "recarnot/ami-helper/aws"
  os = module.helper.AMAZON_LINUX_2
}

output "id" {
    value = module.helper.ami_id
}
```

ds

```typescript
module "helper" {
  source  = "recarnot/ami-helper/aws"
}

locals {
  infos = module.helper.filters[module.helper.UBUNTU_18_04]
}

data "aws_ami" "all" {
  most_recent = true
  owners      = infos.owners

  dynamic "filter" {
    for_each = infos.filters
    content {
      name   = filter.value.name
      values = filter.value.values
    }
  }
}
```



## Outputs

These properties are exposed as module output.

| Name         | Description                   | Type         |
| ------------ | ----------------------------- | ------------ |
| supported_os | List of supported OS          | list(string) |
| filters      | Map of AMI filters properties | map(string)  |



## Supported OS 

- Amazon Linux 2
- Ubuntu 18.04
- Ubuntu 18.10
- Ubuntu 19.04
- Ubuntu 20.04
- Cent OS 6
- Cent OS 7
- Red Hat Enterprise Linux 6
- Red Hat Enterprise Linux 7
- Red Hat Enterprise Linux 8
- Debian 8
- Debian 9
- Debian 10
- Windows 2012 R2
- Windows 2016
- Windows 2019

ARM Architectures is not yet supported.


