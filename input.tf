variable "account_id" {
  description = "The Cloudflare account ID."
  type        = string
}

variable "alias_www" {
  description = "If true, an alias record (CNAME) `www` will be created for all custom domains"
  type        = bool
  default     = true
}

variable "build_root_dir" {
  description = "The root directory in the repository where the build command should be run. Defaults to the root of the repository."
  default     = ""
  type        = string
}

variable "custom_domains" {
  description = "A list of custom domains to associate with the project. Do not add domains with www. prefix here, use the `alias_www` variable instead. Each custom domain must have a `name` and `zone_id` attribute. The `name` attribute is the domain name and the `zone_id` attribute is the Cloudflare zone ID for the domain."
  type        = list(map(string))
  default     = []
  # validation {
  #   condition     = alltrue([contains(keys(element(var.custom_domains, count.index)), "name"), contains(keys(element(var.custom_domains, count.index)), "zone_id")])
  #   error_message = "Each custom domain must have a `name` and `zone_id` attribute."
  # }
}

variable "deployments_enabled" {
  description = "Enable deployments for the project."
  default     = true
  type        = bool
}

variable "environment_variables" {
  description = "A map of environment variables to set for the project in production and preview deployments. The map key is the environment variable name and the value is the environment variable value."
  type        = map(string)
  default     = {}
}

variable "preview_environment_variables" {
  description = "A map of environment variables to set for the project in preview deployments in precedence to `environment_variables`. The map key is the environment variable name and the value is the environment variable value."
  type        = map(string)
  default     = {}
}

variable "pr_comments_enabled" {
  description = "Enable Cloudflare Pages to comment on Pull Requests if preview deployments are enabled."
  default     = true
  type        = bool
}

variable "production_branch" {
  description = "The Git branch to use for production deployments."
  default     = "main"
  type        = string
}

variable "production_environment_variables" {
  description = "A map of environment variables to set for the project in production deployments in precedence to `environment_variables`. The map key is the environment variable name and the value is the environment variable value."
  type        = map(string)
  default     = {}
}

variable "project_name" {
  description = "The name of the Cloudflare pages project."
  type        = string
}

variable "repo_name" {
  description = "The name of the repository. This is the part after the `repo_owner` in the repository slug."
  type        = string
}

variable "repo_owner" {
  description = "The owner of the repository. This is the very first part of the repository slug."
  type        = string
}

variable "repo_type" {
  description = "The SCM platform where the repository is hosted. Valid values are 'github' or 'gitlab'."
  type        = string
  default     = "github"
  validation {
    condition     = contains(["github", "gitlab"], var.repo_type)
    error_message = "The repo_type must be either 'github' or 'gitlab'."
  }
}
