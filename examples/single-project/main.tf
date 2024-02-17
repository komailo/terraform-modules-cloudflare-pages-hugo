module "cloudflare_pages_hugo_project" {
  source       = "https://github.com/Komailio/terraform-modules-cloudflare-pages-hugo"
  account_id   = "my-cloudflare-account-id"
  project_name = "my-project"
  repo_owner   = "Komailio"
  repo_name    = "hugo-komail.io"
  custom_domains = [
    # Don't add www records, they will be created for you if `alias_www` is set to true (the default) in the module parameters.
    {
      name    = "komail.io"
      zone_id = "my_zone_id"
    },
  ]
}
