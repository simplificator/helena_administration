require 'rails_helper'

describe 'Static text question management' do
  let!(:survey) { create :survey }
  let!(:version) { survey.versions.create version: 0 }
  let!(:question_group) { version.question_groups.create title: 'Abakadabara' }
  let!(:question) { create :static_text_question, question_group: question_group }

  scenario 'edits a question' do
    visit edit_survey_version_question_group_questions_static_text_path(survey, version, question_group, question)

    fill_in 'Static text', with: 'This text will be displayed instead of an input'

    click_button 'Save'

    expect(question.reload.default_value).to eq 'This text will be displayed instead of an input'
  end
end
