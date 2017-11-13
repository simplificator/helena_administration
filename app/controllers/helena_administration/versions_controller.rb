module HelenaAdministration
  class VersionsController < ApplicationController
    respond_to :html

    before_action :load_survey, :add_breadcrumbs
    before_action :load_version, only: %i[edit update show]

    def show
      add_breadcrumb t 'helena_administration.versions.version', version: @version.version
    end

    def new
      source_version = @survey.newest_version
      @version = @survey.versions.any? ? @survey.versions.build(source_version.attributes) : @survey.versions.build
      @version.parent = source_version
      @version.survey_detail = (@version.try(:survey_detail) || Helena::SurveyDetail.new)
      @version.notes = ''
      add_breadcrumb t('.new'), new_survey_version_path(@survey)
    end

    def create
      @version = build_version
      @version.update_attributes(version_params)
      if @version.save
        flash[:success] = t 'shared.actions.created'
      else
        flash.now[:danger] = t 'shared.actions.error'
      end
      respond_with @version, location: [@survey, @version]
    end

    def edit
      @version.survey_detail ||= Helena::SurveyDetail.new
      add_breadcrumb t 'helena_administration.versions.version', version: @version.version
    end

    def update
      if @version.update_attributes version_params
        flash[:success] = t 'shared.actions.updated'
      else
        flash.now[:danger] = t 'shared.actions.error'
        add_breadcrumb t 'helena_administration.versions.version', version: @version.version
      end
      respond_with @version, location: [:edit, @survey, @version]
    end

    def destroy
      @version = @survey.versions.find params[:id]
      flash[:success] = t 'shared.actions.deleted' if @version.destroy
      redirect_to survey_path(@survey)
    end

    private

    def load_survey
      @survey = Helena::Survey.find params[:survey_id]
    end

    def load_version
      @version = @survey.versions.find params[:id]
    end

    def add_breadcrumbs
      add_breadcrumb t('shared.navigation.dashboard'), dashboard_index_path
      add_breadcrumb Helena::Survey.model_name.human(count: 2), surveys_path
      add_breadcrumb @survey.name, @survey
    end

    def version_params
      params.require(:version).permit(:parent, :notes, :session_report, :active,
                                      settings: [:display_progressbar],
                                      survey_detail_attributes: %i[title description])
    end

    def build_version
      @version = if version_params[:parent].present?
                   Helena::VersionPublisher.publish(@survey.versions.find(version_params[:parent]))
                 else
                   @survey.versions.build version: (@survey.newest_version.version + 1)
                 end
    end
  end
end
