require 'services/translators/models/generic_model' 

module Translators
  module Models
    module Paperflies
      class Location < Translators::Models::GenericModel

        attribute :address,         Shale::Type::String
        attribute :country,         Shale::Type::String

        json do
          map "address",  to: :address
          map "country",  to: :country
        end

      end
    end
  end
end