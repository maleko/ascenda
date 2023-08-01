require "services/translators/core_translator"
require "services/translators/models/patagonia/accommodation"

class PatagoniaTranslator < CoreTranslator
# Translator specific to the Patagonia Supplier

  def initialize(url: nil)
    @url = url || "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia"  
  end

  def accommodations
    @accommodations ||= Translators::Models::Patagonia::Accommodation.from_json(json_collection) if json_collection
  end

end