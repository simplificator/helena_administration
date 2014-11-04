require 'rails_helper'

describe 'Radio group question management' do
  let!(:survey) { create :survey }
  let!(:version) { survey.versions.create version: 0 }
  let!(:question_group) { version.question_groups.create title: 'Abakadabara' }
  let!(:question) { create :radio_group_question, question_group: question_group }

  scenario 'edits a question' do
    question.labels << build(:label, text: 'Male', value: 'm', position: 1)

    visit edit_survey_version_question_group_questions_radio_group_path(survey, version, question_group, question)

    check 'Required'

    fill_in 'questions_radio_group_labels_attributes_0_position', with: '2'
    fill_in 'questions_radio_group_labels_attributes_0_text', with: 'Female'
    fill_in 'questions_radio_group_labels_attributes_0_value', with: 'f'
    check 'questions_radio_group_labels_attributes_0_preselected'

    click_button 'Save'

    expect(question.reload.labels.first.position).to eq 2
    expect(question.reload.labels.first.text).to eq 'Female'
    expect(question.reload.labels.first.value).to eq 'f'
    expect(question.reload.labels.first.preselected).to eq true
    expect(question.reload.required).to eq true
  end

  scenario 'adds a an option' do
    visit edit_survey_version_question_group_questions_radio_group_path(survey, version, question_group, question)

    fill_in 'questions_radio_group_labels_attributes_0_position', with: '2'
    fill_in 'questions_radio_group_labels_attributes_0_text', with: 'Female'
    fill_in 'questions_radio_group_labels_attributes_0_value', with: 'f'
    check 'questions_radio_group_labels_attributes_0_preselected'

    click_button 'Save'

    expect(question.reload.labels.first.position).to eq 2
    expect(question.reload.labels.first.text).to eq 'Female'
    expect(question.reload.labels.first.value).to eq 'f'
    expect(question.reload.labels.first.preselected).to eq true
  end

  scenario 'removes an option' do
    question.labels << build(:label, text: 'Male', value: 'm', position: 1)

    visit edit_survey_version_question_group_questions_radio_group_path(survey, version, question_group, question)

    check 'questions_radio_group_labels_attributes_0__destroy'

    click_button 'Save'

    expect(question.reload.labels).to be_empty
  end
end
