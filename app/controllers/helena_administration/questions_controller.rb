module HelenaAdministration
  class QuestionsController < ApplicationController
    respond_to :html

    before_action :load_question_group, :add_breadcrumbs
    before_action :load_question, only: [:destroy, :edit, :update, :show]

    def show
      add_breadcrumb @question.code
    end

    def new
      @question = @question_group.questions.build
      add_breadcrumb t('.new')
    end

    def create
      @question = @question_group.questions.build question_params
      if @question.save
        flash[:success] = t 'shared.actions.created'
        respond_with @question, location: [@survey, @version, @question_group, @question]
      else
        flash[:danger] = t 'shared.actions.error'
        render 'new'
      end
    end

    def edit
      add_ressources
      add_breadcrumb @question.code
    end

    def update
      if @question.update_attributes(question_params)
        flash[:success] = t 'shared.actions.updated'
      else
        flash[:danger] = t 'shared.actions.error'
        add_breadcrumb @question.code_was
      end
      add_ressources
      respond_with @question, location: [@survey, @version, @question_group, @question]
    end

    def destroy
      flash[:success] = t 'shared.actions.deleted' if @question.destroy
      respond_with @question_group, location: [@survey, @version, @question_group]
    end

    private

    def add_breadcrumbs
      add_breadcrumb t('shared.navigation.dashboard'), dashboard_index_path
      add_breadcrumb Helena::Survey.model_name.human(count: 2), surveys_path
      add_breadcrumb @survey.name, @survey
      add_breadcrumb t('helena_administration.versions.version', version: @version.version), [@survey, @version]
      add_breadcrumb @question_group.title, [@survey, @version, @question_group]
    end

    def load_question_group
      @survey = Helena::Survey.find params[:survey_id]
      @version = @survey.versions.find params[:version_id]
      @question_group = @version.question_groups.find params[:question_group_id]
    end

    def load_question
      @question = @question_group.questions.find params[:id]
    end

    def question_group_params
      params.require(:question).permit(:position, :title)
    end

    def labels_attributes
      [:id, :position, :text, :value, :preselected, :_destroy]
    end

    def sub_questions_attributes
      [:id, :position, :code, :text, :value, :preselected, :_destroy]
    end

    def question_params
      required_param.permit(permited_params + [:position, :question_text, :code, :_type])
    end

    def permited_params
      []
    end

    def add_ressources
    end

    def required_param
      param_name = self.class == QuestionsController ? :question : "questions_#{controller_name.singularize}"
      params.require(param_name)
    end
  end
end
