module HelenaAdministration
  class SurveysController < ApplicationController
    respond_to :html

    before_action :add_breadcrumbs

    before_action :load_resources, only: %i[destroy edit update show]

    def index
      @surveys = Helena::Survey.asc(:position)
    end

    def new
      @survey = Helena::Survey.new
      add_breadcrumb t('shared.actions.new'), new_survey_path
    end

    def create
      add_breadcrumb t('shared.actions.new')

      @survey = Helena::Survey.new survey_params
      if @survey.save
        flash[:success] = t 'shared.actions.created'
      else
        flash.now[:danger] = t 'shared.actions.error'
      end
      respond_with @survey
    end

    def show
      add_breadcrumb @survey.name
      @sessions = Helena::Session.where(survey_id: @survey.id).desc(:updated_at).page(params[:page]).per(100)
    end

    def edit
      add_breadcrumb @survey.name
    end

    def update
      if @survey.update_attributes survey_params
        flash[:success] = t 'shared.actions.updated'
      else
        flash.now[:danger] = t 'shared.actions.error'
        add_breadcrumb @survey.name_was
      end
      respond_with @survey
    end

    def destroy
      flash.now[:success] = t 'shared.actions.deleted' if @survey.destroy
      respond_with @survey
    end

    private

    def load_resources
      @survey = Helena::Survey.find params[:id]
    end

    def add_breadcrumbs
      add_breadcrumb t('shared.navigation.dashboard'), dashboard_index_path
      add_breadcrumb Helena::Survey.model_name.human(count: 2), surveys_path
    end

    def survey_params
      params.require(:survey).permit(:name, :tag_list, :language)
    end
  end
end
