module "cloudflare_pages_hugo_project" {
  source       = "github.com/komailio/terraform-modules-cloudflare-pages-hugo"
  account_id   = "my-cloudflare-account-id"
  project_name = "komailio"
  repo_owner   = "komailo"
  repo_name    = "komail.io"
  custom_domains = [
    # Don't add www records, they will be created for you if `alias_www` is set to true (the default) in the module parameters.
    {
      name    = "komail.io"
      zone_id = "my_zone_id"
    },
  ]
}
