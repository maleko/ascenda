require 'services/translators/models/generic_model' 

module Translators
  module Models
    class Image < Translators::Models::GenericModel

      attribute :image_type,  Shale::Type::String
      attribute :description, Shale::Type::String
      attribute :url,         Shale::Type::String

      def attributes
        {
          image_type:  image_type&.strip,
          description: description&.strip,
          url:         url&.strip
        }.compact
      end

    end
  end
end