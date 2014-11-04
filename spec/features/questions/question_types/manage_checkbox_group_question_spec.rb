require 'rails_helper'

describe 'Checkbox group question management' do
  let!(:survey) { create :survey }
  let!(:version) { survey.versions.create version: 0 }
  let!(:question_group) { version.question_groups.create title: 'Abakadabara' }
  let!(:question) { create :checkbox_group_question, question_group: question_group }

  scenario 'edits a question' do
    question.sub_questions.create(code: 'aperto', text: 'Aperto Snacks', value: 'Aperto', position: 1)

    visit edit_survey_version_question_group_questions_checkbox_group_path(survey, version, question_group, question)

    check 'Required'

    fill_in 'questions_checkbox_group_sub_questions_attributes_0_position', with: '2'
    fill_in 'questions_checkbox_group_sub_questions_attributes_0_text', with: 'Avec Shop'
    fill_in 'questions_checkbox_group_sub_questions_attributes_0_code', with: 'avec'
    check 'questions_checkbox_group_sub_questions_attributes_0_preselected'

    click_button 'Save'

    expect(question.reload.sub_questions.first.position).to eq 2
    expect(question.reload.sub_questions.first.text).to eq 'Avec Shop'
    expect(question.reload.sub_questions.first.code).to eq 'avec'
    expect(question.reload.required).to eq true
  end

  scenario 'adds a a sub question' do
    visit edit_survey_version_question_group_questions_checkbox_group_path(survey, version, question_group, question)

    fill_in 'questions_checkbox_group_sub_questions_attributes_0_position', with: '2'
    fill_in 'questions_checkbox_group_sub_questions_attributes_0_text', with: 'Avec Shop'
    fill_in 'questions_checkbox_group_sub_questions_attributes_0_code', with: 'avec'
    check 'questions_checkbox_group_sub_questions_attributes_0_preselected'

    click_button 'Save'

    expect(question.reload.sub_questions.first.position).to eq 2
    expect(question.reload.sub_questions.first.text).to eq 'Avec Shop'
    expect(question.reload.sub_questions.first.code).to eq 'avec'
  end

  scenario 'removes a sub question' do
    question.sub_questions.create(code: 'aperto', text: 'Aperto Snacks', value: 'Aperto', position: 1)

    visit edit_survey_version_question_group_questions_checkbox_group_path(survey, version, question_group, question)

    check 'questions_checkbox_group_sub_questions_attributes_0__destroy'

    click_button 'Save'
  end
end
