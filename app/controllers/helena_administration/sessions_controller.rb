require 'csv'
module HelenaAdministration
  class SessionsController < ApplicationController
    include ActionController::Live

    respond_to :html, :json, :csv

    before_filter :load_survey, :add_breadcrumbs
    before_filter :load_session, only: [:edit, :update, :destroy]

    def index
      respond_to do |format|
        @sessions = @survey.sessions.desc(:created_at)
        format.json { render json: @sessions }
        format.csv do
          render_csv
        end
      end
    end

    def new
      @survey.sessions.create version: @survey.newest_version
      flash[:success] = t 'shared.actions.created'
      redirect_to survey_path(@survey)
    end

    def edit
      add_breadcrumb "#{@session.model_name.human}: #{@session.token_was}", @survey
    end

    def update
      if @session.update_attributes session_params
        flash[:success] = t 'shared.actions.updated'
      else
        flash.now[:danger] = t 'shared.actions.error'
        add_breadcrumb "#{@session.model_name.human}: #{@session.token_was}", @survey
      end
      respond_with @survey
    end

    def destroy
      flash[:success] = t 'shared.actions.deleted' if @session.destroy
      redirect_to survey_path(@survey)
    end

    private

    def render_csv
      response.headers['Content-Disposition'] = "attachment; filename=#{@survey.name}.csv"
      response.headers['Content-Type'] = 'text/csv'

      # Write csv header once ...
      response.stream.write CSV.generate_line(session_fields + question_codes)

      # .. and generate a line for each session.
      @sessions.each do |session|
        response.stream.write CSV.generate_line(session_values(session) + answer_values(session, question_codes))
      end
    ensure
      response.stream.close
    end

    def session_values(session)
      session_fields.map { |field| session.attributes[field] }
    end

    def answer_values(session, answer_codes)
      answer_codes.map  { |code|  session.answers.where(code: code).first.try(&:value) }
    end

    def add_breadcrumbs
      add_breadcrumb t('shared.navigation.dashboard'), dashboard_index_path
      add_breadcrumb Helena::Survey.model_name.human(count: 2), surveys_path
    end

    def load_survey
      @survey = Helena::Survey.find params['survey_id']
    end

    def load_session
      @session = @survey.sessions.find params[:id]
    end

    def session_params
      params.require(:session).permit :token, :view_token, :answers_as_yaml, :completed, :last_question_group_id
    end

    def question_codes
      @question_codes ||= unique_question_codes
    end

    # It could be possible that an answer code equals a session field. We add "answer_" in that case so that we get uniqe question codes for sure
    def unique_question_codes
      codes = @survey.versions.map(&:question_codes).flatten
      codes.map do |code|
        session_fields.include?(code) ? "answer_#{code}" : code
      end
    end

    def session_fields
      Helena::Session.fields.keys
    end
  end
end
