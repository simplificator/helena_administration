require 'spec_helper'

feature 'Dashboard' do
  scenario 'User visits the index page that links to the survey management' do
    visit dashboard_index_path

    expect(page).to have_link 'Manage Surveys', href: surveys_path
  end
end
