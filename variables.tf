# For Resource: azuread_application

# Mandatory arguments
variable "display_name" {
  type        = string
  description = "The display name for the application."
}

# Optional arguments
variable "api" {
  description = "An optional api block, which configures API related settings for this application."
  type = object({
    mapped_claims_enabled          = bool,
    requested_access_token_version = number,
    known_client_applications      = list(string),
    oauth2_permission_scope = list(object({
      admin_consent_description  = string,
      admin_consent_display_name = string,
      enabled                    = bool,
      id                         = string,
      type                       = string,
      user_consent_description   = string,
      user_consent_display_name  = string,
      value                      = string
    }))
  })
  default = null
}

variable "app_role" {
  description = "A collection of app_role blocks."
  type = list(
    object({
      allowed_member_types = list(string),
      description          = string,
      display_name         = string,
      enabled              = bool,
      id                   = string,
      value                = string
  }))
  default = []
}

variable "device_only_auth_enabled" {
  description = "Specifies whether this application supports device authentication without a user."
  type        = bool
  default     = false
}



variable "fallback_public_client_enabled" {
  description = "Specifies whether the application is a public client. Appropriate for apps using token grant flows that don't use a redirect URI."
  type        = bool
  default     = false
}

variable "group_membership_claims" {
  description = "Configures the groups claim issued in a user or OAuth 2.0 access token that the app expects. Possible values are `None`, `SecurityGroup` or `All`."
  type        = list(string)
  default     = ["SecurityGroup"]
}

variable "identifier_uris" {
  description = "A list of user-defined URI(s) that uniquely identify a Web application within it's Azure AD tenant, or within a verified custom domain if the application is multi-tenant."
  type        = list(string)
  default     = []
}

variable "logo_image" {
  description = " A logo image to upload for the application, as a raw base64-encoded string. The image should be in gif, jpeg or png format. Note that once an image has been uploaded, it is not possible to remove it without replacing it with another image."
  type        = string
  default     = null
}

variable "marketing_url" {
  description = "The URL to the application's home page. If no homepage is specified this defaults to `https://{name}`"
  type        = string
  default     = null
}

variable "oauth2_post_response_required" {
  description = "Specifies whether, as part of OAuth 2.0 token requests, Azure AD allows POST requests, as opposed to GET requests."
  type        = bool
  default     = false
}

variable "optional_claims" {
  description = "An optional claim block"
  type = object({
    access_token = object({
      additional_properties = list(string),
      essential             = string,
      name                  = string,
      source                = string
    }),
    id_token = object({
      additional_properties = list(string),
      essential             = string,
      name                  = string,
      source                = string
    }),
    saml2_token = object({
      additional_properties = list(string),
      essential             = string,
      name                  = string,
      source                = string
    }),
  })
  default = null
}

variable "owners" {
  description = "A set of object IDs of principals that will be granted ownership of the application. Supported object types are users or service principals."
  type        = list(string)
  default     = []
}

variable "prevent_duplicate_names" {
  description = "If true, will return an error if an existing application is found with the same name."
  type        = bool
  default     = false
}

variable "privacy_statement_url" {
  description = "URL of the application's privacy statement."
  type        = string
  default     = null
}

variable "public_client" {
  description = "To configure non-web app or non-web API application settings, for example mobile or other public clients such as an installed application running on a desktop device. Must be a valid https or ms-appx-web URL."
  type = object({
    redirect_uris = list(string)
  })
  default = null
}

variable "required_resource_access" {
  description = "A collection of required resource access for this application."
  type = list(
    object({
      resource_app_id = string,
      resource_access = list(
        object({
          id   = string,
          type = string
      }))
  }))
  default = []
}

variable "sign_in_audience" {
  description = "The Microsoft account types that are supported for the current application. Must be one of `AzureADMyOrg`, `AzureADMultipleOrgs`, `AzureADandPersonalMicrosoftAccount` or `PersonalMicrosoftAccount`."
  type        = string
  default     = "AzureADMyOrg"
}

variable "single_page_application" {
  description = "A single_page_application block, which configures single-page application (SPA) related settings for this application."
  type = object({
    redirect_uris = list(string)
  })
  default = null
}

variable "support_url" {
  description = "URL of the application's support page."
  type        = string
  default     = null
}

# Both tags and feature tags cannot be used, for custom tags use tag argument. This module uses tags
variable "tags" {
  description = "A set of tags to apply to the application. Cannot be used together with the feature_tags block"
  type        = list(string)
  default     = []
}

variable "template_id" {
  description = "Unique ID for a templated application in the Azure AD App Gallery, from which to create the application."
  type        = string
  default     = null
}

variable "terms_of_service_url" {
  description = "URL of the application's terms of service statement."
  type        = string
  default     = null
}

variable "web" {
  description = "Configures web related settings for this application"
  type = object({
    homepage_url  = string,
    logout_url    = string,
    redirect_uris = list(string),

    implicit_grant = object({
      access_token_issuance_enabled = bool,
      id_token_issuance_enabled     = bool,
    })
  })
  default = null
}

# For Resource: azuread_service_principal

#Mandatory arguments
# application_id assigned directly from the azuread_application resource created

# Optional arguments

variable "account_enabled" {
  description = "Whether or not the service principal account is enabled."
  type        = bool
  default     = true
}

variable "alternative_names" {
  description = "A set of alternative names, used to retrieve service principals by subscription, identify resource group and full resource ids for managed identities."
  type        = list(string)
  default     = []
}
variable "app_role_assignment_required" {
  description = "Whether this service principal requires an app role assignment to a user or group before Azure AD will issue a user or access token to the application. Defaults to false."
  type        = bool
  default     = false
}


variable "description" {
  description = "A description of the service principal provided for internal end-users."
  type        = string
  default     = null
}

variable "login_url" {
  description = "The URL where the service provider redirects the user to Azure AD to authenticate. Azure AD uses the URL to launch the application from Microsoft 365 or the Azure AD My Apps. When blank, Azure AD performs IdP-initiated sign-on for applications configured with SAML-based single sign-on."
  type        = string
  default     = null
}

variable "notes" {
  description = "A free text field to capture information about the service principal, typically used for operational purposes."
  type        = string
  default     = null
}

variable "notification_email_addresses" {
  description = "A free text field to capture information about the service principal, typically used for operational purposes."
  type        = list(string)
  default     = []
}


variable "preferred_single_sign_on_mode" {
  description = "The single sign-on mode configured for this application. Azure AD uses the preferred single sign-on mode to launch the application from Microsoft 365 or the Azure AD My Apps. Supported values are `oidc`, `password`, `saml` or `notSupported`. Omit this property or specify a blank string to unset."
  type        = string
  default     = null
}

variable "saml_single_sign_on" {
  description = "A saml single sign-on block"
  type = object({
    relay_state = string
  })
  default = null
}


# For Resource: azuread_application_password

variable "password_display_name" {
  type        = string
  description = "A display name for the password."
}







