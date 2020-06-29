output "supported_os" {
  description = "List of supported OS"
  value       = keys(local.filters)
}

output "filters" {
  description = "Map of AMI filters properties"
  value       = local.filters
}

output "ami_id" {
  description = "Returns `data.aws_ami` informations if `var.os` is set."
  value = local.enabled ? data.aws_ami.all[0].id : format("unsupported os:%s", var.os)
}

output "AMAZON_LINUX_2" { value = "amzn2" }
output "UBUNTU_18_04" { value = "ubuntu_18_04" }
output "UBUNTU_18_10" { value = "ubuntu_18_10" }
output "UBUNTU_19_04" { value = "ubuntu_19_04" }
output "UBUNTU_20_04" { value = "ubuntu_20_04" }
output "CENT_OS_6" { value = "centos_6" }
output "CENT_OS_7" { value = "centos_7" }
output "RHEL_6" { value = "rhel_6" }
output "RHEL_7" { value = "rhel_7" }
output "RHEL_8" { value = "rhel_8" }
output "DEBIAN_8" { value = "debian_8" }
output "DEBIAN_9" { value = "debian_9" }
output "DEBIAN_10" { value = "debian_10" }
output "WINDOWS_2012_R2" { value = "windows_2012_R2" }
output "WINDOWS_2016" { value = "windows_2016" }
output "WINDOWS_2019" { value = "windows_2019" }
