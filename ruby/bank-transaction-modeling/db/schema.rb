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

ActiveRecord::Schema[8.0].define(version: 2025_02_08_175533) do
  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "balance", default: 0, null: false
    t.string "account_type", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount", null: false
    t.integer "src_account_id"
    t.integer "dst_account_id"
    t.index ["dst_account_id"], name: "index_transactions_on_dst_account_id"
    t.index ["src_account_id"], name: "index_transactions_on_src_account_id"
  end

  add_foreign_key "transactions", "accounts", column: "dst_account_id"
  add_foreign_key "transactions", "accounts", column: "src_account_id"
end
