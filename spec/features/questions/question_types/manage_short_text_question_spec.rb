require 'spec_helper'

describe 'Short text question management' do
  let!(:survey) { create :survey }
  let!(:version) { survey.versions.create version: 0 }
  let!(:question_group) { version.question_groups.create title: 'Abakadabara' }
  let!(:question) { create :short_text_question, question_group: question_group }

  scenario 'edits a question' do
    visit edit_survey_version_question_group_questions_short_text_path(survey, version, question_group, question)

    fill_in 'Default value', with: 'Hey Hey!'
    check 'Required'

    click_button 'Save'

    expect(question.reload.default_value).to eq 'Hey Hey!'
    expect(question.reload.required).to eq true
  end
end
