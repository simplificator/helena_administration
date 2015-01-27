module HelenaAdministration
  class SessionsController < ApplicationController
    respond_to :html

    before_filter :load_survey, :add_breadcrumbs
    before_filter :load_session, only: [:edit, :update, :destroy]

    def index
      respond_to do |format|
        @sessions = @survey.sessions.desc(:created_at)
        format.json { render json: @sessions }
        format.csv { render text: @sessions.to_csv }
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
  end
end
