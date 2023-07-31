require 'services/translators/models/accommodation' 

module Translators
  module Models
    module Patagonia
      class Accommodation < Translators::Models::Accommodation

        json do
          map "id",           to: :id
          map "destination",  to: :destination_id
          map "name",         to: :name
          map "lat",          to: :latitude
          map "lng",          to: :longitude
          map "address",      to: :address
          map "info",         to: :info
          map "amenities",    using: { from: :convert_facilities, to: :facilities }
          map "images",       using: { from: :convert_images, to: :images }
        end

        def convert_facilities(model, values)
          model.facilities = values.inject([]) do |converted_facilities, value|
            t = Translators::Models::Facility.new(category: nil, name: value)
            converted_facilities << t
          end if values
        end

        def convert_images(model, values)
          model.images = values.inject([]) do |converted_images, (image_type, retrieved_images)|
            retrieved_images.each do |retrieved_image|
              image = Translators::Models::Image.new(
                image_type:   image_type, 
                description:  retrieved_image["description"],
                url:          retrieved_image["url"]
              )
              converted_images << image
            end
            converted_images
          end if values       
        end

      end
    end
  end
end