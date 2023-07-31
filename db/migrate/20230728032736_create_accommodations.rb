class CreateAccommodations < ActiveRecord::Migration[7.0]
  def change
    create_table :accommodations, id: false, primary_key: :id do |t|
      t.string :id, null: false
      t.integer :destination_id
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :suburb
      t.string :state
      t.string :country
      t.string :postcode
      t.text :info
      t.text :conditions

      t.timestamps
      t.index :id, unique: true
    end
  end
end
