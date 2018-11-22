module HelenaAdministration
  class QuestionGroupsController < ApplicationController
    respond_to :html

    before_action :load_version, :add_breadcrumbs
    before_action :load_question_group, only: %i[destroy edit update show]

    def show
      add_breadcrumb @question_group.title
    end

    def new
      @question_group = @version.question_groups.build
      add_breadcrumb t('.new')
    end

    def create
      @question_group = @version.question_groups.build question_group_params
      # Note: Not used at the moment, because there are no validations atm
      # if @question_group.save
      #   flash[:success] = t 'shared.actions.created'
      # else
      #   flash.now[:danger] = t 'shared.actions.error'
      # end
      flash[:success] = t 'shared.actions.created' if @question_group.save
      respond_with @question_group, location: [@survey, @version, @question_group]
    end

    def edit
      add_breadcrumb @question_group.title
    end

    def update
      flash[:success] = t('shared.actions.updated') if @question_group.update_attributes(question_group_params)

      # Note: Not used at the moment, because there are no validations atm
      # if @question_group.update_attributes(question_group_params)
      #   flash[:success] = t 'shared.actions.updated'
      # else
      #   flash.now[:danger] = t 'shared.actions.error'
      #   add_breadcrumb @question_group.title_was
      # end

      respond_with @question_group, location: [@survey, @version, @question_group]
    end

    def destroy
      flash[:success] = t 'shared.actions.deleted' if @question_group.destroy
      respond_with @question_group, location: [@survey, @version]
    end

    private

    def add_breadcrumbs
      add_breadcrumb t('shared.navigation.dashboard'), dashboard_index_path
      add_breadcrumb Helena::Survey.model_name.human(count: 2), surveys_path
      add_breadcrumb @survey.name, @survey
      add_breadcrumb t('helena_administration.versions.version', version: @version.version), [@survey, @version]
    end

    def load_version
      @survey = Helena::Survey.find params[:survey_id]
      @version = @survey.versions.find params[:version_id]
    end

    def load_question_group
      @question_group = @version.question_groups.find params[:id]
    end

    def question_group_params
      params.require(:question_group).permit(:position, :title, :allow_to_go_back)
    end
  end
end
