module Resolvers
  class AccommodationSearch < Resolvers::BaseSearchResolver
    type [Types::AccommodationType], null: false
    description 'Lists all the accommodations'

    scope { Accommodation.all }

    option(:name, type: String) { |scope, value| scope.where name: value }
    option(:destination_id, type: Integer) { |scope, value| scope.where destination_id: value }
    option(:id, type: String) { |scope, value| scope.where id: value }
  end
end