# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_28_060553) do
  create_table "accommodations", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.integer "destination_id"
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.string "suburb"
    t.string "state"
    t.string "country"
    t.string "postcode"
    t.text "info"
    t.text "conditions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_accommodations_on_id", unique: true
  end

  create_table "facilities", force: :cascade do |t|
    t.string "accommodation_id", null: false
    t.string "category"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accommodation_id"], name: "index_facilities_on_accommodation_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "accommodation_id", null: false
    t.string "image_type"
    t.string "description"
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accommodation_id"], name: "index_images_on_accommodation_id"
  end

end
