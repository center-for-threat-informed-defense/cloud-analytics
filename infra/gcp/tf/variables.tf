variable "machine-type" {
  type    = string
  default = "n1-standard-1"
}
variable "zone" {
  type    = string
  default = "us-east1-c"
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "vm_image" {
  type        = string
  default     = "centos-7-v20200910"
  description = "Image to use for vm"
}

variable "bucket_name" {
  description = "Name of the storage bucket."
  type        = string
  default     = "tf_bucket_test"
}

variable "storage_class" {
  description = "Storage class of the new bucket."
  type        = string
  default     = "STANDARD"
}
variable "labels" {
  description = "Set of key/value label pairs to assign to the bucket."
  type        = map(string)
  default     = null
}
variable "bucket_policy_only" {
  description = "Enables Bucket Policy Only access to a bucket."
  type        = bool
  default     = true
}
variable "versioning" {
  description = "While set to true, versioning is fully enabled for this bucket."
  type        = bool
  default     = false
}
variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects. If false, Terraform will fail to delete buckets which contain objects."
  type        = bool
  default     = false
}
variable "retention_policy" {
  description = "Configuration of the bucket's data retention policy for how long objects in the bucket should be retained."
  type = object({
    is_locked        = bool
    retention_period = number
  })
  default = null
}
