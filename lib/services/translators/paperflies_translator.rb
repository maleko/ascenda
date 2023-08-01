require "services/translators/core_translator"
require "services/translators/models/paperflies/accommodation"

class PaperfliesTranslator < CoreTranslator
# Translator specific to the Paperflies Supplier

  def initialize(url: nil)
    @url = url || "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies"  
  end

  def accommodations
    @accommodations ||= Translators::Models::Paperflies::Accommodation.from_json(json_collection) if json_collection
  end

end