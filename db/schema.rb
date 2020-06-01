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

ActiveRecord::Schema.define(version: 2020_06_01_164454) do

  create_table "actions", force: :cascade do |t|
    t.integer "male_user_id"
    t.integer "female_user_id"
    t.datetime "male_matching_at"
    t.datetime "female_matching_at"
    t.datetime "matching_at"
    t.date "matching_date"
    t.integer "matching_time_cd"
    t.integer "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "shops", force: :cascade do |t|
    t.string "shop_name"
    t.string "postal_code"
    t.integer "prefecture_cd"
    t.string "city"
    t.string "building"
    t.string "shop_image_id"
    t.boolean "invalid_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "gender_cd"
    t.date "birth_date"
    t.integer "prefecture_cd"
    t.string "user_image_id"
    t.integer "job_cd"
    t.integer "height_cd"
    t.integer "income_cd"
    t.integer "marriage_history_cd"
    t.integer "marriage_purpose_cd"
    t.integer "housemate_cd"
    t.integer "holiday_cd"
    t.integer "alcohol_cd"
    t.integer "cigaret_cd"
    t.text "introduction"
    t.datetime "disabled_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
