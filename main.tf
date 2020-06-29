locals {
  virtualization = {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filters = {
    amzn2 = { owners : ["amazon"], filters : { name : { name : "name", values : ["amzn2-ami-hvm-*-x86_64-ebs"] }, type : local.virtualization } }

    ubuntu_18_04 = { owners : ["099720109477"], filters : { name : { name : "name", values : ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"] }, type : local.virtualization } }
    ubuntu_18_10 = { owners : ["099720109477"], filters : { name : { name : "name", values : ["ubuntu/images/hvm-ssd/ubuntu-cosmic-18.10-amd64-server-*"] }, type : local.virtualization } }
    ubuntu_19_04 = { owners : ["099720109477"], filters : { name : { name : "name", values : ["ubuntu/images/hvm-ssd/ubuntu-disco-19.04-amd64-server-*"] }, type : local.virtualization } }
    ubuntu_20_04 = { owners : ["099720109477"], filters : { name : { name : "name", values : ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"] }, type : local.virtualization } }

    centos_6 = { owners : ["679593333241"], filters : { name : { name : "name", values : ["CentOS Linux 6 x86_64 HVM EBS *"] }, type : local.virtualization } }
    centos_7 = { owners : ["679593333241"], filters : { name : { name : "name", values : ["CentOS Linux 7 x86_64 HVM EBS *"] }, type : local.virtualization } }

    rhel_6 = { owners : ["309956199498"], filters : { name : { name : "name", values : ["RHEL-6.10_HVM-20190923-x86_64-1-Hourly2-GP2"] }, type : local.virtualization } }
    rhel_7 = { owners : ["309956199498"], filters : { name : { name : "name", values : ["RHEL-7.?*GA*"] }, type : local.virtualization } }
    rhel_8 = { owners : ["309956199498"], filters : { name : { name : "name", values : ["RHEL-8.*_HVM-*"] }, type : local.virtualization } }

    debian_8 = { owners : ["679593333241"], filters : { name : { name : "name", values : ["debian-jessie-*-hvm-*"] }, type : local.virtualization } }
    debian_9 = { owners : ["679593333241"], filters : { name : { name : "name", values : ["debian-stretch-hvm-x86_64-*"] }, type : local.virtualization } }
    debian_10 = { owners : ["679593333241"], filters : { name : { name : "name", values : ["debian-10-*"] }, type : local.virtualization } }

    windows_2012_R2 = { owners : ["801119661308"], filters : { name : { name : "name", values : ["Windows_Server-2012-R2_RTM-English-*-Base*"] }, type : local.virtualization } }
    windows_2016 = { owners : ["801119661308"], filters : { name : { name : "name", values : ["Windows_Server-2016-English-Full-Base*"] }, type : local.virtualization } }
    windows_2019 = { owners : ["801119661308"], filters : { name : { name : "name", values : ["Windows_Server-2019-English-Full-Base*"] }, type : local.virtualization } }
  }
}

locals {
  enabled = lookup(local.filters, var.os, null) != null
}

data "aws_ami" "all" {
  count = local.enabled ? 1 : 0

  most_recent = true
  owners      = local.filters[var.os].owners

  dynamic "filter" {
    for_each = local.filters[var.os].filters
    content {
      name   = filter.value.name
      values = filter.value.values
    }
  }
}