require 'services/translators/models/accommodation' 
require 'services/translators/models/paperflies/location'

module Translators
  module Models
    module Paperflies
      class Accommodation < Translators::Models::Accommodation

        attribute :location, Translators::Models::Paperflies::Location

        json do
          map "hotel_id",           to: :id
          map "destination_id",     to: :destination_id
          map "hotel_name",         to: :name
          map "location",           to: :location
          map "details",            to: :info
          map "amenities",          using: { from: :convert_facilities, to: :facilities }
          map "images",             using: { from: :convert_images, to: :images }
          map "booking_conditions", using: { from: :convert_booking_conditions, to: :booking_conditions }
        end

        def convert_facilities(model, values)
          model.facilities = values.inject([]) do |converted_facilities, (facility_type, retrieved_facilities)|
            retrieved_facilities.each do |retrieved_facility|
              facility = Translators::Models::Facility.new(
                category: facility_type,
                name:     retrieved_facility
              )
              converted_facilities << facility
            end 
            converted_facilities
          end if values
        end

        def convert_images(model, values)
          model.images = values.inject([]) do |converted_images, (image_type, retrieved_images)|
            retrieved_images.each do |retrieved_image|
              image = Translators::Models::Image.new(
                image_type:   image_type, 
                description:  retrieved_image["caption"],
                url:          retrieved_image["link"]
              )
              converted_images << image
            end
            converted_images
          end if values
        end

        def convert_booking_conditions(model, values)
          model.booking_conditions = values.collect(&:strip)
        end

        def address
          location.address
        end
        
        def country
          location.country
        end

      end
    end
  end
end