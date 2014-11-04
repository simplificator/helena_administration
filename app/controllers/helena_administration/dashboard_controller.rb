module HelenaAdministration
  class DashboardController < ApplicationController
    before_action :add_breadcrumbs

    private

    def add_breadcrumbs
      add_breadcrumb t('shared.navigation.dashboard'), dashboard_index_path
    end
  end
end
