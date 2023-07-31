# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

seeded_suppliers = JSON.parse( File.read( "db/suppliers.json" ) )

seeded_suppliers.each do |seeded_supplier|
    supplier = Supplier.create(seeded_supplier)
    supplier.save
end 