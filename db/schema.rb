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

ActiveRecord::Schema.define(:version => 20121116073217) do

  create_table "circles", :force => true do |t|
    t.string   "circle_desc"
    t.integer  "database_id"
    t.integer  "table_id"
    t.integer  "circle_source"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "columns", :force => true do |t|
    t.string   "column_name"
    t.string   "column_type"
    t.string   "column_size"
    t.string   "column_desc"
    t.string   "column_null"
    t.string   "column_key"
    t.string   "column_default"
    t.integer  "table_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "columns", ["table_id"], :name => "index_columns_on_table_id"

  create_table "databases", :force => true do |t|
    t.string   "db_name"
    t.string   "db_project"
    t.integer  "db_user"
    t.integer  "db_pm"
    t.string   "db_desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "db_version"
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "tables", :force => true do |t|
    t.string   "table_name"
    t.string   "table_desc"
    t.integer  "database_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tables", ["database_id"], :name => "index_tables_on_database_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
