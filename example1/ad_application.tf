###########################################
################# PAYMENT #################
###########################################
resource "azuread_application" "payment" {
  display_name = "${var.project_name}-payment-aks-${var.project_name}-${var.env}"
}

resource "azuread_service_principal" "payment" {
  application_id               = azuread_application.payment.application_id
  app_role_assignment_required = false
}

resource "azuread_application_federated_identity_credential" "payment" {
  application_object_id = azuread_application.payment.object_id
  display_name          = "${var.project_name}-payment-aks-${var.project_name}-${var.env}"
  description           = "Kubernetes service account federated credential for payment"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = azurerm_kubernetes_cluster.aks.oidc_issuer_url
  subject               = "system:serviceaccount:${var.project_name}:payment-aks-${var.project_name}-${var.env}"
}

###########################################
################# SCHEDULE ################
###########################################
resource "azuread_application" "schedule" {
  display_name = "${var.project_name}-schedule-aks-${var.project_name}-${var.env}"
}

resource "azuread_service_principal" "schedule" {
  application_id               = azuread_application.schedule.application_id
  app_role_assignment_required = false
}

resource "azuread_application_federated_identity_credential" "schedule" {
  application_object_id = azuread_application.schedule.object_id
  display_name          = "${var.project_name}-schedule-aks-${var.project_name}-${var.env}"
  description           = "Kubernetes service account federated credential for schedule"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = azurerm_kubernetes_cluster.aks.oidc_issuer_url
  subject               = "system:serviceaccount:${var.project_name}:schedule-aks-${var.project_name}-${var.env}"
}
