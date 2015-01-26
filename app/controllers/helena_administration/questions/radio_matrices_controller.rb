module HelenaAdministration
  module Questions
    class RadioMatricesController < QuestionsController
      include Helena::Concerns::Questions::MatrixQuestions
    end
  end
end
