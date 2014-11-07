require 'rails_helper'

describe HelenaAdministration::SurveysController do
  routes { HelenaAdministration::Engine.routes }

  context 'without authorization' do
    before { allow_any_instance_of(HelenaAdministration::ApplicationController).to receive(:can_administer?).and_return false }

    specify 'trying to list surveys throws an error' do
      expect { get :index }.to raise_error(ActionController::RoutingError, 'Access Denied')
    end

    specify 'trying to edit a survey throws an error' do
      survey = create :survey
      expect { get :edit, id: survey }.to raise_error(ActionController::RoutingError, 'Access Denied')
    end

    specify 'trying to update a survey throws an error' do
      survey = create :survey
      expect { patch :update, id: survey }.to raise_error(ActionController::RoutingError, 'Access Denied')
    end

    specify 'trying to delete a survey throws an error' do
      survey = create :survey
      expect { delete :destroy, id: survey }.to raise_error(ActionController::RoutingError, 'Access Denied')
    end

    specify 'trying to add a survey throws an error' do
      expect { get :new }.to raise_error(ActionController::RoutingError, 'Access Denied')
    end

    specify 'trying to create a survey throws an error' do
      expect { post :create, some: :data }.to raise_error(ActionController::RoutingError, 'Access Denied')
    end
  end
end
