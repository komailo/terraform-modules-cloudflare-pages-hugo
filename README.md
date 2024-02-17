<!-- BEGIN_TF_DOCS -->
{{ .Content }}
<!-- END_TF_DOCS -->

## Terraform Cannot Enable Web Analytics

At this time its not possible to enable Web Analytics from Terraform.
The API token permission required is not known. You will have to manually create a Web Analytics resource and use the keys.

https://github.com/cloudflare/terraform-provider-cloudflare/issues/2517#issuecomment-1617849763
https://community.cloudflare.com/t/which-api-token-permissions-are-required-for-cloudflare-web-analytics-site/603102
