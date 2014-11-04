module HelenaAdministration
  module Questions
    class StaticTextsController < QuestionsController
      private

      def permited_params
        [:default_value, :required]
      end
    end
  end
end
