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

ActiveRecord::Schema.define(version: 20140530082043) do

  create_table "brands", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "name"
    t.integer  "nit"
    t.integer  "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incomes", force: true do |t|
    t.integer  "id_order"
    t.string   "product_name"
    t.integer  "quantity"
    t.string   "description"
    t.string   "code"
    t.integer  "price"
    t.integer  "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kardexes", force: true do |t|
    t.date     "date"
    t.string   "detail"
    t.integer  "income"
    t.integer  "output"
    t.integer  "residue"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kardexes", ["product_id"], name: "index_kardexes_on_product_id"

  create_table "orders", force: true do |t|
    t.string   "estado"
    t.integer  "provider_id"
    t.boolean  "ingresado"
    t.boolean  "confirm"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outflows", force: true do |t|
    t.integer  "sale_id"
    t.integer  "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "productnames", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "productorders", force: true do |t|
    t.integer  "productname_id"
    t.integer  "quantity"
    t.boolean  "ingresado"
    t.float    "price"
    t.float    "total_price"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "productorders", ["order_id"], name: "index_productorders_on_order_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "detail"
    t.text     "description"
    t.string   "general_code"
    t.string   "brand"
    t.string   "category"
    t.float    "bought_price"
    t.integer  "quantity"
    t.integer  "increase"
    t.boolean  "home"
    t.integer  "id_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "productsales", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.float    "price"
    t.integer  "sale_id"
    t.integer  "subproduct_id"
    t.string   "client_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", force: true do |t|
    t.string   "name"
    t.integer  "phone"
    t.string   "mail"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", force: true do |t|
    t.float    "price"
    t.integer  "check_number"
    t.string   "client_name"
    t.integer  "nit"
    t.boolean  "confirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subproducts", force: true do |t|
    t.string   "code"
    t.boolean  "available"
    t.string   "name"
    t.integer  "product_id"
    t.integer  "sale_id"
    t.integer  "outflow_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subproducts", ["outflow_id"], name: "index_subproducts_on_outflow_id"
  add_index "subproducts", ["product_id"], name: "index_subproducts_on_product_id"
  add_index "subproducts", ["sale_id"], name: "index_subproducts_on_sale_id"

  create_table "technical_services", force: true do |t|
    t.string   "product_code"
    t.string   "client"
    t.string   "status"
    t.string   "detail"
    t.string   "problems"
    t.string   "repairs"
    t.string   "product_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "name"
    t.string   "rol"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
