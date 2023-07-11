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

ActiveRecord::Schema[7.0].define(version: 2023_07_06_130049) do
  create_table "book_tickets", force: :cascade do |t|
    t.string "alphanumeric_id"
    t.integer "total_tickets"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "movie_id", null: false
    t.string "theater_name"
    t.index ["movie_id"], name: "index_book_tickets_on_movie_id"
    t.index ["user_id"], name: "index_book_tickets_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "screen_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["screen_id"], name: "index_movies_on_screen_id"
  end

  create_table "screens", force: :cascade do |t|
    t.string "name"
    t.integer "total_seats"
    t.integer "theater_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theater_id"], name: "index_screens_on_theater_id"
  end

  create_table "theaters", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_theaters_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "book_tickets", "movies"
  add_foreign_key "book_tickets", "users"
  add_foreign_key "movies", "screens"
  add_foreign_key "screens", "theaters"
  add_foreign_key "theaters", "users"
end
