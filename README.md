# terraform-azurerm-azuread-app-registration
Azure app registration module that create application registration, scopes, app roles, password credentials.

In this release, I have updated the example of how a module is called to create 2 applications - one is the authorizer (audience application or web api), and another is the authorized (i.e. client application)

Audience application will create following:

1. App roles as `Query-01.Read` and `Query-01.Write`
2. Oauth2_permission_scope `TestScope_01`
3. Microsoft Graph `User.Read` permission
4. Service principal
5. Password Credentials
6. Identifier Uris ( # To set application uri to api//<app_id>, you need to update via script, this is not possible in terraform)

Audience application will create following:

1. Grant application permissions for client app to access the above created web api
2. Microsoft Graph User.Read delegated permission
3. Service principal
4. Password Credentials
5. Redirect Uris or reply uris where the authorization server sends the user once the app has been successfully authorized and granted an authorization code or access token. The authorization server sends the code or token to the redirect URI, so it's important you register the correct location as part of the app registration process.

Note: Not all applications need password credentials to be generated for e.g. audience application, To achieve that a separate module can be created for `azuread_application_password` resource. For the simplicity. I have added this resource in same module along with the resource `azuread_application`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.13.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.59.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_password.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_service_principal.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_enabled"></a> [account\_enabled](#input\_account\_enabled) | Whether or not the service principal account is enabled. | `bool` | `true` | no |
| <a name="input_alternative_names"></a> [alternative\_names](#input\_alternative\_names) | A set of alternative names, used to retrieve service principals by subscription, identify resource group and full resource ids for managed identities. | `list(string)` | `[]` | no |
| <a name="input_api"></a> [api](#input\_api) | An optional api block, which configures API related settings for this application. | <pre>object({<br>    mapped_claims_enabled          = bool,<br>    requested_access_token_version = number,<br>    known_client_applications      = list(string),<br>    oauth2_permission_scope = list(object({<br>      admin_consent_description  = string,<br>      admin_consent_display_name = string,<br>      enabled                    = bool,<br>      id                         = string,<br>      type                       = string,<br>      user_consent_description   = string,<br>      user_consent_display_name  = string,<br>      value                      = string<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_app_role"></a> [app\_role](#input\_app\_role) | A collection of app\_role blocks. | <pre>list(<br>    object({<br>      allowed_member_types = list(string),<br>      description          = string,<br>      display_name         = string,<br>      enabled              = bool,<br>      id                   = string,<br>      value                = string<br>  }))</pre> | `[]` | no |
| <a name="input_app_role_assignment_required"></a> [app\_role\_assignment\_required](#input\_app\_role\_assignment\_required) | Whether this service principal requires an app role assignment to a user or group before Azure AD will issue a user or access token to the application. Defaults to false. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the service principal provided for internal end-users. | `string` | `null` | no |
| <a name="input_device_only_auth_enabled"></a> [device\_only\_auth\_enabled](#input\_device\_only\_auth\_enabled) | Specifies whether this application supports device authentication without a user. | `bool` | `false` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the application. | `string` | n/a | yes |
| <a name="input_fallback_public_client_enabled"></a> [fallback\_public\_client\_enabled](#input\_fallback\_public\_client\_enabled) | Specifies whether the application is a public client. Appropriate for apps using token grant flows that don't use a redirect URI. | `bool` | `false` | no |
| <a name="input_group_membership_claims"></a> [group\_membership\_claims](#input\_group\_membership\_claims) | Configures the groups claim issued in a user or OAuth 2.0 access token that the app expects. Possible values are `None`, `SecurityGroup` or `All`. | `list(string)` | <pre>[<br>  "SecurityGroup"<br>]</pre> | no |
| <a name="input_identifier_uris"></a> [identifier\_uris](#input\_identifier\_uris) | A list of user-defined URI(s) that uniquely identify a Web application within it's Azure AD tenant, or within a verified custom domain if the application is multi-tenant. | `list(string)` | `[]` | no |
| <a name="input_login_url"></a> [login\_url](#input\_login\_url) | The URL where the service provider redirects the user to Azure AD to authenticate. Azure AD uses the URL to launch the application from Microsoft 365 or the Azure AD My Apps. When blank, Azure AD performs IdP-initiated sign-on for applications configured with SAML-based single sign-on. | `string` | `null` | no |
| <a name="input_logo_image"></a> [logo\_image](#input\_logo\_image) | A logo image to upload for the application, as a raw base64-encoded string. The image should be in gif, jpeg or png format. Note that once an image has been uploaded, it is not possible to remove it without replacing it with another image. | `string` | `null` | no |
| <a name="input_marketing_url"></a> [marketing\_url](#input\_marketing\_url) | The URL to the application's home page. If no homepage is specified this defaults to `https://{name}` | `string` | `null` | no |
| <a name="input_notes"></a> [notes](#input\_notes) | A free text field to capture information about the service principal, typically used for operational purposes. | `string` | `null` | no |
| <a name="input_notification_email_addresses"></a> [notification\_email\_addresses](#input\_notification\_email\_addresses) | A free text field to capture information about the service principal, typically used for operational purposes. | `list(string)` | `[]` | no |
| <a name="input_oauth2_post_response_required"></a> [oauth2\_post\_response\_required](#input\_oauth2\_post\_response\_required) | Specifies whether, as part of OAuth 2.0 token requests, Azure AD allows POST requests, as opposed to GET requests. | `bool` | `false` | no |
| <a name="input_optional_claims"></a> [optional\_claims](#input\_optional\_claims) | An optional claim block | <pre>object({<br>    access_token = object({<br>      additional_properties = list(string),<br>      essential             = string,<br>      name                  = string,<br>      source                = string<br>    }),<br>    id_token = object({<br>      additional_properties = list(string),<br>      essential             = string,<br>      name                  = string,<br>      source                = string<br>    }),<br>    saml2_token = object({<br>      additional_properties = list(string),<br>      essential             = string,<br>      name                  = string,<br>      source                = string<br>    }),<br>  })</pre> | `null` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | A set of object IDs of principals that will be granted ownership of the application. Supported object types are users or service principals. | `list(string)` | `[]` | no |
| <a name="input_password_display_name"></a> [password\_display\_name](#input\_password\_display\_name) | A display name for the password. | `string` | `null` | no |
| <a name="input_preferred_single_sign_on_mode"></a> [preferred\_single\_sign\_on\_mode](#input\_preferred\_single\_sign\_on\_mode) | The single sign-on mode configured for this application. Azure AD uses the preferred single sign-on mode to launch the application from Microsoft 365 or the Azure AD My Apps. Supported values are `oidc`, `password`, `saml` or `notSupported`. Omit this property or specify a blank string to unset. | `string` | `null` | no |
| <a name="input_prevent_duplicate_names"></a> [prevent\_duplicate\_names](#input\_prevent\_duplicate\_names) | If true, will return an error if an existing application is found with the same name. | `bool` | `false` | no |
| <a name="input_privacy_statement_url"></a> [privacy\_statement\_url](#input\_privacy\_statement\_url) | URL of the application's privacy statement. | `string` | `null` | no |
| <a name="input_public_client"></a> [public\_client](#input\_public\_client) | To configure non-web app or non-web API application settings, for example mobile or other public clients such as an installed application running on a desktop device. Must be a valid https or ms-appx-web URL. | <pre>object({<br>    redirect_uris = list(string)<br>  })</pre> | `null` | no |
| <a name="input_required_resource_access"></a> [required\_resource\_access](#input\_required\_resource\_access) | A collection of required resource access for this application. | <pre>list(<br>    object({<br>      resource_app_id = string,<br>      resource_access = list(<br>        object({<br>          id   = string,<br>          type = string<br>      }))<br>  }))</pre> | `[]` | no |
| <a name="input_saml_single_sign_on"></a> [saml\_single\_sign\_on](#input\_saml\_single\_sign\_on) | A saml single sign-on block | <pre>object({<br>    relay_state = string<br>  })</pre> | `null` | no |
| <a name="input_sign_in_audience"></a> [sign\_in\_audience](#input\_sign\_in\_audience) | The Microsoft account types that are supported for the current application. Must be one of `AzureADMyOrg`, `AzureADMultipleOrgs`, `AzureADandPersonalMicrosoftAccount` or `PersonalMicrosoftAccount`. | `string` | `"AzureADMyOrg"` | no |
| <a name="input_single_page_application"></a> [single\_page\_application](#input\_single\_page\_application) | A single\_page\_application block, which configures single-page application (SPA) related settings for this application. | <pre>object({<br>    redirect_uris = list(string)<br>  })</pre> | `null` | no |
| <a name="input_support_url"></a> [support\_url](#input\_support\_url) | URL of the application's support page. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A set of tags to apply to the application. Cannot be used together with the feature\_tags block | `list(string)` | `[]` | no |
| <a name="input_template_id"></a> [template\_id](#input\_template\_id) | Unique ID for a templated application in the Azure AD App Gallery, from which to create the application. | `string` | `null` | no |
| <a name="input_terms_of_service_url"></a> [terms\_of\_service\_url](#input\_terms\_of\_service\_url) | URL of the application's terms of service statement. | `string` | `null` | no |
| <a name="input_web"></a> [web](#input\_web) | Configures web related settings for this application | <pre>object({<br>    homepage_url  = string,<br>    logout_url    = string,<br>    redirect_uris = list(string),<br><br>    implicit_grant = object({<br>      access_token_issuance_enabled = bool,<br>      id_token_issuance_enabled     = bool,<br>    })<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_role_ids"></a> [app\_role\_ids](#output\_app\_role\_ids) | A mapping of app role values to app role IDs, as published by the associated application, intended to be useful when referencing app roles in other resources in your configuration. |
| <a name="output_app_roles"></a> [app\_roles](#output\_app\_roles) | A list of app roles published by the associated application. |
| <a name="output_application_tenant_id"></a> [application\_tenant\_id](#output\_application\_tenant\_id) | The tenant ID where the associated application is registered. |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | The application id of AzureAD application created. |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | The password for this application, which is generated by Azure Active Directory. |
| <a name="output_disabled_by_microsoft"></a> [disabled\_by\_microsoft](#output\_disabled\_by\_microsoft) | Whether Microsoft has disabled the registered application. If the application is disabled, this will be a string indicating the status/reason, e.g. DisabledDueToViolationOfServicesAgreement. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the application associated with this service principal. |
| <a name="output_homepage_url"></a> [homepage\_url](#output\_homepage\_url) | Home page or landing page of the associated application. |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | A UUID used to uniquely identify this password credential. |
| <a name="output_logo_url"></a> [logo\_url](#output\_logo\_url) | CDN URL to the application's logo, as uploaded with the logo\_image property. |
| <a name="output_logout_url"></a> [logout\_url](#output\_logout\_url) | The URL that will be used by Microsoft's authorization service to log out an user using OpenId Connect front-channel, back-channel or SAML logout protocols, taken from the associated application. |
| <a name="output_oauth2_permission_scope_ids"></a> [oauth2\_permission\_scope\_ids](#output\_oauth2\_permission\_scope\_ids) | A mapping of OAuth2.0 permission scope values to scope IDs. |
| <a name="output_oauth2_permission_scopes"></a> [oauth2\_permission\_scopes](#output\_oauth2\_permission\_scopes) | A list of OAuth 2.0 delegated permission scopes exposed by the associated application. |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The object id of application. Can be used to assign roles to user. |
| <a name="output_publisher_domain"></a> [publisher\_domain](#output\_publisher\_domain) | The verified publisher domain for the application. |
| <a name="output_service_principal_names"></a> [service\_principal\_names](#output\_service\_principal\_names) | A list of identifier URI(s), copied over from the associated application. |
| <a name="output_sign_in_audience"></a> [sign\_in\_audience](#output\_sign\_in\_audience) | The Microsoft account types that are supported for the associated application. Possible values include AzureADMyOrg, AzureADMultipleOrgs, AzureADandPersonalMicrosoftAccount or PersonalMicrosoftAccount. |
| <a name="output_sp_object_id"></a> [sp\_object\_id](#output\_sp\_object\_id) | The object Id of Service principal. |
| <a name="output_type"></a> [type](#output\_type) | Identifies whether the service principal represents an application or a managed identity. |
<!-- END_TF_DOCS -->