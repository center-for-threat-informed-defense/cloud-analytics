<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.12.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 4.12.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 1.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_artifact_registry_repository.ca_repo](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_artifact_registry_repository) | resource |
| [google-beta_google_artifact_registry_repository_iam_member.test-iam](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_artifact_registry_repository_iam_member) | resource |
| [google-beta_google_service_account.ca-test-account](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_service_account) | resource |
| [google_compute_address.public_lb_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.allow-ssh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_container_cluster.primary](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_secret_manager_secret.secret-basic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.secret-version-basic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_service_account.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [kubernetes_deployment.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_service.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [google_client_config.provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the storage bucket. | `string` | `"tf_bucket_test"` | no |
| <a name="input_bucket_policy_only"></a> [bucket\_policy\_only](#input\_bucket\_policy\_only) | Enables Bucket Policy Only access to a bucket. | `bool` | `true` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | n/a | `map(string)` | <pre>{<br>  "env": "cloud-analytics-test"<br>}</pre> | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | When deleting a bucket, this boolean option will delete all contained objects. If false, Terraform will fail to delete buckets which contain objects. | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Set of key/value label pairs to assign to the bucket. | `map(string)` | `null` | no |
| <a name="input_machine-type"></a> [machine-type](#input\_machine-type) | n/a | `string` | `"n1-standard-1"` | no |
| <a name="input_project"></a> [project](#input\_project) | GCP Project to be used for creating resources | `string` | `"cloud-analytics-342815"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-east1"` | no |
| <a name="input_replica_region"></a> [replica\_region](#input\_replica\_region) | Region to use for replicas | `string` | `"us-central1"` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | Name of Artifact registry repository. | `string` | `"ca-repo"` | no |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | Configuration of the bucket's data retention policy for how long objects in the bucket should be retained. | <pre>object({<br>    is_locked        = bool<br>    retention_period = number<br>  })</pre> | `null` | no |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | Storage class of the new bucket. | `string` | `"STANDARD"` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | While set to true, versioning is fully enabled for this bucket. | `bool` | `false` | no |
| <a name="input_vm_image"></a> [vm\_image](#input\_vm\_image) | Image to use for vm | `string` | `"centos-7-v20200910"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `string` | `"us-east1-c"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_url"></a> [public\_url](#output\_public\_url) | n/a |
<!-- END_TF_DOCS -->
