###########################################
########### SINERGIJA 22 SERVICE ##########
###########################################
resource "azuread_application" "sinergija22service" {
  display_name = "${var.project_name}-${var.service_config_model.name}-aks-${local.service_name}"
}

resource "azuread_service_principal" "sinergija22service" {
  application_id               = azuread_application.sinergija22service.application_id
  app_role_assignment_required = false
}

resource "azuread_application_federated_identity_credential" "sinergija22service" {
  application_object_id = azuread_application.sinergija22service.object_id
  display_name          = "${var.project_name}-${var.service_config_model.name}-aks-${local.service_name}"
  description           = "Kubernetes service account federated credential for ${var.service_config_model.name}"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = var.aks_cluster.oidc_issuer_url
  subject               = "system:serviceaccount:${var.project_name}:${var.service_config_model.name}-aks-${local.service_name}"
}
