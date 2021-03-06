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

ActiveRecord::Schema.define(version: 20171204184321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.text "email"
    t.text "username"
    t.binary "password"
    t.text "privilege"
    t.integer "timestamp"
    t.binary "salt"
    t.integer "accountable_id"
    t.string "accountable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accountable_id", "accountable_type"], name: "index_accounts_on_accountable_id_and_accountable_type", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "line1"
    t.string "line2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "profile_id"
    t.index ["profile_id"], name: "index_addresses_on_profile_id"
  end

  create_table "applicants", force: :cascade do |t|
    t.bigint "client_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["client_request_id"], name: "index_applicants_on_client_request_id"
    t.index ["user_id"], name: "index_applicants_on_user_id"
  end

  create_table "client_requests", force: :cascade do |t|
    t.integer "service_type_id"
    t.date "period"
    t.string "period_detail"
    t.text "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "trigger"
    t.integer "matched_user"
    t.string "service_name"
    t.string "title"
    t.bigint "address_id"
    t.integer "progress"
    t.text "fullfillment"
    t.integer "rating"
    t.text "feedback"
    t.string "city"
    t.bigint "user_id"
    t.integer "payment"
    t.string "payment_status"
    t.bigint "free_address_id"
    t.string "received"
    t.index ["address_id"], name: "index_client_requests_on_address_id"
    t.index ["free_address_id"], name: "index_client_requests_on_free_address_id"
    t.index ["user_id"], name: "index_client_requests_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.date "birth_date"
    t.string "email_address"
    t.string "cell_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "free_addresses", force: :cascade do |t|
    t.string "line1"
    t.string "line2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "title"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "ispublic"
    t.bigint "client_request_id"
    t.bigint "user_id"
    t.index ["client_request_id"], name: "index_messages_on_client_request_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.date "date_of_birth"
    t.string "about_me"
    t.string "phone"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "service_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teen_offerings", force: :cascade do |t|
    t.integer "account_id"
    t.integer "service_type_id"
    t.date "period"
    t.string "period_detail", default: "N/A"
    t.text "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "trigger"
  end

  create_table "teenagers", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.date "birth_date"
    t.string "home_address"
    t.string "email_address"
    t.string "cell_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "from"
    t.string "transaction_type"
    t.string "transaction_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transaction_amount"
    t.integer "target"
    t.integer "creq_id"
    t.string "status"
    t.text "notification_params"
    t.string "transaction_id"
    t.datetime "purchased_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "username", null: false
    t.string "fname", null: false
    t.string "lname", null: false
    t.binary "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "rating"
    t.integer "rating_count"
    t.string "city"
    t.string "password_hash"
  end

  add_foreign_key "addresses", "profiles"
  add_foreign_key "applicants", "client_requests"
  add_foreign_key "applicants", "users"
  add_foreign_key "client_requests", "addresses"
  add_foreign_key "client_requests", "free_addresses"
  add_foreign_key "client_requests", "users"
  add_foreign_key "messages", "client_requests"
  add_foreign_key "messages", "users"
end
