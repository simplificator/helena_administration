require 'rails_helper'

describe 'Questions' do
  let!(:survey) { create :survey }
  let!(:version) { survey.versions.create version: 0 }
  let!(:question_group) { version.question_groups.create title: 'Abakadabara' }

  scenario 'Index site lists all questions'  do
    question_group.questions.create code: 'second_question', question_text: 'Second question', position: 123, _type: Helena::Questions::LongText
    question_group.questions.create code: 'first_question', question_text: 'First question', position: 42, _type: Helena::Questions::ShortText

    visit survey_version_question_group_path(survey, version, question_group)

    within 'nav .breadcrumbs' do
      expect(page).to have_content 'Abakadabara'
    end

    within 'table.questions tbody tr:nth-child(1)' do
      expect(page).to have_content 'first_question'
      expect(page).to have_content 'First question'
      expect(page).to have_content 'Short text'
    end

    within 'table.questions tbody tr:nth-child(2)' do
      expect(page).to have_content 'second_question'
      expect(page).to have_content 'Second question'
      expect(page).to have_content 'Long text'
    end
  end

  scenario 'creates a new question' do
    visit new_survey_version_question_group_question_path(survey, version, question_group)

    fill_in 'Code', with: 'a38'
    fill_in 'Question text', with: 'Shall we go?'

    within '.breadcrumbs' do
      expect(page).to have_text 'New question'
    end

    expect { click_button 'Save' }.to change { question_group.reload.questions.count }.by(1)
  end

  scenario 'creating a new question errors when without entering a code' do
    visit new_survey_version_question_group_question_path(survey, version, question_group)

    fill_in 'Code', with: ''

    expect { click_button 'Save' }.to change { question_group.reload.questions.count }.by(0)
  end

  scenario 'edits a question' do
    question = create :question, question_text: 'We are here?', question_group: question_group

    visit edit_survey_version_question_group_question_path(survey, version, question_group, question)

    fill_in 'Question text', with: 'Are you sure?'
    fill_in 'Code', with: 'b12'

    click_button 'Save'

    expect(question.reload.question_text).to eq 'Are you sure?'
    expect(question.reload.code).to eq 'b12'
  end

  scenario 'edits a question errors when code text is empty' do
    question = create :question, question_text: 'We are here?', question_group: question_group

    visit edit_survey_version_question_group_question_path(survey, version, question_group, question)

    fill_in 'Code', with: ''

    expect { click_button 'Save' }.not_to change { question.reload }
  end

  scenario 'User deletes a question' do
    question_group.questions.create code: 'abc'

    question = question_group.questions.find_by code: 'abc'

    visit survey_version_question_group_path(survey, version, question_group)

    within "##{dom_id(question)}" do
      expect { click_link 'Delete' }.to change { question_group.reload.questions.count }.by(-1)
    end
  end

  scenario 'User can view question details' do
    question_group.questions.create code:          'fish',
                                    question_text: 'How much is the fish?',
                                    position:      123,
                                    _type:         Helena::Questions::LongText

    question = question_group.questions.find_by code: 'fish'
    visit survey_version_question_group_question_path(survey, version, question_group, question)

    within 'nav .breadcrumbs' do
      expect(page).to have_content 'fish'
    end

    within "##{dom_id(question.reload)}" do
      expect(page).to have_content 'fish'
      expect(page).to have_content 'How much is the fish?'
      expect(page).to have_content '123'
      expect(page).to have_content 'Long text'
    end
  end
end
