provider "github" {
  token = var.github_token
  owner = var.github_owner
}

resource "github_repository" "auto_push_repo" {
  name        = var.repo_name
  description = "Repo created by Terraform to auto-push code using GitHub Actions"
  visibility  = "public"
  auto_init   = true
}

resource "github_repository_file" "push_workflow" {
  repository       = github_repository.auto_push_repo.name
  file             = ".github/workflows/auto-push.yml"
  content          = file("${path.module}/../.github/workflows/auto-push.yml")
  branch           = "main"
  commit_message   = "Add GitHub Actions workflow to auto-push"
  overwrite_on_create = true
}
