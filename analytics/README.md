# Analytics

## List of Analytics

| Analytic                                                     | Description                                                  | ATT&CK TTP                                                   | Platform     |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------ |
| [Autoscaling Threshold Exceeded](azure_autoscaling_threshold_exceeded.yml)                               | Sigma correlation rule that identifies when the number of instances in the resource group is greater than the threshold | Resource Hijacking (T1496)                                   | Azure        |
| [Guest User Privilege Escalation](azure_guest_user_priv_escalation.yml)                              | Identifies when a guest user has privileges escalated to Global Administrator. | Valid Accounts (T1078)                                       | Azure        |
| [Guest User Privilege Escalation then Storage Blob Access Modified](azure_correlation_guest_priv_esc_then_storage_public.yml) | Sigma correlation rule that identifies the sequence of events when privileges of a guest user are escalated, and the same guest user makes a storage container for public access. | Valid Accounts (T1078), Modify Cloud Compute Infrastructure (T1578) | Azure        |
| [Role Elevated Outside of PIM](azure_role_elevated_outside_pim.yml)                                 | Identifies when a privileged role assignment has been made outside of the Privileged Identity Management tool. | Domain Policy Modification (T1484)                           | Azure        |
| [Service Principal Privilege Escalation](azure_service_principal_priv_escalation.yml)                       | Identifies when a service principal has privileges escalated to Global Administrator. | Valid Accounts (T1078)                                       | Azure        |
| [Storage Blob Access Modified](azure_storage_container_modified_for_public_access.yml)                                 | Identifies when a previously existing storage container has access control modified to enable public access. | Modify Cloud Compute Infrastructure (T1578)                  | Azure        |
| [Multi-Factor Authentication Failure Threshold Exceeded](azure_mfa_failure_threshold_exceeded.yml)       | Identifies when a user has failed multifactor authentication within a time window more than a pre-defined threshold. | Credential Access: Multi-Factor Authentication Request Generation (T1621) | Azure        |
| [Autoscaling Threshold Exceeded](gcp_autoscaling_threshold_exceeded.yml)                               | Sigma correlation rule that identifies when autoscaling events have exceeded a pre-threshold. | Resource Hijacking (T1496)                                   | Google Cloud |
| [Permissions Granted Over Service Account](gcp_perms_granted_over_service_acct.yml)                     | Identifies when permissions granted to principal to impersonate or create keys for a service account. | Domain Policy Modification: Domain Trust Modification (T1484.002) | Google Cloud |
| [SSH Key Added](gcp_ssh_key_added.yml)                                                | Identifies when an SSH key is added to an instance.          | Account Manipulation: Additional Cloud Credentials (T1098.001) | Google Cloud |
| [Google Storage Bucket Access Modified](gcp_storage_container_modified_for_public_access.yml)                        | Identifies when a previously existing storage container has access control modified to enable public access. | Modify Cloud Compute Infrastructure (T1578)                  | Google Cloud |
| [Google VPC Service Controls Violation for Storage Bucket Access](gcp_violate_vpc_controls_storage_bucket.yml) | Identifies when a Storage Bucket access attempt has been blocked by VPC Service Controls. | Valid Accounts: Cloud Accounts (T1078.004), Exfiltration: Transfer Data to Cloud Account (T1537) | Google Cloud |
| [Workspace Login Marked Suspicious](gworkspace_suspicious_login.yml)                            | Identifies when a workspace login is marked suspicious.      | Valid Accounts: Cloud Accounts (T1078.004)                   | Google Cloud |
| [Workspace User Added to Privileged Group](gworkspace_user_added_priv_group.yml)                     | Identifies when a user is added to a privileged group.       | Valid Accounts: Cloud Accounts (T1078.004), Account Manipulation: Additional Cloud Roles (T1098.003) | Google Cloud |

## ATT&CK Mapping



ATT&CK Navigator heatmap of sigma rules.

![](cloud_analytics_sigma_rules_heatmap.svg)
