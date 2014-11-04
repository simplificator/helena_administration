module Questions
  class RadioMatrixController < QuestionsController
    include Helena::Concerns::Questions::MatrixQuestions
  end
end
