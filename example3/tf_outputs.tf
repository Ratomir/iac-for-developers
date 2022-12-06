output "application_id" {
  value = [
    for bd in module.sinergija22service : bd.application_id
  ]
}

output "k8s_csi_application_id" {
  value = data.azurerm_user_assigned_identity.kvcsi.client_id
}
