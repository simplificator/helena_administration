module HelenaAdministration
  class ApplicationController < ::ApplicationController
    def add_breadcrumb(name, path = nil, options = {})
      super(name.presence || t('shared.untitled'), path, options)
    end
  end
end
