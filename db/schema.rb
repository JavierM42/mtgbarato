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

ActiveRecord::Schema.define(version: 20191026161216) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buy_listings", force: :cascade do |t|
    t.integer "card_id"
    t.integer "user_id"
    t.integer "amount"
    t.string  "notes"
    t.boolean "specific_set", default: false
    t.boolean "foil",         default: false
    t.float   "price"
    t.index ["card_id"], name: "index_buy_listings_on_card_id", using: :btree
    t.index ["user_id"], name: "index_buy_listings_on_user_id", using: :btree
  end

  create_table "buys", force: :cascade do |t|
    t.integer "amount",    default: 1, null: false
    t.string  "card_name"
    t.integer "user_id"
    t.index ["user_id"], name: "index_buys_on_user_id", using: :btree
  end

  create_table "cards", force: :cascade do |t|
    t.string  "name"
    t.string  "set_name"
    t.float   "price"
    t.string  "image_uri"
    t.string  "thumbnail_uri"
    t.float   "foil_price"
    t.boolean "standard_legal", default: false
    t.boolean "modern_legal",   default: false
  end

  create_table "sell_listings", force: :cascade do |t|
    t.integer "card_id"
    t.integer "user_id"
    t.integer "amount"
    t.string  "notes"
    t.boolean "set_confirmed", default: false
    t.boolean "foil",          default: false
    t.float   "price"
    t.index ["card_id"], name: "index_sell_listings_on_card_id", using: :btree
    t.index ["user_id"], name: "index_sell_listings_on_user_id", using: :btree
  end

  create_table "sells", force: :cascade do |t|
    t.integer "amount",    default: 1, null: false
    t.string  "card_name"
    t.integer "user_id"
    t.index ["user_id"], name: "index_sells_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
