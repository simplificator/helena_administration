module HelenaAdministration
  class ApplicationController < ActionController::Base
    before_action :set_locale

    def add_breadcrumb(name, path = nil, options = {})
      super(name.presence || t('shared.untitled'), path, options)
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
  end
end
