require 'rails_helper'

describe HelenaAdministration::DashboardController do
  routes { HelenaAdministration::Engine.routes }
  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
