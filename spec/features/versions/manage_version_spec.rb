require 'spec_helper'

feature 'Versions ' do
  let!(:survey) { create :survey }
  let!(:baseversion) { survey.versions.create version: 0 }

  scenario 'Index site lists all versions'  do
    version = survey.versions.create notes: 'Awesome new version', version: 666

    visit survey_path(survey)

    within "##{dom_id(version)}" do
      expect(page).to have_content '666'
      expect(page).to have_content 'Awesome new version'
    end
  end

  scenario 'User publish a new version' do
    visit survey_path(survey)
    within 'table.versions' do
      click_link 'New'
    end

    within 'nav .breadcrumbs' do
      expect(page).to have_text 'New version'
    end

    fill_in 'version_survey_detail_attributes_title', with: 'Everybody lies'
    fill_in 'version_survey_detail_attributes_description', with: 'but shoes always tell the truth'
    fill_in 'Notes', with: 'Luke, I am your father!'
    fill_in 'version_session_report', with: 'Foo Bar'
    check 'Display progressbar'

    expect(page).not_to have_selector 'version_active'

    expect { click_button 'Save' }.to change { survey.reload.versions.count }.by(1)

    new_version = survey.versions.where(version: survey.versions.max(:version)).first

    expect(new_version.survey_detail.title).to eq 'Everybody lies'
    expect(new_version.survey_detail.description).to eq 'but shoes always tell the truth'
    expect(new_version.notes).to eq 'Luke, I am your father!'
    expect(new_version.session_report).to eq 'Foo Bar'
    expect(new_version.active).to be false
  end

  scenario 'User edits version' do
    version = survey.versions.create version: 666, active: false

    visit survey_path(survey)

    within "##{dom_id(version)}" do
      click_link 'Edit'
    end

    within 'nav .breadcrumbs' do
      expect(page).to have_content 'Version 666'
    end

    fill_in 'version_survey_detail_attributes_title', with: 'Everybody lies'
    fill_in 'version_survey_detail_attributes_description', with: 'but shoes always tell the truth'
    fill_in 'Notes', with: 'Luke, I am your father!'
    fill_in 'version_session_report', with: 'Foo Bar'
    check 'version_active'
    check 'Display progressbar'

    expect(page).not_to have_selector 'version_active'

    click_button 'Save'
    expect(version.reload.survey_detail.title).to eq 'Everybody lies'
    expect(version.reload.survey_detail.description).to eq 'but shoes always tell the truth'
    expect(version.reload.notes).to eq 'Luke, I am your father!'
    expect(version.reload.session_report).to eq 'Foo Bar'
    expect(version.reload.active).to be true
  end

  scenario 'User deletes a version' do
    inactive_version = survey.versions.create active: false, version: 1
    active_version = survey.versions.create active: true, version: 2

    visit survey_path(survey.reload)

    within "##{dom_id(active_version)}" do
      expect(page).to have_selector 'a.disabled', text: 'Delete'
    end

    within "##{dom_id(inactive_version)}" do
      expect { click_link 'Delete' }.to change { survey.reload.versions.count }.by(-1)
    end
  end

  scenario 'User can view version details' do
    version = survey.versions.create notes: 'Awesome new version', version: 666, session_report: 'AbCdE'
    version.survey_detail = Helena::SurveyDetail.new title: 'Piracy', description: 'Typically an act of robbery or criminal violence at sea.'

    visit survey_version_path(survey, version)

    within 'nav .breadcrumbs' do
      expect(page).to have_content 'Version 666'
    end

    within "##{dom_id(version)}" do
      expect(page).to have_content 'Piracy'
      expect(page).to have_content 'Typically an act of robbery or criminal violence at sea.'
      expect(page).to have_content '666'
      expect(page).to have_content 'Awesome new version'
      expect(page).to have_content 'AbCdE'
    end
  end
end
