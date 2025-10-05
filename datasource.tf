data "terraform_remote_state" "database" {
  backend = "remote"
  config = {
    organization = "SoatElevenFiapDhyogo"
    workspaces = {
      name = "SoatElevenFiapBd"
    }
  }
}