# frozen_string_literal: true

module Types
  class FacilityType < Types::BaseObject
    field :id, ID, null: false
    field :accommodation_id, String, null: false
    field :category, String
    field :name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
