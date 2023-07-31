class Accommodation < ApplicationRecord

    self.primary_key = :id

    has_many :facilities
    has_many :images

end
