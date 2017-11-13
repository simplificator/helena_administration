module HelenaAdministration
  module Questions
    class StaticTextsController < QuestionsController
      private

      def permited_params
        %i[default_value required]
      end
    end
  end
end
