class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :accommodation_id, null: false, foreign_key: true
      t.string :image_type
      t.string :description
      t.string :url, null: false

      t.timestamps
      t.index :accommodation_id
    end
  end
end
