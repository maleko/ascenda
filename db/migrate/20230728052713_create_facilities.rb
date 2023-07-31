class CreateFacilities < ActiveRecord::Migration[7.0]
  def change
    create_table :facilities do |t|
      t.string :accommodation_id, null: false, foreign_key: true
      t.string :category
      t.string :name, null: false

      t.timestamps
      t.index :accommodation_id
    end
  end
end
