class CreateBookingConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :booking_conditions do |t|
      t.string :accommodation_id, null: false, foreign_key: true
      t.string :condition

      t.timestamps
      t.index :accommodation_id
    end
  end
end
