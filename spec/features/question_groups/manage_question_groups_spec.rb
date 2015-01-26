require 'spec_helper'

describe 'Question groups' do
  let!(:survey) { create :survey }
  let!(:version) { survey.versions.create version: 0 }

  scenario 'Index site lists all question groups'  do
    version.question_groups.create title: 'Second question group', position: 123
    version.question_groups.create title: 'First question group', position: 42

    visit survey_version_path(survey, version)

    within 'nav .breadcrumbs' do
      expect(page).to have_content 'Version 0'
    end

    within 'table.question_groups tbody tr:nth-child(1)' do
      expect(page).to have_content 'First question group'
    end

    within 'table.question_groups tbody tr:nth-child(2)' do
      expect(page).to have_content 'Second question group'
    end
  end

  scenario 'User creates a new question group' do
    visit survey_version_path(survey, version)

    within 'table.question_groups' do
      click_link 'New'
    end

    within 'nav .breadcrumbs' do
      expect(page).to have_text 'New question group'
    end

    fill_in 'Position', with: 77
    fill_in 'Title', with: 'Foo Bar'
    check 'Allow participants to go back to the previous question group'

    expect { click_button 'Save' }.to change { version.reload.question_groups.count }.by(1)

    new_question_group = version.reload.question_groups.last

    expect(new_question_group.position).to eq 77
    expect(new_question_group.title).to eq 'Foo Bar'
  end

  scenario 'User edits question_group' do
    question_group = version.question_groups.create title: 'Everybody lies!'

    visit survey_version_path(survey, version)

    within "##{dom_id(question_group)}" do
      click_link 'Edit'
    end

    within 'nav .breadcrumbs' do
      expect(page).to have_content 'Everybody lies!'
    end

    fill_in 'Position', with: 13
    fill_in 'Title', with: 'Foo Bar'

    click_button 'Save'

    expect(question_group.reload.position).to eq 13
    expect(question_group.reload.title).to eq 'Foo Bar'
  end

  scenario 'User deletes a question group' do
    question_group = version.question_groups.create

    visit survey_version_path(survey, version)

    within "##{dom_id(question_group)}" do
      expect { click_link 'Delete' }.to change { version.reload.question_groups.count }.by(-1)
    end
  end

  scenario 'User can view question_group details' do
    question_group =  version.question_groups.create title: 'Awesome new question group', position: 666

    visit survey_version_question_group_path(survey, version, question_group)

    within 'nav .breadcrumbs' do
      expect(page).to have_content 'Awesome new question group'
    end

    within "##{dom_id(question_group)}" do
      expect(page).to have_content '666'
      expect(page).to have_content 'Awesome new question group'
    end
  end
end
