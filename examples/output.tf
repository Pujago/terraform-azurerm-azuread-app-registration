# azuread_application attributes that are exported

output "audience_object_id" {
  description = "The object id of audience application. Can be used to assign roles to user."
  value       = module.azurerm_app_reg.object_id

}

output "audience_application_id" {
  description = "The audience application id of AzureAD application created."
  value       = module.azurerm_app_reg.client_id
}

output "audience_logo_url" {
  description = "CDN URL to the audience application's logo, as uploaded with the logo_image property."
  value       = module.azurerm_app_reg.logo_url
}

output "audience_disabled_by_microsoft" {
  description = "Whether Microsoft has disabled the registered audience application. If the application is disabled, this will be a string indicating the status/reason, e.g. DisabledDueToViolationOfServicesAgreement."
  value       = module.azurerm_app_reg.disabled_by_microsoft
}

output "audience_publisher_domain" {
  description = "The verified publisher domain for the audience application."
  value       = module.azurerm_app_reg.publisher_domain
}


output "client_object_id" {
  description = "The object id of client application. Can be used to assign roles to user."
  value       = module.azurerm_app_reg_client.object_id

}

output "client_application_id" {
  description = "The client application id of AzureAD application created."
  value       = module.azurerm_app_reg_client.client_id
}

output "client_logo_url" {
  description = "CDN URL to the client application's logo, as uploaded with the logo_image property."
  value       = module.azurerm_app_reg_client.logo_url
}

output "client_disabled_by_microsoft" {
  description = "Whether Microsoft has disabled the registered client application. If the application is disabled, this will be a string indicating the status/reason, e.g. DisabledDueToViolationOfServicesAgreement."
  value       = module.azurerm_app_reg_client.disabled_by_microsoft
}

output "client_publisher_domain" {
  description = "The verified publisher domain for the client application."
  value       = module.azurerm_app_reg_client.publisher_domain
}



# azuread_service_principal attributes that are exported

output "audience_display_name" {
  description = "The display name of the audience application associated with this service principal."
  value       = module.azurerm_app_reg.display_name
}

output "audience_service_principal" {
  description = "The object Id of Service principal for audience app"
  value       = module.azurerm_app_reg.sp_object_id
}

output "audience_app_role_ids" {
  description = "A mapping of app role values to app role IDs, as published by the associated application, intended to be useful when referencing app roles in other resources in your configuration."
  value       = module.azurerm_app_reg.app_role_ids
}

output "audience_oauth2_permission_scope_ids" {
  description = "A mapping of OAuth2.0 permission scope values to scope IDs."
  value       = module.azurerm_app_reg.oauth2_permission_scope_ids
}

output "audience_oauth2_permission_scopes" {
  description = "A mapping of OAuth2.0 permission scope values to scope IDs."
  value       = module.azurerm_app_reg.oauth2_permission_scopes
}

output "audience_app_roles" {
  description = "A mapping of OAuth2.0 permission scope values to scope IDs."
  value       = module.azurerm_app_reg.app_roles
}


output "client_display_name" {
  description = "The display name of the client application associated with this service principal."
  value       = module.azurerm_app_reg_client.display_name
}

output "client_service_principal" {
  description = "The object Id of Service principal of client application."
  value       = module.azurerm_app_reg_client.sp_object_id
}

output "Client_app_role_ids" {
  description = "A mapping of app role values to app role IDs, as published by the associated application, intended to be useful when referencing app roles in other resources in your configuration."
  value       = module.azurerm_app_reg_client.app_role_ids
}


output "client_oauth2_permission_scope_ids" {
  description = "A mapping of OAuth2.0 permission scope values to scope IDs."
  value       = module.azurerm_app_reg_client.oauth2_permission_scope_ids
}

output "client_oauth2_permission_scopes" {
  description = "A mapping of OAuth2.0 permission scope values to scope IDs."
  value       = module.azurerm_app_reg_client.oauth2_permission_scopes
}

output "client_app_roles" {
  description = "A mapping of OAuth2.0 permission scope values to scope IDs."
  value       = module.azurerm_app_reg_client.app_roles
}

output "application_tenant_id" {
  description = "The tenant ID where the associated application is registered."
  value       = module.azurerm_app_reg.application_tenant_id
}


output "homepage_url" {
  description = "Home page or landing page of the associated application."
  value       = module.azurerm_app_reg.homepage_url
}

output "logout_url" {
  description = "The URL that will be used by Microsoft's authorization service to log out an user using OpenId Connect front-channel, back-channel or SAML logout protocols, taken from the associated application."
  value       = module.azurerm_app_reg.logout_url
}

output "service_principal_names" {
  description = "A list of identifier URI(s), copied over from the associated application."
  value       = module.azurerm_app_reg.service_principal_names
}

output "sign_in_audience" {
  description = "The Microsoft account types that are supported for the associated application. Possible values include AzureADMyOrg, AzureADMultipleOrgs, AzureADandPersonalMicrosoftAccount or PersonalMicrosoftAccount."
  value       = module.azurerm_app_reg.sign_in_audience
}

output "type" {
  description = "Identifies whether the service principal represents an application or a managed identity."
  value       = module.azurerm_app_reg.type
}




# azuread_application_password attributes that are exported


output "Audience_key_id" {
  description = "A UUID used to uniquely identify this password credential for audience."
  value       = module.azurerm_app_reg.key_id
}

output "audience_secret" {
  description = "The password for this audience application, which is generated by Azure Active Directory."
  value       = module.azurerm_app_reg.client_secret
  sensitive   = true
}

output "Client_key_id" {
  description = "A UUID used to uniquely identify this password credential for client app."
  value       = module.azurerm_app_reg_client.key_id
}

output "client_secret" {
  description = "The password for client application, which is generated by Azure Active Directory."
  value       = module.azurerm_app_reg_client.client_secret
  sensitive   = true
}


