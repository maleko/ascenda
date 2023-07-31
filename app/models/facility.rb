class Facility < ApplicationRecord
  belongs_to :accommodation, foreign_key: "accommodation_id"
end
