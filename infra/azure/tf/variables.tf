variable "name" {
  type        = string
  description = "Location of the azure resource group."
  default     = "casandbox"
}

variable "environment" {
  type        = string
  description = "Name of the deployment environment"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Location to deploy the resoruce group"
  default     = "East US"
}

variable "dns_prefix" {
  type        = string
  description = "A prefix for any dns based resources"
  default     = "ca"
}

variable "plan_tier" {
  type        = string
  description = "The tier of app service plan to create"
  default     = "Standard"
}

variable "plan_sku" {
  type        = string
  description = "The sku of app service plan to create"
  default     = "S1"
}

variable "prefix" {
  type        = string
  description = "Prefix for all resources"
  default     = "ca"
}

variable "admin_username" {
  type        = string
  description = "The admin username for the VMs"
  default     = "adminuser"
}

variable "admin_password" {
  type        = string
  description = "The admin password for the VMs"
  default     = "Pa$$w0rd1234"
}

variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
  default     = 1
}
