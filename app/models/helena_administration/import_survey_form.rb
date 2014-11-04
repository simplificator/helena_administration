module HelenaAdministration
  class ImportSurveyForm
    include ActiveModel::Model

    attr_accessor :script

    validates :script, presence: true
  end
end
