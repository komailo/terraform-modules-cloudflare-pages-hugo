resource "cloudflare_pages_project" "cloudflare_pages_hugo_github_project" {
  account_id        = var.account_id
  name              = var.project_name
  production_branch = var.production_branch

  build_config {
    build_command   = "hugo"
    destination_dir = "public"
    root_dir        = var.build_root_dir
  }

  deployment_configs {
    preview {
      always_use_latest_compatibility_date = true
      environment_variables = merge(var.environment_variables, var.preview_environment_variables, {
        "HUGO_ENVIRONMENT" = "preview"
      })
      usage_model = "standard"
    }
    production {
      always_use_latest_compatibility_date = false
      environment_variables = merge(var.environment_variables, var.production_environment_variables, {
        "HUGO_ENVIRONMENT" = "production"
      })
      usage_model = "standard"
    }
  }

  source {
    type = var.repo_type
    config {
      deployments_enabled        = var.deployments_enabled
      owner                      = var.repo_owner
      pr_comments_enabled        = var.pr_comments_enabled
      preview_branch_excludes    = [var.production_branch]
      preview_branch_includes    = ["*"]
      preview_deployment_setting = "all"
      production_branch          = var.production_branch
      repo_name                  = var.repo_name
    }
  }
}

resource "cloudflare_pages_domain" "page_domains" {
  for_each     = { for custom_domain in var.custom_domains : custom_domain.name => custom_domain }
  account_id   = var.account_id
  project_name = var.project_name
  domain       = each.key
  # 
  depends_on = [
    cloudflare_pages_project.cloudflare_pages_hugo_github_project
  ]
}

resource "cloudflare_record" "page_domains" {
  for_each = { for custom_domain in var.custom_domains : custom_domain.name => custom_domain }
  zone_id  = each.value.zone_id
  name     = each.key
  value    = cloudflare_pages_project.cloudflare_pages_hugo_github_project.subdomain
  type     = "CNAME"
  comment  = "managed by: terraform"
  proxied  = true
}

resource "cloudflare_pages_domain" "www_alias" {
  for_each     = { for custom_domain in var.custom_domains : custom_domain.name => custom_domain if var.alias_www }
  account_id   = var.account_id
  project_name = var.project_name
  domain       = "www.${each.key}"
  depends_on = [
    cloudflare_pages_project.cloudflare_pages_hugo_github_project
  ]
}

resource "cloudflare_record" "www_alias" {
  for_each = { for custom_domain in var.custom_domains : custom_domain.name => custom_domain if var.alias_www }
  zone_id  = each.value.zone_id
  name     = "www.${each.key}"
  value    = each.key
  type     = "CNAME"
  comment  = "managed by: terraform"
  proxied  = true
}
