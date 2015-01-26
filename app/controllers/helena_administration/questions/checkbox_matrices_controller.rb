module HelenaAdministration
  module Questions
    class CheckboxMatricesController < QuestionsController
      include Helena::Concerns::Questions::MatrixQuestions
    end
  end
end
