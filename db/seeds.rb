# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'services/importers/core_importer'
require 'services/translators/acme_translator'
require 'services/translators/patagonia_translator'
require 'services/translators/paperflies_translator'

at = AcmeTranslator.new
ai = CoreImporter.new(retrieved_accommodations: at.accommodations)
ai.import

pt = PatagoniaTranslator.new
pi = CoreImporter.new(retrieved_accommodations: pt.accommodations)
pi.import

ppt = PaperfliesTranslator.new
ppi = CoreImporter.new(retrieved_accommodations: ppt.accommodations)
ppi.import
