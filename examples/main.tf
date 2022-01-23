

resource "random_uuid" "random_id" {
  count = 4
}

module "azurerm_app_reg" {

  source  = "Pujago/azuread-app-registration/azurerm"
  version = "1.0.0"

  display_name = "Sample-application"

  owners = [data.azuread_client_config.current.object_id]

  # To set application uri to api//<app_id>, you need to update via script, this is not possible in terraform
  identifier_uris = ["api://Sample-application"]

  prevent_duplicate_names = true

  #use this code for adding scopes
  api = {
    mapped_claims_enabled          = false
    requested_access_token_version = 2
    known_client_applications      = []
    oauth2_permission_scope = [{
      admin_consent_description  = "Role use to secure the api for TestScope_01"
      admin_consent_display_name = "TestScope_01"
      id                         = element(random_uuid.random_id[*].result, 0)
      type                       = "User"
      value                      = "TestScope_01"
    }]
  }

  #use this code for adding app_roles
  app_role = [
    {
      allowed_member_types = ["Application"]
      description          = "Giving write permission to the apim proxy as 'Query-01.Read'"
      display_name         = "Query-01.Read"
      id                   = element(random_uuid.random_id[*].result, 1)
      value                = "Query-01.Read"
    },
    {
      allowed_member_types = ["Application"]
      description          = "Giving write permission to the apim proxy as 'Query-01.Write'"
      display_name         = "Query-01.Write"
      id                   = element(random_uuid.random_id[*].result, 2)
      value                = "Query-01.Write"
    }
  ]

  #use this code for adding api permissions
  required_resource_access = [{
    # Microsoft Graph
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access = [{
      # User.Read
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }]
  }]


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
  }

    web = {
    redirect_uris = ["https://abc.com/", "https://cde.com/", "https://fgh.com/abc", "https://ijk.com/"]
  }


  tags = ["Sample application", "terraform"]


}









