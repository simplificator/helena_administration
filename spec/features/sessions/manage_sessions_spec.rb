require 'spec_helper'

feature 'Sessions' do
  let(:survey) { create :survey }
  let!(:version) { survey.versions.create }

  scenario 'User creates a new session' do
    visit survey_path(survey)

    within 'table.sessions' do
      expect { click_link 'New' }.to change { Helena::Session.count }.by 1
    end
  end

  scenario 'User deletes a session' do
    survey.sessions.create version: version

    visit survey_path(survey)

    within 'table.sessions' do
      expect { click_link 'Delete' }.to change { Helena::Session.count }.by(-1)
    end
  end

  scenario 'User edits a session' do
    session = survey.sessions.create version: version, token: 'xxx'
    version.question_groups.create title: 'first question group'
    second_question_group = version.question_groups.create title: 'second question group'

    visit edit_survey_session_path(survey, session)

    within 'nav .breadcrumbs' do
      expect(page).to have_text 'Session: xxx'
    end

    fill_in 'Token', with: '123'
    fill_in 'View token', with: '456'
    fill_in 'Answers', with: "a: c\nb: 4"
    check 'Completed?'
    select '2: Second Question Group', from: 'Last viewed question group'

    click_button 'Save'

    expect(session.reload.token).to eq '123'
    expect(session.reload.view_token).to eq '456'
    expect(session.reload.answers.map(&:code)).to eq %w[a b]
    expect(session.reload.answers.map(&:value)).to eq ['c', 4]
    expect(session.reload.completed).to eq true
    expect(session.reload.last_question_group_id).to eq second_question_group.id

    expect(page).not_to have_content 'RuntimeError'
  end
end
