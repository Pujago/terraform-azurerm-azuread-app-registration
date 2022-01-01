
resource "random_uuid" "random_id" {
  count = 4
}


module "azurerm_app_reg" {

  source = "Pujago/azuread/appregistration"

  display_name = "test-example"

  #use this code for adding scopes
  api = {
    mapped_claims_enabled          = false
    requested_access_token_version = 2
    known_client_applications      = []
    oauth2_permission_scope = [{
      admin_consent_description  = "Role use to secure the api for T01"
      admin_consent_display_name = "Scope_Test01"
      id                         = element(random_uuid.random_id[*].result, 0)
      enabled                    = true
      type                       = "User"
      user_consent_description   = "test"
      user_consent_display_name  = "test"
      value                      = "Scope_Test01"
      },
      {
        admin_consent_description  = "Role use to secure the api for R01"
        admin_consent_display_name = "Scope_Test02"
        id                         = element(random_uuid.random_id[*].result, 1)
        enabled                    = true
        type                       = "User"
        user_consent_description   = "test"
        user_consent_display_name  = "test"
        value                      = "Scope_Test02"
    }]
  }

  #use this code for adding app_roles
  app_role = [
    {
      allowed_member_types = ["Application"]
      description          = "Giving write permission to the apim proxy as 'Test.Read'"
      display_name         = "Test.Read"
      enabled              = true
      id                   = element(random_uuid.random_id[*].result, 2)
      value                = "Test.Read"
    },
    {
      allowed_member_types = ["Application"]
      description          = "Giving write permission to the apim proxy as 'Test.Write'"
      display_name         = "Test.Write"
      enabled              = true
      id                   = element(random_uuid.random_id[*].result, 3)
      value                = "Test.Write"
    }
  ]

  device_only_auth_enabled = false
  fallback_public_client_enabled = false
  group_membership_claims = ["SecurityGroup"]

  # To set application uri to api//<app_id>, you need to update via script, this is not possible in terraform
  identifier_uris = ["api://test-example"]

  # path of the image to be specified
  logo_image = filebase64("/path/to/logo.png")

  marketing_url = null
  oauth2_post_response_required = false

  optional_claims = {
      access_token = {
      name = "myclaim"
    }
    access_token = {
      name = "otherclaim"
    }
    id_token = {
      name                  = "userclaim"
      source                = "user"
      essential             = true
      additional_properties = ["emit_as_roles"]
    }
    saml2_token = {
      name = "samlexample"
    }
  }

  owners = [data.azuread_client_config.current.object_id]

  prevent_duplicate_names = true

  privacy_statement_url = null

  public_client = {
    redirect_uris = []
  }

  #use this code for adding api permissions
  required_resource_access = [
    {
      # Microsoft Graph
      resource_app_id = "00000003-0000-0000-c000-000000000000"

      resource_access = [{
        # User.Read
        id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
        type = "Scope"
      }]
    },
    {
      # Microsoft Graph
      resource_app_id = module.azurerm_app_reg.client_id

      resource_access = [
        {
          # User.Read
          id   = module.azurerm_app_reg.app_role_ids["Test.Read"]
          type = "Role"
        }
        ,
        {
          # User.Read
          #id   = element(random_uuid.random_id[*].result, 0)
          id   = module.azurerm_app_reg.app_role_ids["Test.Write"]
          type = "Role"
        }
      ]
    }
  ]

  sign_in_audience = "AzureADMyOrg"

  single_page_application = {
    redirect_uris = []
  }

  support_url = null

  tags = ["NONPROD", "Integration", "terraform"]

  # template id of azuread_application_template (application from gallery template)
  template_id = null

  terms_of_service_url = null

  web = {
    homepage_url  = null
    logout_url    = null
    redirect_uris = ["https://abc.com/","https://cde.com/","https://fgh.com/abc","https://ijk.com/"]
    implicit_grant = {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = false
    }

  }

  password_display_name = "test"

  
}