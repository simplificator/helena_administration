module HelenaAdministration
  module Questions
    class CheckboxMatrixController < QuestionsController
      include Helena::Concerns::Questions::MatrixQuestions
    end
  end
end
