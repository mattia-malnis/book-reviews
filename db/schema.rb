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

ActiveRecord::Schema[7.2].define(version: 2024_08_25_162912) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.string "subtitle"
    t.string "temp_image_url"
    t.integer "external_ref"
    t.virtual "textsearchable_col", type: :tsvector, as: "to_tsvector('english'::regconfig, (((title)::text || ' '::text) || (subtitle)::text))", stored: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["textsearchable_col"], name: "index_books_on_textsearchable_col", using: :gin
  end
end
