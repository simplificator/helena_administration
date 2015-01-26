require 'spec_helper'

describe 'Surveys' do
  scenario 'Index site lists all surveys'  do
    create :survey, name: 'Innerbetriebliche Zufriedenheit', position: 2
    create :survey, name: 'Life satisfaction scale', position: 1

    visit surveys_path

    within 'nav .breadcrumbs' do
      expect(page).to have_content 'Surveys'
    end

    within 'table tbody tr:nth-child(1)' do
      expect(page).to have_content 'Life satisfaction scale'
    end

    within 'table tbody tr:nth-child(2)' do
      expect(page).to have_content 'Innerbetriebliche Zufriedenheit'
    end
  end

  scenario 'User deletes a survey' do
    survey = create :survey

    visit surveys_path

    within "##{dom_id(survey)}" do
      expect { click_link 'Delete' }.to change { Helena::Survey.count }.from(1).to(0)
    end
  end

  scenario 'User creates a new survey' do
    visit surveys_path

    click_link 'New'

    within 'nav .breadcrumbs' do
      expect(page).to have_text 'New'
    end

    expect { click_button 'Save' }.to change { Helena::Survey.count }.by 0

    fill_in 'Name', with: 'More crazy stuff...'
    select 'en', from: 'Language'
    fill_in 'Tag list', with: 'english, foo, 42'

    within 'nav .breadcrumbs' do
      expect(page).to have_text 'New'
    end

    expect { click_button 'Save' }.to change { Helena::Survey.count }.by 1
  end

  scenario 'User updates a survey' do
    survey = create :survey, name: 'Swiss fertility survey'

    visit surveys_path

    within "##{dom_id(survey)}" do
      click_link 'Edit'
    end

    within 'nav .breadcrumbs' do
      expect(page).to have_text 'Swiss fertility survey'
    end

    fill_in 'Name', with: ''

    expect { click_button 'Save' }.not_to change { survey.reload }

    within 'nav .breadcrumbs' do
      expect(page).to have_text 'Swiss fertility survey'
    end

    fill_in 'Name', with: 'More crazy stuff...'
    select 'en', from: 'Language'
    fill_in 'Tag list', with: 'english, foo, 42'

    expect { click_button 'Save' }.to change { survey.reload.name }.from('Swiss fertility survey').to('More crazy stuff...')
  end

  scenario 'User can view survey details' do
    survey = create :survey, name: 'Swiss fertility survey'

    visit survey_path(survey)

    within 'nav .breadcrumbs' do
      expect(page).to have_content 'Swiss fertility survey'
    end
    within "##{dom_id(survey)}" do
      expect(page).to have_content 'Swiss fertility survey'
    end
  end
end
