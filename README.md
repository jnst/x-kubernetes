# x-kubernetes

## Prepare infrastructure with Terraform

### Set variables

We will use Terraform Cloud to create a minimal Kubernetes cluster in GCP. Set the following variables in Terrarform Cloud.

#### Terraform Variables 

| Key | Description |
| ---- | ---- |
| PROJECT_ID | GCP Project ID |
| GOOGLE_CREDENTIALS | GCP credentials in JSON format text |

#### Environment Variables

| Key | Description |
| ---- | ---- |
| - | - |

### Set Slack notification

Workspaces -> x-kubernetes -> Settings -> Notifications -> Create a Notifications -> Slack

* https://slack.com/services/new/incoming-webhook

### Sync local and remote state

```bash
terraform login
terraform init
```
