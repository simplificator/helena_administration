module Questions
  class RadioGroupsController < QuestionsController
    private

    def add_ressources
      @question.labels.build
    end

    def permited_params
      [:required, labels_attributes: labels_attributes]
    end
  end
end
