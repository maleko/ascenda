module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World!"
    # end

    # First describe the field signature:
    field :accommodation, AccommodationType, "Find an accommodation by ID" do
      argument :id, ID
    end

    field :accommodations, [Types::AccommodationType], null: false, description: "Returns all accommodations"

    # Then provide an implementation:
    def accommodation(id:)
      Accommodation.find(id)
    end

    def accommodations
      Accommodation.all
    end

  end
end
