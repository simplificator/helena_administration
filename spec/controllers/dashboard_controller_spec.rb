require 'spec_helper'

describe HelenaAdministration::DashboardController do
  routes { HelenaAdministration::Engine.routes }
  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response.status).to eq 200
    end
  end
end
