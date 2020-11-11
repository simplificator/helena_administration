require 'spec_helper'

feature 'Long text question management' do
  let!(:survey) { create :survey }
  let!(:version) { survey.versions.create version: 0 }
  let!(:question_group) { version.question_groups.create title: 'Abakadabara' }
  let!(:question) { create :long_text_question, question_group: question_group }

  scenario 'edits a question' do
    visit edit_survey_version_question_group_questions_long_text_path(survey, version, question_group, question)

    a_very_long_text = Faker::Lorem.paragraph(sentence_count: 20)

    fill_in 'Default value', with: a_very_long_text
    check 'Required'

    click_button 'Save'

    expect(question.reload.default_value).to eq a_very_long_text
    expect(question.reload.required).to eq true
  end
end
