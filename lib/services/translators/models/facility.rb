require 'services/translators/models/generic_model' 

module Translators
  module Models
    class Facility < Translators::Models::GenericModel

      attribute :category,  Shale::Type::String
      attribute :name,      Shale::Type::String

      # add some stripping/cleanup of strings

      def attributes
        {
          category: category&.strip,
          name:     name&.strip
        }.compact
      end
    end
  end
end