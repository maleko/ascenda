require 'services/translators/models/accommodation' 

module Translators
  module Models
    module Acme
      class Accommodation < Translators::Models::Accommodation

        json do
          map "Id",            to: :id
          map "DestinationId", to: :destination_id
          map "Name",          to: :name
          map "Latitude",      to: :latitude
          map "Longitude",     to: :longitude
          map "Address",       to: :address
          map "City",          to: :suburb
          map "Country",       to: :country
          map "PostalCode",    to: :postcode
          map "Description",   to: :info
          map "Facilities",    using: { from: :convert_facilities, to: :facilities }
        end

        def convert_facilities(model, values)
          model.facilities = values.inject([]) do |converted_facilities, value|
            t = Translators::Models::Facility.new(category: nil, name: value)
            converted_facilities << t
          end if values
        end

      end
    end
  end
end