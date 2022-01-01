

resource "azuread_application" "main" {
  # mandatory arguments
  display_name = var.display_name

  # Optional arguments
  device_only_auth_enabled       = var.device_only_auth_enabled
  fallback_public_client_enabled = var.fallback_public_client_enabled


  group_membership_claims       = var.group_membership_claims
  identifier_uris               = var.identifier_uris
  marketing_url                 = var.marketing_url
  oauth2_post_response_required = var.oauth2_post_response_required



  dynamic "optional_claims" {
    for_each = var.optional_claims != null ? ["true"] : []
    content {

      dynamic "access_token" {
        for_each = var.optional_claims.access_token != null ? ["true"] : []

        content {
          additional_properties = var.optional_claims.access_token.additional_properties
          essential             = var.optional_claims.access_token.essential
          name                  = var.optional_claims.access_token.name
          source                = var.optional_claims.access_token.source

        }
      }

      dynamic "id_token" {
        for_each = var.optional_claims.id_token != null ? ["true"] : []

        content {
          additional_properties = var.optional_claims.id_token.additional_properties
          essential             = var.optional_claims.id_token.essential
          name                  = var.optional_claims.id_token.name
          source                = var.optional_claims.id_token.source

        }
      }

      dynamic "saml2_token" {
        for_each = var.optional_claims.saml2_token != null ? ["true"] : []

        content {
          additional_properties = var.optional_claims.saml2_token.additional_properties
          essential             = var.optional_claims.saml2_token.essential
          name                  = var.optional_claims.saml2_token.name
          source                = var.optional_claims.saml2_token.source

        }
      }
    }
  }


  owners                  = var.owners
  prevent_duplicate_names = var.prevent_duplicate_names
  privacy_statement_url   = var.privacy_statement_url
  template_id             = var.template_id
  terms_of_service_url    = var.terms_of_service_url
  logo_image              = var.logo_image


  sign_in_audience = var.sign_in_audience
  support_url      = var.support_url

  dynamic "public_client" {
    for_each = var.public_client != null ? ["true"] : []
    content {
      redirect_uris = var.public_client.redirect_uris
    }
  }

  dynamic "single_page_application" {
    for_each = var.single_page_application != null ? ["true"] : []
    content {
      redirect_uris = var.single_page_application.redirect_uris
    }
  }

  dynamic "api" {
    for_each = var.api != null ? ["true"] : []
    content {
      mapped_claims_enabled          = var.api.mapped_claims_enabled
      requested_access_token_version = var.api.requested_access_token_version
      known_client_applications      = var.api.known_client_applications

      dynamic "oauth2_permission_scope" {
        for_each = var.api.oauth2_permission_scope
        iterator = scope
        content {
          admin_consent_description  = scope.value.admin_consent_description
          admin_consent_display_name = scope.value.admin_consent_display_name
          enabled                    = scope.value.enabled
          id                         = scope.value.id
          type                       = scope.value.type
          value                      = scope.value.value
        }
      }
    }
  }



  dynamic "web" {
    for_each = var.web != null ? ["true"] : []
    content {
      redirect_uris = var.web.redirect_uris
      homepage_url  = var.web.homepage_url
      logout_url    = var.web.logout_url

      dynamic "implicit_grant" {
        for_each = var.web.implicit_grant != null ? ["true"] : []

        content {
          access_token_issuance_enabled = var.web.implicit_grant.access_token_issuance_enabled
          id_token_issuance_enabled     = var.web.implicit_grant.id_token_issuance_enabled
        }
      }
    }
  }



  dynamic "app_role" {
    for_each = var.app_role
    iterator = app
    content {
      allowed_member_types = app.value.allowed_member_types
      description          = app.value.description
      display_name         = app.value.display_name
      enabled              = app.value.enabled
      id                   = app.value.id
      value                = app.value.value
    }
  }


  dynamic "required_resource_access" {
    for_each = var.required_resource_access
    iterator = resource
    content {
      resource_app_id = resource.value.resource_app_id

      dynamic "resource_access" {
        for_each = resource.value.resource_access
        iterator = access
        content {
          id   = access.value.id
          type = access.value.type
        }
      }
    }
  }

  tags = var.tags
}


resource "azuread_service_principal" "main" {
  # Mandatory arguments
  application_id = azuread_application.main.application_id

  #Option arguments
  app_role_assignment_required  = var.app_role_assignment_required
  owners                        = var.owners
  alternative_names             = var.alternative_names
  account_enabled               = var.account_enabled
  description                   = var.description
  login_url                     = var.login_url
  notes                         = var.notes
  notification_email_addresses  = var.notification_email_addresses
  preferred_single_sign_on_mode = var.preferred_single_sign_on_mode

  dynamic "saml_single_sign_on" {
    for_each = var.saml_single_sign_on != null ? ["true"] : []
    content {
      relay_state = var.saml_single_sign_on.relay_state
    }
  }

  tags = var.tags

}

resource "azuread_application_password" "main" {
  application_object_id = azuread_application.main.object_id
  display_name          = var.password_display_name
}







