# frozen_string_literal: true

module Types
  class BookingConditionType < Types::BaseObject
    field :id, ID, null: false
    field :accommodation_id, String, null: false
    field :condition, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
