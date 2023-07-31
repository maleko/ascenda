# frozen_string_literal: true

module Types
  class AccommodationType < Types::BaseObject
    field :id, ID, null: false
    field :destination_id, Integer
    field :name, String
    field :latitude, Float
    field :longitude, Float
    field :address, String
    field :suburb, String
    field :state, String
    field :country, String
    field :postcode, String
    field :info, String
    field :facilities, [Types::FacilityType]
    field :images, [Types::ImageType]
    field :booking_conditions, [Types::BookingConditionType]
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
