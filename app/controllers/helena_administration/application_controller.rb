module HelenaAdministration
  class ApplicationController < ActionController::Base
    before_action :set_locale, :authenticate_administrator

    def add_breadcrumb(name, path = nil, options = {})
      super(name.presence || t('shared.untitled'), path, options)
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    helper_method :can_administer?

    def authenticate_administrator
      fail(ActionController::RoutingError, 'Access Denied') unless can_administer?
    end
  end
end
