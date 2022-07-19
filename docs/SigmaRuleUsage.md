# Sigma Rule Usage

***Status: In Progress***

The goal of this document is to cover information relating to Sigma rule creation, usage, and best practices.



## What is Sigma

The [Sigma](https://github.com/SigmaHQ/sigma) project consists of two main components, Sigma rules, and Sigma converters. Sigma rules are platform independent, and allow for the security community to quickly provide core queries for known vulnerability or attacker behavior. The generic rule can then be converted to any platform with a supported converter to provide platform-specific queries.



## Rules

The Sigma rule, a generic and open signature format for describing log events, also referred to as signatures, use YAML Ain't Markup Language (YAML) format, and must adhere to the [YAML schema specification](https://github.com/SigmaHQ/sigma/wiki/Specification).

Sigma rules have a handful of required fields (title, logsource, detection, condition), with the majority of fields optional for flexibility. To date, the community has provided hundreds of rules, and some organizations such as [Recorded Future](https://www.recordedfuture.com/sigma-rules-and-credential-harvesting) and [SOC Prime](https://socprime.com/news/soc-prime-provides-a-smoking-guns-sigma-rules-list-to-give-organizations-a-competitive-advantage-in-cyber-war/) maintain custom rulesets for subscribers. It is worth noting that rules contributed to the Sigma community project must meet [more stringent guidelines](https://github.com/SigmaHQ/sigma/wiki/Rule-Creation-Guide) defined in the Sigma documentation.



### Creation

Getting started creating Sigma rules can be challenging. The [recommended method](https://github.com/SigmaHQ/sigma/wiki/Rule-Creation-Guide) for creating a new rule is to identify an existing rule that is somewhat close to the proposed new rule, for example starting with an existing rule which uses the same cloud platform or operating system.

The [Sigma documentation on rule creation](https://github.com/SigmaHQ/sigma/wiki/Rule-Creation-Guide), as well as community resources from [SOC Prime](https://socprime.com/blog/sigma-rules-the-beginners-guide/), [BluSapphire](https://docs.blusapphire.io/sigma-rules/creating-sigma-rule), and [blog posts](https://syedhasan010.medium.com/defenders-toolkit-102-sigma-rules-4a623acb2036), do a good job of covering the basics, but I have highlighted a few points of interest.



| Field                  | Notes                                                        |
| :--------------------- | :----------------------------------------------------------- |
| title                  | Use title casing, less than 50 characters                    |
| status                 | All new rules community start as `experimental` status, promoted after successful community usage. |
| tags                   | Reference ATT&CK, CAR when relevant, for example `attack.t1059` or `car.2014-04-003` |
| logsource.product      | For cloud services, convention is `product` to represent the cloud provider, such as `azure` or `gcp`. |
| logsource.service[1]() | For cloud services, convention is `service` to represent the specific log the alert will be found in. For example, `azureactivity`  represents the `auditlogs` represents the Azure Audit Logs, while `gcp.audit` represents the the Google Audit Log source. |

Log source definitions can be particularly confusing for Sigma rules related to cloud services.

logsource.service





*Tip: The [Visual Studio Code `sigma` plugin](https://marketplace.visualstudio.com/items?itemName=humpalum.sigma) is useful during Sigma rule development. The plugin flags common issues in Sigma rule creation such as missing fields, and provides useful features such as generating new UUIDs for a rule.*



### Usage



#### Converters

The Sigma converter, such as [Sigmac](https://github.com/SigmaHQ/sigma/blob/master/tools/README.md), a conversion tool for converting generic Sigma rules to platform-specific queries.



### Azure

### GCP



## References

[^1]: Log source definitions can be particularly confusing for Sigma rules related to cloud services. For example, in the case of GCP and Google Workspace, the first Sigma rules were added around August 2021 and used "gcp.audit" and "google_workspace.admin", respectively. After that, the Hawk (hawk.io) tool configuration started referencing those strings.
