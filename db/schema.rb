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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 13) do

  create_table "cost_sheet_investment_packages", :force => true do |t|
    t.integer  "cost_sheet_id"
    t.string   "header"
    t.string   "package"
    t.float    "cost_per_week"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "cost_sheets", :force => true do |t|
    t.integer  "gameboard_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "gameboard_week_maps", :force => true do |t|
    t.integer  "gameboard_id"
    t.integer  "week_number"
    t.string   "status"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "gameboards", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "current_week"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "title"
  end

  create_table "moderators", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "flipkart_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "purchase_cost_headers", :force => true do |t|
    t.integer  "cost_sheet_id"
    t.integer  "stock_lower_bound"
    t.integer  "stock_upper_bound"
    t.string   "segment"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "purchase_cost_items", :force => true do |t|
    t.integer  "purchase_cost_header_id"
    t.string   "category"
    t.float    "cost"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "seller_week_investments", :force => true do |t|
    t.integer  "seller_id"
    t.integer  "gameboard_id"
    t.integer  "week_number"
    t.integer  "operating_cost_id"
    t.integer  "marketing_cost_id"
    t.integer  "inventory_cost_id"
    t.float    "loan"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "seller_week_purchase_cost_plan_headers", :force => true do |t|
    t.integer  "seller_id"
    t.integer  "gameboard_id"
    t.integer  "week_number"
    t.integer  "stock_lower_bound"
    t.integer  "stock_upper_bound"
    t.string   "segment"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "seller_week_purchase_cost_plan_items", :force => true do |t|
    t.integer  "header_id"
    t.string   "category"
    t.float    "cost"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sellers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "geo_location"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
