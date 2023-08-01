require "services/translators/core_translator"
require "services/translators/models/acme/accommodation"

class AcmeTranslator < CoreTranslator
# Translator specific to the Acme Supplier

  def initialize(url: nil)
    @url = url || "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme"  
  end

  def accommodations
    @accommodations ||= Translators::Models::Acme::Accommodation.from_json(json_collection) if json_collection
  end

end