module HelenaAdministration
  class ImportSurveysController < ApplicationController
    before_action :add_breadcrumbs

    def new
      add_breadcrumb t('.import')
      @import_survey_form = ImportSurveyForm.new
    end

    # rubocop:disable Metrics/MethodLength
    def create
      @import_survey_form = ImportSurveyForm.new import_survey_form_params
      if @import_survey_form.valid?
        begin
          Helena::SurveyImporter.new @import_survey_form.script
          flash[:success] = t('shared.actions.created')
          redirect_to surveys_path
        rescue => e
          @error = e

          render 'new'
        end
      else
        flash.now[:danger] = t('shared.actions.error')
        render 'new'
      end
    end
    # rubocop:enable Metrics/MethodLength

    private

    def import_survey_form_params
      params.require(:import_survey_form).permit(:script)
    end

    def add_breadcrumbs
      add_breadcrumb t('shared.navigation.dashboard'), dashboard_index_path
    end
  end
end
