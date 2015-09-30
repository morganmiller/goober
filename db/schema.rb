# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150930034700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rides", force: :cascade do |t|
    t.string   "pickup_address"
    t.string   "dropoff_address"
    t.integer  "num_passengers"
    t.integer  "status",          default: 0
    t.datetime "accepted_time"
    t.datetime "pickup_time"
    t.datetime "dropoff_time"
    t.integer  "user_id"
    t.integer  "driver_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.float    "cost"
  end

  add_index "rides", ["user_id"], name: "index_rides_on_user_id", using: :btree

  create_table "user_rides", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "ride_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_rides", ["ride_id"], name: "index_user_rides_on_ride_id", using: :btree
  add_index "user_rides", ["user_id"], name: "index_user_rides_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0
    t.string   "car_make"
    t.string   "car_model"
    t.integer  "car_capacity"
  end

  add_foreign_key "rides", "users"
  add_foreign_key "user_rides", "rides"
  add_foreign_key "user_rides", "users"
end
