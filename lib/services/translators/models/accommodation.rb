require 'services/translators/models/generic_model' 
require 'services/translators/models/facility'
require 'services/translators/models/image'

module Translators
  module Models
    class Accommodation < Translators::Models::GenericModel

      attribute :id,                  Shale::Type::String
      attribute :destination_id,      Shale::Type::Integer
      attribute :name,                Shale::Type::String
      attribute :latitude,            Shale::Type::String
      attribute :longitude,           Shale::Type::String
      attribute :address,             Shale::Type::String
      attribute :suburb,              Shale::Type::String
      attribute :country,             Shale::Type::String
      attribute :postcode,            Shale::Type::String
      attribute :info,                Shale::Type::String 
      attribute :facilities,          Translators::Models::Facility,  collection: true
      attribute :images,              Translators::Models::Image,     collection: true
      attribute :booking_conditions,  Shale::Type::String,            collection: true
      
      def attributes
        {
          id:                 id&.strip,
          destination_id:     destination_id,
          name:               name&.strip,
          latitude:           latitude,
          longitude:          longitude,
          address:            address&.strip,
          suburb:             suburb&.strip,
          country:            country&.strip,
          postcode:           postcode&.strip,
          info:               info&.strip,
          booking_conditions: booking_conditions
        }.compact
      end

    end
  end
end